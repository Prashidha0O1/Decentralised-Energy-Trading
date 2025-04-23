package com.wattx.controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.wattx.config.DBConnecttion;
import com.wattx.model.EnergyListing;
import com.wattx.model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/dashboard" })
public class AdminDashboard extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminDashboard() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equals(user.getRole())) {
            request.setAttribute("error", "Please log in as an admin to access the dashboard.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action") != null ? request.getParameter("action").trim() : null;
        if ("edit".equals(action)) {
            int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
            EnergyListing listing = getListingById(listingId, user.getUserId());
            if (listing != null) {
                request.setAttribute("listing", listing);
            } else {
                request.setAttribute("error", "Listing not found or you don’t have permission to edit it.");
            }
        } else if ("delete".equals(action)) {
            int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
            if (!canDeleteListing(listingId)) {
                request.setAttribute("error", "Cannot delete listing because it has been sold.");
            } else {
                deleteListing(listingId, user.getUserId());
                request.setAttribute("success", "Listing deleted successfully.");
            }
        }

        List<EnergyListing> listings = getAllListings(user.getUserId());
        request.setAttribute("listings", listings);
        request.getRequestDispatcher("WEB-INF/pages/admin/admin_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equals(user.getRole())) {
            request.setAttribute("error", "Please log in as an admin to access the dashboard.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action") != null ? request.getParameter("action").trim() : null;
        if ("create".equals(action)) {
            createListing(request, user.getUserId());
        } else if ("update".equals(action)) {
            updateListing(request, user.getUserId());
        }

        List<EnergyListing> listings = getAllListings(user.getUserId());
        request.setAttribute("listings", listings);
        request.getRequestDispatcher("WEB-INF/pages/admin/admin_dashboard.jsp").forward(request, response);
    }

