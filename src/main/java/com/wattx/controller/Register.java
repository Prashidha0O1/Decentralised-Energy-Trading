package com.wattx.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.wattx.config.DBConnecttion;
import com.wattx.util.PasswordUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


// Servlet annotation to map Register servlet to "/register" and "/create-wallet" URLs with async support
@WebServlet(
        asyncSupported = true, 
        urlPatterns = { "/register", "/create-wallet" })
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests for the registration page.
     * Forwards the request to the register.jsp page for rendering.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward request to the registration JSP page
        request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for user registration.
     * Validates input, checks for duplicate email/username, and registers a new user.
     *
     * @param request  The HTTP request object containing form data
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve and trim form parameters
        String username = request.getParameter("username") != null ? request.getParameter("username").trim() : null;
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : null;
        String role = request.getParameter("role") != null ? request.getParameter("role").trim() : null;
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : null;

        // Validate input fields and role
        if (username == null || username.isEmpty() || password == null || password.isEmpty() ||
            role == null || (!role.equals("admin") && !role.equals("customer")) ||
            email == null || email.isEmpty()) {
            request.setAttribute("error", "All fields are required, and role must be 'admin' or 'customer'.");
            request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnecttion.getConnection()) {
            // Check for duplicate email
            if (isEmailExists(conn, email)) {
                request.setAttribute("error", "Registration failed: Email already exists.");
                request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            // Hash the password for secure storage
            String hashedPassword = PasswordUtil.hashPassword(password);

            // Insert new user into the database
            String sql = "INSERT INTO users (username, password, role, email) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, hashedPassword);
                stmt.setString(3, role);
                stmt.setString(4, email);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            // Handle database errors, including duplicate username
            String errorMessage = "Registration failed: " + e.getMessage();
            if (e.getMessage().contains("Duplicate entry") && e.getMessage().contains("username")) {
                errorMessage = "Registration failed: Username already exists.";
            }
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // On successful registration, redirect to login page with success message
        request.setAttribute("success", "Registration successful! Please log in.");
        request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
    }

    /**
     * Checks if the provided email already exists in the database.
     *
     * @param conn  The database connection
     * @param email The email to check
     * @return True if the email exists, false otherwise
     * @throws SQLException If a database error occurs
     */
    private boolean isEmailExists(Connection conn, String email) throws SQLException {
        // Query to count users with the given email
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Email exists if count > 0
                }
            }
        }
        return false;
    }
}