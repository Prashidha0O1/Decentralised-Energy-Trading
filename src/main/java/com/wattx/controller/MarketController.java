package com.wattx.controller;

import com.wattx.model.EnergyListing;
import com.wattx.util.DBConnecttion;
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

@WebServlet(asyncSupported = true, urlPatterns = { "/market" })
public class MarketController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action").trim() : null;

        if ("buy".equals(action)) {
            int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
            EnergyListing listing = getListingById(listingId);
            if (listing != null && "available".equals(listing.getStatus())) {
                request.setAttribute("listing", listing);
            } else {
                request.setAttribute("error", "Listing not available for purchase.");
            }
        }

        List<EnergyListing> availableListings = getAvailableListings();
        request.setAttribute("listings", availableListings);
        request.getRequestDispatcher("WEB-INF/pages/client/ market.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action").trim() : null;

        if ("purchase".equals(action)) {
            handlePurchase(request);
        }

        List<EnergyListing> availableListings = getAvailableListings();
        request.setAttribute("listings", availableListings);
        request.getRequestDispatcher("WEB-INF/pages/energy_market.jsp").forward(request, response);
    }

    private List<EnergyListing> getAvailableListings() {
        List<EnergyListing> listings = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT * FROM energy_listings WHERE status = 'available'";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();
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
            e.printStackTrace();
        }
        return listings;
    }

    private EnergyListing getListingById(int listingId) {
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT * FROM energy_listings WHERE listing_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, listingId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
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
            e.printStackTrace();
        }
        return null;
    }

    private void handlePurchase(HttpServletRequest request) {
        int listingId = request.getParameter("listingId") != null ? Integer.parseInt(request.getParameter("listingId")) : 0;
        String buyerEmail = request.getParameter("buyerEmail") != null ? request.getParameter("buyerEmail").trim() : null;

        if (listingId <= 0 || buyerEmail == null || buyerEmail.isEmpty() || !buyerEmail.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("error", "Invalid listing ID or email address.");
            return;
        }

        EnergyListing listing = getListingById(listingId);
        if (listing == null || !"available".equals(listing.getStatus())) {
            request.setAttribute("error", "Listing not available for purchase.");
            return;
        }

        double quantity = listing.getQuantity();
        double pricePerKwh = listing.getPricePerKwh();
        double totalPrice = quantity * pricePerKwh;

        try (Connection conn = DBConnecttion.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Insert into transactions table
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

                conn.commit();
                request.setAttribute("success", "Purchase completed successfully!");
            } catch (SQLException e) {
                conn.rollback();
                request.setAttribute("error", "Failed to complete purchase: " + e.getMessage());
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
    }
}