package com.wattx.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.wattx.model.EnergyListing;
import com.wattx.model.User;
import com.wattx.util.DBConnecttion;
import com.wattx.util.ServletUtility;

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
        // Check if user is logged in and is an admin
        User user = (User) ServletUtility.getUserFromSession(request);
        if (user == null || !"admin".equals(user.getRole())) {
            ServletUtility.setErrorMessage("Please log in as an admin.", request);
            ServletUtility.forward("LOGIN.jsp", request, response);
            return;
        }

        // Handle actions (view, edit, delete)
        String action = ServletUtility.getParameter("action", request);
        if ("edit".equals(action)) {
            int listingId = ServletUtility.getIntParameter("listingId", request, 0);
            EnergyListing listing = getListingById(listingId, user.getUserId());
            if (listing != null) {
                request.setAttribute("listing", listing);
            } else {
                ServletUtility.setErrorMessage("Listing not found.", request);
            }
        } else if ("delete".equals(action)) {
            int listingId = ServletUtility.getIntParameter("listingId", request, 0);
            deleteListing(listingId, user.getUserId());
            ServletUtility.setSuccessMessage("Listing deleted successfully.", request);
        }

        // Fetch all listings for the admin
        List<EnergyListing> listings = getAllListings(user.getUserId());
        request.setAttribute("listings", listings);
        ServletUtility.forward("admin/admin_dashboard.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        User user = (User) ServletUtility.getUserFromSession(request);
        if (user == null || !"admin".equals(user.getRole())) {
            ServletUtility.setErrorMessage("Please log in as an admin.", request);
            ServletUtility.forward("LOGIN.jsp", request, response);
            return;
        }

        // Handle create or update
        String action = ServletUtility.getParameter("action", request);
        if ("create".equals(action)) {
            createListing(request, user.getUserId());
        } else if ("update".equals(action)) {
            updateListing(request, user.getUserId());
        }

        // Refresh the listings
        List<EnergyListing> listings = getAllListings(user.getUserId());
        request.setAttribute("listings", listings);
        ServletUtility.forward("admin/admin_dashboard.jsp", request, response);
    }

    private List<EnergyListing> getAllListings(int adminId) {
        List<EnergyListing> listings = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT * FROM energy_listings WHERE created_by = ?";
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

    private void createListing(HttpServletRequest request, int adminId) {
        String energyType = ServletUtility.getParameter("energyType", request);
        double quantity = ServletUtility.getIntParameter("quantity", request, 0);
        double pricePerKwh = ServletUtility.getIntParameter("pricePerKwh", request, 0);

        if (energyType == null || energyType.isEmpty() || quantity <= 0 || pricePerKwh <= 0) {
            ServletUtility.setErrorMessage("All fields are required and must be valid.", request);
            return;
        }

        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "INSERT INTO energy_listings (energy_type, quantity, price_per_kwh, status, created_by) VALUES (?, ?, ?, 'available', ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, energyType);
                stmt.setDouble(2, quantity);
                stmt.setDouble(3, pricePerKwh);
                stmt.setInt(4, adminId);
                stmt.executeUpdate();
                ServletUtility.setSuccessMessage("Listing created successfully.", request);
            }
        } catch (SQLException e) {
            ServletUtility.setErrorMessage("Failed to create listing: " + e.getMessage(), request);
        }
    }

    private void updateListing(HttpServletRequest request, int adminId) {
        int listingId = ServletUtility.getIntParameter("listingId", request, 0);
        String energyType = ServletUtility.getParameter("energyType", request);
        double quantity = ServletUtility.getIntParameter("quantity", request, 0);
        double pricePerKwh = ServletUtility.getIntParameter("pricePerKwh", request, 0);

        if (listingId <= 0 || energyType == null || energyType.isEmpty() || quantity <= 0 || pricePerKwh <= 0) {
            ServletUtility.setErrorMessage("All fields are required and must be valid.", request);
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
                    ServletUtility.setSuccessMessage("Listing updated successfully.", request);
                } else {
                    ServletUtility.setErrorMessage("Listing not found or you don’t have permission to update it.", request);
                }
            }
        } catch (SQLException e) {
            ServletUtility.setErrorMessage("Failed to update listing: " + e.getMessage(), request);
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
}