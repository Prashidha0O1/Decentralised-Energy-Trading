package com.wattx.controller;

import com.wattx.config.DBConnecttion;
import com.wattx.model.EnergyListing;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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

// Servlet annotation to map MarketController to "/market" URL with async support
@WebServlet(asyncSupported = true, urlPatterns = { "/market" })
public class MarketController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests for the market page.
     * Supports listing retrieval, searching by energy type, and preparing a listing for purchase.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve action parameter
        String action = request.getParameter("action") != null ? request.getParameter("action").trim() : null;
        List<EnergyListing> listings;

        // Handle different actions
        if ("search".equals(action)) {
            // Search listings by energy type
            String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
            listings = searchEnergyTradebyName(name);
        } else if ("buy".equals(action)) {
            // Prepare a specific listing for purchase
            int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
            EnergyListing listing = getListingById(listingId);
            if (listing != null && "available".equals(listing.getStatus())) {
                request.setAttribute("listing", listing); // Set listing for JSP
            } else {
                request.setAttribute("error", "Listing not available for purchase.");
            }
            listings = getAvailableListings();
        } else {
            // Default: fetch all available listings
            listings = getAvailableListings();
        }

        // Set listings for JSP and forward to market page
        request.setAttribute("listings", listings);
        request.getRequestDispatcher("WEB-INF/pages/client/market.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for the market page.
     * Processes purchase actions and displays available listings.
     *
     * @param request  The HTTP request object containing form data
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve action parameter
        String action = request.getParameter("action") != null ? request.getParameter("action").trim() : null;

        // Handle purchase action
        if ("purchase".equals(action)) {
            handlePurchase(request);
        }

        // Fetch available listings and forward to market page
        List<EnergyListing> availableListings = getAvailableListings();
        request.setAttribute("listings", availableListings);
        request.getRequestDispatcher("WEB-INF/pages/client/market.jsp").forward(request, response);
    }

    /**
     * Retrieves all available energy listings from the database.
     *
     * @return A list of available EnergyListing objects
     */
    private List<EnergyListing> getAvailableListings() {
        List<EnergyListing> listings = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to fetch available listings
            String sql = "SELECT * FROM energy_listings WHERE status = 'available'";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();
                // Map result set to EnergyListing objects
                while (rs.next()) {
                    EnergyListing listing = new EnergyListing();
                    listing.setListingId(rs.getInt("listing_id"));
                    listing.setEnergyType(rs.getString("energy_type"));
                    listing.setQuantity(rs.getDouble("quantity"));
                    listing.setPricePerKwh(rs.getDouble("price_per_kwh"));
                    listing.setStatus(rs.getString("status"));
                    listing.setCreatedAt(rs.getTimestamp("created_at"));
                    listing.setCreatedBy(rs.getInt("created_by"));
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
     * Retrieves a specific energy listing by its ID.
     *
     * @param listingId The ID of the listing to retrieve
     * @return The EnergyListing object, or null if not found or an error occurs
     */
    private EnergyListing getListingById(int listingId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to fetch a specific listing
            String sql = "SELECT * FROM energy_listings WHERE listing_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    // Map result set to EnergyListing object
                    EnergyListing listing = new EnergyListing();
                    listing.setListingId(rs.getInt("listing_id"));
                    listing.setEnergyType(rs.getString("energy_type"));
                    listing.setQuantity(rs.getDouble("quantity"));
                    listing.setPricePerKwh(rs.getDouble("price_per_kwh"));
                    listing.setStatus(rs.getString("status"));
                    listing.setCreatedAt(rs.getTimestamp("created_at"));
                    listing.setCreatedBy(rs.getInt("created_by"));
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
     * Searches for available energy listings by energy type.
     *
     * @param name The energy type to search for (case-insensitive)
     * @return A list of matching EnergyListing objects
     */
    private List<EnergyListing> searchEnergyTradebyName(String name) {
        List<EnergyListing> listings = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to search available listings by energy type
            String sql = "SELECT * FROM energy_listings WHERE status = 'available' AND LOWER(energy_type) LIKE ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, "%" + name.toLowerCase() + "%");
                ResultSet rs = stmt.executeQuery();
                // Map result set to EnergyListing objects
                while (rs.next()) {
                    EnergyListing listing = new EnergyListing();
                    listing.setListingId(rs.getInt("listing_id"));
                    listing.setEnergyType(rs.getString("energy_type"));
                    listing.setQuantity(rs.getDouble("quantity"));
                    listing.setPricePerKwh(rs.getDouble("price_per_kwh"));
                    listing.setStatus(rs.getString("status"));
                    listing.setCreatedAt(rs.getTimestamp("created_at"));
                    listing.setCreatedBy(rs.getInt("created_by"));
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
     * Handles the purchase of an energy listing.
     * Validates input, records the transaction, and updates the listing status.
     *
     * @param request The HTTP request containing purchase details
     */
    private void handlePurchase(HttpServletRequest request) {
        // Retrieve and validate purchase parameters
        int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
        String buyerEmail = request.getParameter("buyerEmail") != null ? request.getParameter("buyerEmail").trim() : null;

        // Validate listing ID and email format
        if (listingId <= 0 || buyerEmail == null || buyerEmail.isEmpty() || 
            !buyerEmail.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("error", "Invalid listing ID or email address.");
            return;
        }

        // Verify listing availability
        EnergyListing listing = getListingById(listingId);
        if (listing == null || !"available".equals(listing.getStatus())) {
            request.setAttribute("error", "Listing not available for purchase.");
            return;
        }

        // Calculate total price
        double quantity = listing.getQuantity();
        double pricePerKwh = listing.getPricePerKwh();
        double totalPrice = quantity * pricePerKwh;

        // Process transaction in the database
        try (Connection conn = DBConnecttion.getConnection()) {
            conn.setAutoCommit(false); // Begin transaction
            try {
                // Insert transaction record
                String insertSql = "INSERT INTO transactions (listing_id, buyer_email, quantity, total_price, transaction_date) VALUES (?, ?, ?, ?, NOW())";
                try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                    stmt.setInt(1, listingId);
                    stmt.setString(2, buyerEmail);
                    stmt.setDouble(3, quantity);
                    stmt.setDouble(4, totalPrice);
                    stmt.executeUpdate();
                }

                // Update listing status to 'sold'
                String updateSql = "UPDATE energy_listings SET status = 'sold' WHERE listing_id = ? AND status = 'available'";
                try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                    stmt.setInt(1, listingId);
                    int rows = stmt.executeUpdate();
                    if (rows == 0) {
                        throw new SQLException("Listing was not available or already sold.");
                    }
                }

                // Commit transaction
                conn.commit();
                request.setAttribute("success", "Purchase completed successfully!");
            } catch (SQLException e) {
                // Roll back transaction on error
                conn.rollback();
                request.setAttribute("error", "Failed to complete purchase: " + e.getMessage());
            } finally {
                // Restore auto-commit
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            // Handle connection errors
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
    }
}