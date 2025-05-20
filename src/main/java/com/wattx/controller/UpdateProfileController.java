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

// Servlet annotation to map UpdateProfileController to "/updateProfile" URL with async support
@WebServlet(asyncSupported = true, urlPatterns = { "/updateProfile" })
public class UpdateProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests for the profile update page.
     * Redirects to the profile page or login page if the user is not authenticated.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve session and authenticated user
        HttpSession session = request.getSession(false);
        User user = SessionUtil.getLoggedInUser(request);

        // Redirect to login if user is not authenticated
        if (session == null || user == null) {
            System.out.println("UpdateProfileServlet: No user session found, redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Redirect to profile page for GET requests
        System.out.println("UpdateProfileServlet: GET request received, redirecting to /profile");
        response.sendRedirect(request.getContextPath() + "/profile");
    }

    /**
     * Handles POST requests to update a user's profile.
     * Validates CSRF token, input data, and checks for duplicate username/email before updating.
     *
     * @param request  The HTTP request object containing form data
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve session and authenticated user
        HttpSession session = request.getSession(false);
        User user = SessionUtil.getLoggedInUser(request);

        // Redirect to login if user is not authenticated
        if (session == null || user == null) {
            System.out.println("⛔ Unauthorized access to /updateProfile. Redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Validate CSRF token to prevent cross-site request forgery
        String submittedToken = request.getParameter("csrfToken");
        String sessionToken = (String) session.getAttribute("csrfToken");
        if (submittedToken == null || !submittedToken.equals(sessionToken)) {
            System.out.println("❌ CSRF token validation failed.");
            request.setAttribute("error", "Invalid request. Please try again.");
            request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
            return;
        }

        // Retrieve and validate form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");

        // Validate username
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Username cannot be empty.");
            request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
            return;
        }

        // Validate email format
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
            return;
        }

        // Check for duplicate username or email (excluding current user)
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to check for existing username or email
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

            // Update user profile in the database
            String updateSql = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                stmt.setString(1, username.trim());
                stmt.setString(2, email.trim());
                stmt.setInt(3, user.getUserId());
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Update session with new user data
                    user.setUsername(username.trim());
                    user.setEmail(email.trim());
                    session.setAttribute("user", user);
                    // Generate new CSRF token for security
                    session.setAttribute("csrfToken", UUID.randomUUID().toString());
                    request.setAttribute("success", "Profile updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update profile. Please try again.");
                }
            }
        } catch (SQLException e) {
            // Log and handle database errors
            e.printStackTrace();
            System.out.println("❌ Error updating user profile: " + e.getMessage());
            request.setAttribute("error", "Database error occurred while updating profile.");
        }

        // Forward to portfolio page with result
        request.getRequestDispatcher("WEB-INF/pages/client/client_portfolio.jsp").forward(request, response);
    }
}