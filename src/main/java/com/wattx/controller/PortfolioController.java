package com.wattx.controller;

import com.wattx.model.Transaction;
import com.wattx.model.User;
import com.wattx.config.DBConnecttion;
import com.wattx.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

// Servlet annotation to map PortfolioController to "/profile" URL with async support
@WebServlet(asyncSupported = true, urlPatterns = { "/profile" })
public class PortfolioController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests for the customer portfolio page.
     * Displays user details and transaction history, with authentication and role checks.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve session
        HttpSession session = request.getSession(false);
        System.out.println("PortfolioController: Session exists = " + (session != null));

        // Check for authenticated user
        User user = null;
        if (session != null) {
            System.out.println("PortfolioController: User in session = " + (session.getAttribute("user") != null));
            user = SessionUtil.getLoggedInUser(request);
            if (user != null) {
                System.out.println("✅ User authenticated via session: " + user.getUsername());
            } else {
                System.out.println("⚠️ No user found in session.");
            }
        } else {
            System.out.println("⚠️ No session found.");
        }

        // Redirect to login if user is not authenticated
        if (user == null) {
            System.out.println("⛔ Unauthorized access to /profile. Redirecting to login.");
            String redirectURL = request.getContextPath() + "/profile";
            session = request.getSession(true); // Create new session
            SessionUtil.setAttribute(request, "redirectURL", redirectURL);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Verify user role (customer only)
        if (!"customer".equals(user.getRole())) {
            System.out.println("PortfolioController: User role is " + user.getRole() + ", redirecting to login");
            request.setAttribute("error", "You do not have permission to access this page.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        try {
            // Fetch fresh user details from database
            user = getUserByUsername(user.getUsername());
            if (user != null) {
                System.out.println("✅ Fetched user details for: " + user.getUsername());
                session.setAttribute("user", user); // Update session with fresh data
                request.setAttribute("user", user);
            } else {
                System.out.println("⚠️ No user found with username: " + user.getUsername());
                request.setAttribute("error", "User not found.");
                session.invalidate(); // Clear session
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Fetch user's transaction history
            List<Transaction> transactions = getUserTransactions(user.getUserId());
            request.setAttribute("transactions", transactions);
        } catch (Exception e) {
            // Log and handle errors
            e.printStackTrace();
            System.out.println("❌ Error retrieving user details or transactions: " + e.getMessage());
            request.setAttribute("error", "Error retrieving portfolio data: " + e.getMessage());
        }

        // Clear redirectURL to prevent redirection loops
        if (session.getAttribute("redirectURL") != null) {
            System.out.println("PortfolioController: Clearing redirectURL from session.");
            session.removeAttribute("redirectURL");
        }

        // Forward to portfolio JSP
        request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for the portfolio page.
     * Delegates to doGet to display the portfolio page.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Delegate to doGet for consistent behavior
        doGet(request, response);
    }

    /**
     * Retrieves user details from the database by username.
     *
     * @param username The username of the user to retrieve
     * @return A User object with the retrieved details, or null if not found or an error occurs
     */
    private User getUserByUsername(String username) {
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to fetch user by username
            String sql = "SELECT * FROM users WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    // Map result set to User object
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (SQLException e) {
            // Log database errors
            e.printStackTrace();
            System.out.println("❌ Error fetching user by username: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retrieves a user's transaction history from the database.
     *
     * @param userId The ID of the user whose transactions are retrieved
     * @return A list of Transaction objects
     */
    private List<Transaction> getUserTransactions(int userId) {
        List<Transaction> transactions = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to fetch transactions by user email, joining with energy_listings
            String sql = "SELECT t.*, el.energy_type FROM transactions t " +
                        "JOIN energy_listings el ON t.listing_id = el.listing_id " +
                        "WHERE t.buyer_email = (SELECT email FROM users WHERE user_id = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                // Map result set to Transaction objects
                while (rs.next()) {
                    Transaction transaction = new Transaction();
                    transaction.setTransactionId(rs.getInt("transaction_id"));
                    transaction.setListingId(rs.getInt("listing_id"));
                    transaction.setEnergyType(rs.getString("energy_type"));
                    transaction.setBuyerEmail(rs.getString("buyer_email"));
                    transaction.setQuantity(rs.getDouble("quantity"));
                    transaction.setTotalPrice(rs.getDouble("total_price"));
                    transaction.setTransactionDate(rs.getTimestamp("transaction_date"));
                    transactions.add(transaction);
                }
            }
        } catch (SQLException e) {
            // Log database errors
            e.printStackTrace();
            System.out.println("❌ Error fetching transactions: " + e.getMessage());
        }
        return transactions;
    }
}