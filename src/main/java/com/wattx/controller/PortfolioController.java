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

@WebServlet(asyncSupported = true, urlPatterns = { "/profile" })
public class PortfolioController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        System.out.println("PortfolioController: Session exists = " + (session != null));

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

        // If user is not authenticated, redirect to login
        if (user == null) {
            System.out.println("⛔ Unauthorized access to /profile. Redirecting to login.");
            String redirectURL = request.getContextPath() + "/profile";
            session = request.getSession(true); // Create a new session if it doesn't exist
            SessionUtil.setAttribute(request, "redirectURL", redirectURL);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Role check
        if (!"customer".equals(user.getRole())) {
            System.out.println("PortfolioController: User role is " + user.getRole() + ", redirecting to login");
            request.setAttribute("error", "You do not have permission to access this page.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        try {
            // Fetch user details directly from the database to ensure freshness
            user = getUserByUsername(user.getUsername());
            if (user != null) {
                System.out.println("✅ Fetched user details for: " + user.getUsername());
                session.setAttribute("user", user); // Update session with fresh user data
                request.setAttribute("user", user);
            } else {
                System.out.println("⚠️ No user found with username: " + user.getUsername());
                request.setAttribute("error", "User not found.");
                session.invalidate(); // Invalidate session if user not found
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Fetch transaction history
            List<Transaction> transactions = getUserTransactions(user.getUserId());
            request.setAttribute("transactions", transactions);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Error retrieving user details or transactions: " + e.getMessage());
            request.setAttribute("error", "Error retrieving portfolio data: " + e.getMessage());
        }

        // Clear redirectURL if present to prevent loops
        if (session.getAttribute("redirectURL") != null) {
            System.out.println("PortfolioController: Clearing redirectURL from session.");
            session.removeAttribute("redirectURL");
        }

        request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private User getUserByUsername(String username) {
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("❌ Error fetching user by username: " + e.getMessage());
        }
        return null;
    }

    private List<Transaction> getUserTransactions(int userId) {
        List<Transaction> transactions = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT t.*, el.energy_type FROM transactions t " +
                        "JOIN energy_listings el ON t.listing_id = el.listing_id " +
                        "WHERE t.buyer_email = (SELECT email FROM users WHERE user_id = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
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
            e.printStackTrace();
            System.out.println("❌ Error fetching transactions: " + e.getMessage());
        }
        return transactions;
    }
}