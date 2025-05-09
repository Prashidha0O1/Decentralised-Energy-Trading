package com.wattx.controller;

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
import java.util.UUID;

@WebServlet(asyncSupported = true, urlPatterns = { "/updateProfile" })
public class UpdateProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = SessionUtil.getLoggedInUser(request);

        if (session == null || user == null) {
            System.out.println("UpdateProfileServlet: No user session found, redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Redirect to profile page if accessed via GET
        System.out.println("UpdateProfileServlet: GET request received, redirecting to /profile");
        response.sendRedirect(request.getContextPath() + "/profile");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = SessionUtil.getLoggedInUser(request);

        // Check if user is authenticated
        if (session == null || user == null) {
            System.out.println("⛔ Unauthorized access to /updateProfile. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // CSRF token validation
        String submittedToken = request.getParameter("csrfToken");
        String sessionToken = (String) session.getAttribute("csrfToken");
        if (submittedToken == null || !submittedToken.equals(sessionToken)) {
            System.out.println("❌ CSRF token validation failed.");
            request.setAttribute("error", "Invalid request. Please try again.");
            request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
            return;
        }

        String username = request.getParameter("username");
        String email = request.getParameter("email");

        // Input validation
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Username cannot be empty.");
            request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
            return;
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
            return;
        }

        // Check for duplicate username or email (excluding current user)
        try (Connection conn = DBConnecttion.getConnection()) {
            String checkSql = "SELECT user_id FROM users WHERE (username = ? OR email = ?) AND user_id != ?";
            try (PreparedStatement stmt = conn.prepareStatement(checkSql)) {
                stmt.setString(1, username.trim());
                stmt.setString(2, email.trim());
                stmt.setInt(3, user.getUserId());
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("error", "Username or email is already in use.");
                    request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
                    return;
                }
            }

            // Update user profile
            String updateSql = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                stmt.setString(1, username.trim());
                stmt.setString(2, email.trim());
                stmt.setInt(3, user.getUserId());
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Update session user
                    user.setUsername(username.trim());
                    user.setEmail(email.trim());
                    session.setAttribute("user", user);
                    // Generate new CSRF token for next request
                    session.setAttribute("csrfToken", UUID.randomUUID().toString());
                    request.setAttribute("success", "Profile updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update profile. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("❌ Error updating user profile: " + e.getMessage());
            request.setAttribute("error", "Database error occurred while updating profile.");
        }

        // Forward back to portfolio page
        request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
    }
}