    private void createListing(HttpServletRequest request, int adminId) {
        String energyType = request.getParameter("energyType") != null ? request.getParameter("energyType").trim() : null;
        double quantity = 0;
        double pricePerKwh = 0;

        // Log the received parameters
        System.out.println("Creating listing with: energyType=" + energyType + ", quantity=" + quantity + ", pricePerKwh=" + pricePerKwh + ", adminId=" + adminId);

        try {
            quantity = request.getParameter("quantity") != null ? Double.parseDouble(request.getParameter("quantity")) : 0;
            pricePerKwh = request.getParameter("pricePerKwh") != null ? Double.parseDouble(request.getParameter("pricePerKwh")) : 0;
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Quantity and Price per kWh must be valid numbers.");
            System.out.println("Validation failed: " + e.getMessage());
            return;
        }

        if (energyType == null || energyType.isEmpty() || quantity <= 0 || pricePerKwh <= 0) {
            request.setAttribute("error", "All fields are required, and Quantity and Price per kWh must be positive.");
            System.out.println("Validation failed: All fields required, quantity and price must be positive");
            return;
        }

        energyType = energyType.toLowerCase();
        List<String> validEnergyTypes = List.of("solar", "wind", "hydro", "coal", "gas");
        if (!validEnergyTypes.contains(energyType)) {
            request.setAttribute("error", "Energy Type must be one of: Solar, Wind, Hydro, Coal, Gas.");
            System.out.println("Validation failed: Invalid energy type: " + energyType);
            return;
        }

        try (Connection conn = DBConnecttion.getConnection()) {
            // Ensure auto-commit is enabled
            conn.setAutoCommit(true);
            System.out.println("Auto-commit enabled: " + conn.getAutoCommit());

            String sql = "INSERT INTO energy_listings (energy_type, quantity, price_per_kwh, status, created_by) VALUES (?, ?, ?, 'available', ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, energyType);
                stmt.setDouble(2, quantity);
                stmt.setDouble(3, pricePerKwh);
                stmt.setInt(4, adminId);
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
                if (rowsAffected > 0) {
                    request.setAttribute("success", "Energy listing created successfully.");
                } else {
                    request.setAttribute("error", "Failed to create listing: No rows affected.");
                    System.out.println("No rows affected by INSERT statement.");
                }
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to create listing: " + e.getMessage());
            System.out.println("SQLException: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private List<EnergyListing> getAllListings(int adminId) {
        List<EnergyListing> listings = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT * FROM energy_listings WHERE created_by = ? ORDER BY created_at DESC";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, adminId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    EnergyListing listing = new EnergyListing();
                    listing.setListingId(rs.getInt("listing_id"));
                    listing.setEnergyType(rs.getString("energy_type"));
                    listing.setQuantity(rs.getDouble("quantity"));
                    listing.setPricePerKwh(rs.getDouble("price_per_kwh"));
                    listing.setStatus(rs.getString("status"));
                    listing.setCreatedBy(rs.getInt("created_by"));
                    listing.setCreatedAt(rs.getTimestamp("created_at"));
                    listings.add(listing);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }

    private EnergyListing getListingById(int listingId, int adminId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT * FROM energy_listings WHERE listing_id = ? AND created_by = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                stmt.setInt(2, adminId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    EnergyListing listing = new EnergyListing();
                    listing.setListingId(rs.getInt("listing_id"));
                    listing.setEnergyType(rs.getString("energy_type"));
                    listing.setQuantity(rs.getDouble("quantity"));
                    listing.setPricePerKwh(rs.getDouble("price_per_kwh"));
                    listing.setStatus(rs.getString("status"));
                    listing.setCreatedBy(rs.getInt("created_by"));
                    listing.setCreatedAt(rs.getTimestamp("created_at"));
                    return listing;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    private void updateListing(HttpServletRequest request, int adminId) {
        int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
        String energyType = request.getParameter("energyType") != null ? request.getParameter("energyType").trim() : null;
        double quantity = 0;
        double pricePerKwh = 0;

        try {
            quantity = request.getParameter("quantity") != null ? Double.parseDouble(request.getParameter("quantity")) : 0;
            pricePerKwh = request.getParameter("pricePerKwh") != null ? Double.parseDouble(request.getParameter("pricePerKwh")) : 0;
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Quantity and Price per kWh must be valid numbers.");
            return;
        }

        if (listingId <= 0 || energyType == null || energyType.isEmpty() || quantity <= 0 || pricePerKwh <= 0) {
            request.setAttribute("error", "All fields are required, and Quantity and Price per kWh must be positive.");
            return;
        }

        energyType = energyType.toLowerCase();
        List<String> validEnergyTypes = List.of("solar", "wind", "hydro", "coal", "gas");
        if (!validEnergyTypes.contains(energyType)) {
            request.setAttribute("error", "Energy Type must be one of: Solar, Wind, Hydro, Coal, Gas.");
            return;
        }

        if (!canUpdateListing(listingId)) {
            request.setAttribute("error", "Cannot update listing because it has been sold.");
            return;
        }

        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "UPDATE energy_listings SET energy_type = ?, quantity = ?, price_per_kwh = ? WHERE listing_id = ? AND created_by = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, energyType);
                stmt.setDouble(2, quantity);
                stmt.setDouble(3, pricePerKwh);
                stmt.setInt(4, listingId);
                stmt.setInt(5, adminId);
                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    request.setAttribute("success", "Energy listing updated successfully.");
                } else {
                    request.setAttribute("error", "Listing not found or you don’t have permission to update it.");
                }
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to update listing: " + e.getMessage());
        }
    }

    private void deleteListing(int listingId, int adminId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "DELETE FROM energy_listings WHERE listing_id = ? AND created_by = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                stmt.setInt(2, adminId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private boolean canUpdateListing(int listingId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT status FROM energy_listings WHERE listing_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return "available".equals(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean canDeleteListing(int listingId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT COUNT(*) FROM transactions WHERE listing_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}