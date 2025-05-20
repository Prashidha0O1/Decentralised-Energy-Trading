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

/*
 * @author Prashidha Rawal 23048617
 * */
// Servlet annotation to map the AdminDashboard to "/dashboard" URL with async support
@WebServlet(asyncSupported = true, urlPatterns = { "/dashboard" })
public class AdminDashboard extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    // Default constructor
    public AdminDashboard() {
        super();
    }

    /**
     * Handles GET requests for the admin dashboard, supporting listing retrieval, editing, and deletion.
     * Redirects to login if the user is not an admin.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve session and user object
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Check if user is an admin; redirect to login if not
        if (user == null || !"admin".equals(user.getRole())) {
            request.setAttribute("error", "Please log in as an admin to access the dashboard.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        // Handle action parameter for editing or deleting listings
        String action = request.getParameter("action") != null ? request.getParameter("action").trim() : null;
        if ("edit".equals(action)) {
            // Retrieve listing for editing
            int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
            EnergyListing listing = getListingById(listingId, user.getUserId());
            if (listing != null) {
                request.setAttribute("listing", listing);
            } else {
                request.setAttribute("error", "Listing not found or you don’t have permission to edit it.");
            }
        } else if ("delete".equals(action)) {
            // Delete listing if it hasn't been sold
            int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
            if (!canDeleteListing(listingId)) {
                request.setAttribute("error", "Cannot delete listing because it has been sold.");
            } else {
                deleteListing(listingId, user.getUserId());
                request.setAttribute("success", "Listing deleted successfully.");
            }
        }

        // Fetch all listings for the admin and forward to the dashboard JSP
        List<EnergyListing> listings = getAllListings(user.getUserId());
        request.setAttribute("listings", listings);
        request.getRequestDispatcher("WEB-INF/pages/admin/admin_dashboard.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for creating or updating energy listings.
     * Redirects to login if the user is not an admin.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve session and user object
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Check if user is an admin; redirect to login if not
        if (user == null || !"admin".equals(user.getRole())) {
            request.setAttribute("error", "Please log in as an admin to access the dashboard.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        // Handle action parameter for creating or updating listings
        String action = request.getParameter("action") != null ? request.getParameter("action").trim() : null;
        if ("create".equals(action)) {
            createListing(request, user.getUserId());
        } else if ("update".equals(action)) {
            updateListing(request, user.getUserId());
        }

        // Fetch all listings and forward to the dashboard JSP
        List<EnergyListing> listings = getAllListings(user.getUserId());
        request.setAttribute("listings", listings);
        request.getRequestDispatcher("WEB-INF/pages/admin/admin_dashboard.jsp").forward(request, response);
    }

    /**
     * Creates a new energy listing based on form input.
     * Validates input and inserts the listing into the database.
     *
     * @param request The HTTP request containing form data
     * @param adminId The ID of the admin creating the listing
     */
    private void createListing(HttpServletRequest request, int adminId) {
        // Retrieve and validate form parameters
        String energyType = request.getParameter("energyType") != null ? request.getParameter("energyType").trim() : null;
        double quantity = 0;
        double pricePerKwh = 0;

        // Log input parameters for debugging
        System.out.println("Creating listing with: energyType=" + energyType + ", quantity=" + quantity + ", pricePerKwh=" + pricePerKwh + ", adminId=" + adminId);

        // Parse numeric inputs and handle invalid formats
        try {
            quantity = request.getParameter("quantity") != null ? Double.parseDouble(request.getParameter("quantity")) : 0;
            pricePerKwh = request.getParameter("pricePerKwh") != null ? Double.parseDouble(request.getParameter("pricePerKwh")) : 0;
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Quantity and Price per kWh must be valid numbers.");
            System.out.println("Validation failed: " + e.getMessage());
            return;
        }

        // Validate required fields and positive values
        if (energyType == null || energyType.isEmpty() || quantity <= 0 || pricePerKwh <= 0) {
            request.setAttribute("error", "All fields are required, and Quantity and Price per kWh must be positive.");
            System.out.println("Validation failed: All fields required, quantity and price must be positive");
            return;
        }

        // Normalize and validate energy type
        energyType = energyType.toLowerCase();
        List<String> validEnergyTypes = List.of("solar", "wind", "hydro", "coal", "gas");
        if (!validEnergyTypes.contains(energyType)) {
            request.setAttribute("error", "Energy Type must be one of: Solar, Wind, Hydro, Coal, Gas.");
            System.out.println("Validation failed: Invalid energy type: " + energyType);
            return;
        }

        // Insert the new listing into the database
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

    /**
     * Retrieves all energy listings created by the specified admin, sorted by creation date.
     *
     * @param adminId The ID of the admin whose listings are retrieved
     * @return A list of EnergyListing objects
     */
    private List<EnergyListing> getAllListings(int adminId) {
        List<EnergyListing> listings = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to fetch all listings for the admin
            String sql = "SELECT * FROM energy_listings WHERE created_by = ? ORDER BY created_at DESC";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, adminId);
                ResultSet rs = stmt.executeQuery();
                // Map result set to EnergyListing objects
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
            // Log database errors
            e.printStackTrace();
        }
        return listings;
    }

    /**
     * Retrieves a specific energy listing by ID, ensuring it belongs to the specified admin.
     *
     * @param listingId The ID of the listing to retrieve
     * @param adminId   The ID of the admin who created the listing
     * @return The EnergyListing object, or null if not found or unauthorized
     */
    private EnergyListing getListingById(int listingId, int adminId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to fetch a specific listing
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
            // Log database errors
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Updates an existing energy listing based on form input.
     * Validates input and ensures the listing is editable.
     *
     * @param request The HTTP request containing form data
     * @param adminId The ID of the admin updating the listing
     */
    private void updateListing(HttpServletRequest request, int adminId) {
        // Retrieve and validate form parameters
        int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
        String energyType = request.getParameter("energyType") != null ? request.getParameter("energyType").trim() : null;
        double quantity = 0;
        double pricePerKwh = 0;

        // Parse numeric inputs and handle invalid formats
        try {
            quantity = request.getParameter("quantity") != null ? Double.parseDouble(request.getParameter("quantity")) : 0;
            pricePerKwh = request.getParameter("pricePerKwh") != null ? Double.parseDouble(request.getParameter("pricePerKwh")) : 0;
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Quantity and Price per kWh must be valid numbers.");
            return;
        }

        // Validate required fields and positive values
        if (listingId <= 0 || energyType == null || energyType.isEmpty() || quantity <= 0 || pricePerKwh <= 0) {
            request.setAttribute("error", "All fields are required, and Quantity and Price per kWh must be positive.");
            return;
        }

        // Normalize and validate energy type
        energyType = energyType.toLowerCase();
        List<String> validEnergyTypes = List.of("solar", "wind", "hydro", "coal", "gas");
        if (!validEnergyTypes.contains(energyType)) {
            request.setAttribute("error", "Energy Type must be one of: Solar, Wind, Hydro, Coal, Gas.");
            return;
        }

        // Check if the listing can be updated (not sold)
        if (!canUpdateListing(listingId)) {
            request.setAttribute("error", "Cannot update listing because it has been sold.");
            return;
        }

        // Update the listing in the database
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

    /**
     * Deletes an energy listing from the database if it belongs to the specified admin.
     *
     * @param listingId The ID of the listing to delete
     * @param adminId   The ID of the admin performing the deletion
     */
    private void deleteListing(int listingId, int adminId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to delete a specific listing
            String sql = "DELETE FROM energy_listings WHERE listing_id = ? AND created_by = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                stmt.setInt(2, adminId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            // Log database errors
            e.printStackTrace();
        }
    }

    /**
     * Checks if a listing can be updated (i.e., its status is 'available').
     *
     * @param listingId The ID of the listing to check
     * @return True if the listing is available for update, false otherwise
     */
    private boolean canUpdateListing(int listingId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to check the status of the listing
            String sql = "SELECT status FROM energy_listings WHERE listing_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return "available".equals(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            // Log database errors
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Checks if a listing can be deleted (i.e., it has no associated transactions).
     *
     * @param listingId The ID of the listing to check
     * @return True if the listing can be deleted, false if it has transactions
     */
    private boolean canDeleteListing(int listingId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to check for transactions linked to the listing
            String sql = "SELECT COUNT(*) FROM transactions WHERE listing_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) == 0; // Return true if no transactions exist
                }
            }
        } catch (SQLException e) {
            // Log database errors
            e.printStackTrace();
        }
        return false;
    }
}