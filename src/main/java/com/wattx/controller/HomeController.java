package com.wattx.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = { "/Login", "/login" })
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeController() {
        super();
    }

    // Display the login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/pages/Login.jsp").forward(request, response);
    }

    // Handle form submission
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Simple hardcoded login logic (you can replace this with DB check)
        if ("admin".equals(username) && "admin123".equals(password)) {
            // Set session attribute
            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            // Redirect to dashboard/home page
            response.sendRedirect("admin_dashboard.jsp"); // or use request.getRequestDispatcher()
        } else {
            // Set error message and redirect back to login
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}
