package com.wattx.controller;

import com.wattx.config.DBConnecttion;
import com.wattx.model.User;
import com.wattx.util.PasswordUtil;
import com.wattx.util.SessionUtil;

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

/*
 * @author Prashidha Rawal 23048617
 * */


// Servlet annotation to map AdminProfileController to "/admin-profile" URL with async support
@WebServlet(asyncSupported = true, urlPatterns = { "/admin-profile" })
public class AdminProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests to display the admin profile page.
     * Redirects to login if the user is not logged in or not an admin.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Retrieve logged-in user from session
        User user = SessionUtil.getLoggedInUser(request);
        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
            // Fetch user details from the database
            User dbUser = getUserById(user.getUserId());
            if (dbUser != null) {
                request.setAttribute("user", dbUser); // Set user data for JSP
            } else {
                request.setAttribute("error", "User data not found in database.");
            }
        } else {
            // Redirect to login with unauthorized error if not an admin
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        // Forward to admin profile JSP, handle any forwarding errors
        try {
            request.getRequestDispatcher("/WEB-INF/pages/admin/admin_profile.jsp").forward(request, response);
        } catch (Exception e) {
            response.getWriter().write("Error forwarding to JSP: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Handles POST requests to update the admin's profile (username, email, or password).
     * Redirects to login if the user is not logged in or not an admin.
     *
     * @param request  The HTTP request containing form data
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        if (!SessionUtil.isLoggedIn(request)) {
            System.out.println("Session check failed: User not logged in.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Retrieve logged-in user and verify admin role
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            System.out.println("Authorization failed: User is " + (user == null ? "null" : user.getRole()));
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        // Retrieve form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Update user profile in the database
        try (Connection conn = DBConnecttion.getConnection()) {
            // Update username and email
            String sql = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, email);
                stmt.setInt(3, user.getUserId());
                stmt.executeUpdate();
            }

            // Update password if provided
            if (password != null && !password.isEmpty()) {
                String updatePasswordSql = "UPDATE users SET password = ? WHERE user_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updatePasswordSql)) {
                    stmt.setString(1, PasswordUtil.hashPassword(password)); // Hash the new password
                    stmt.setInt(2, user.getUserId());
                    stmt.executeUpdate();
                }
            }
            request.setAttribute("success", "Profile updated successfully.");
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to update profile: " + e.getMessage());
        }

        // Fetch updated user data and set for JSP
        User updatedUser = getUserById(user.getUserId());
        request.setAttribute("user", updatedUser);

        // Forward to admin profile JSP, handle any forwarding errors
        try {
            request.getRequestDispatcher("/WEB-INF/pages/admin/admin_profile.jsp").forward(request, response);
        } catch (Exception e) {
            response.getWriter().write("Error forwarding to JSP: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Retrieves a user's details from the database by their user ID.
     *
     * @param userId The ID of the user to retrieve
     * @return A User object with the retrieved details, or null if not found or an error occurs
     */
    private User getUserById(int userId) {
        User user = null;
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to fetch user details by ID
            String sql = "SELECT * FROM users WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    // Map result set to User object
                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (SQLException e) {
            // Log database errors
            e.printStackTrace();
        }
        return user;
    }
}