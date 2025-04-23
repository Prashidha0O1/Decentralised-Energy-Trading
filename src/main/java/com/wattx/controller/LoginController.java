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

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to LOGIN.jsp
        request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check for existing cookie (e.g., for "remember me" functionality)
        String email = null;
        String password = null;

        // Try to load email from a cookie
        Cookie emailCookie = CookieUtil.getCookie(request, "userEmail");
        if (emailCookie != null) {
            email = emailCookie.getValue();
        }

        // Get parameters from the request (override cookie if provided)
        email = request.getParameter("email") != null ? request.getParameter("email").trim() : email;
        password = request.getParameter("password") != null ? request.getParameter("password").trim() : null;

        // Validate input
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        User user = null;
        try (Connection conn = DBConnecttion.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
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
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
            return;
        }

        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Add cookie for "remember me" functionality (if requested)
            String rememberMe = request.getParameter("rememberMe");
            if ("on".equals(rememberMe)) {
                CookieUtil.addCookie(response, "userEmail", user.getEmail(), 30 * 24 * 60 * 60); // 30 days
            } else {
                // Delete cookie if "remember me" is not checked
                CookieUtil.deleteCookie(response, "userEmail");
            }

            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("dashboard");
            } else {
                response.sendRedirect("market");
            }
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
        }
    }
}