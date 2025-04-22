package com.wattx.controller;

import jakarta.servlet.ServletException;
import java.util.regex.Pattern;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.wattx.util.DBConnecttion;
import com.wattx.util.PasswordUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(
		asyncSupported = true, 
		urlPatterns = { 
				"/register", 
				"/create-wallet"
		})
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the registration page
        request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username") != null ? request.getParameter("username").trim() : null;
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : null;
        String role = request.getParameter("role") != null ? request.getParameter("role").trim() : null;
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : null;

        // Validate input
        if (username == null || username.isEmpty() || password == null || password.isEmpty() ||
            role == null || (!role.equals("admin") && !role.equals("customer")) ||
            email == null || email.isEmpty()) {
            request.setAttribute("error", "All fields are required, and role must be 'admin' or 'customer'.");
            request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // Hash the password
        String hashedPassword = PasswordUtil.hashPassword(password);

        // Insert user into the database
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "INSERT INTO users (username, password, role, email) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, hashedPassword);
                stmt.setString(3, role);
                stmt.setString(4, email);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            // Handle potential errors (e.g., duplicate username or email)
            String errorMessage = "Registration failed: " + e.getMessage();
            if (e.getMessage().contains("Duplicate entry")) {
                if (e.getMessage().contains("username")) {
                    errorMessage = "Registration failed: Username already exists.";
                } else if (e.getMessage().contains("email")) {
                    errorMessage = "Registration failed: Email already exists.";
                }
            }
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // On success, forward to login page with a success message
        request.setAttribute("success", "Registration successful! Please log in.");
        request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
    }
}