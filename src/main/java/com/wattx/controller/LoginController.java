package com.wattx.controller;

import jakarta.servlet.ServletException;
import com.wattx.util.CookieUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.wattx.config.DBConnecttion;
import com.wattx.model.User;
import com.wattx.util.PasswordUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


/*
 * @author Prashidha Rawal 23048617
 * */
// Servlet annotation to map LoginController to "/login" URL
@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests for the login page.
     * Forwards the request to the Login.jsp page for rendering.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward request to the login JSP page
        request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for user login.
     * Validates credentials, manages session and cookies, and redirects based on user role.
     *
     * @param request  The HTTP request object containing login form data
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Initialize email and password variables
        String email = null;
        String password = null;

        // Try to retrieve email from cookie for "remember me" functionality
        Cookie emailCookie = CookieUtil.getCookie(request, "userEmail");
        if (emailCookie != null) {
            email = emailCookie.getValue();
        }

        // Override cookie with form parameters if provided
        email = request.getParameter("email") != null ? request.getParameter("email").trim() : email;
        password = request.getParameter("password") != null ? request.getParameter("password").trim() : null;

        // Validate input fields
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        // Fetch user from database
        User user = null;
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    // Map result set to User object
                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setEmail(rs.getString("email"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        } catch (SQLException e) {
            // Handle database errors and forward to login page with error message
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        // Verify user credentials and handle login
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Handle "remember me" functionality with cookies
            String rememberMe = request.getParameter("rememberMe");
            if ("on".equals(rememberMe)) {
                // Add cookie to store email for 30 days
                CookieUtil.addCookie(response, "userEmail", user.getEmail(), 30 * 24 * 60 * 60);
            } else {
                // Delete email cookie if "remember me" is not checked
                CookieUtil.deleteCookie(response, "userEmail");
            }

            // Redirect based on user role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("dashboard");
            } else {
                response.sendRedirect("market");
            }
        } else {
            // Forward to login page with error message for invalid credentials
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
        }
    }
}