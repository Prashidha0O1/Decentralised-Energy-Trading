package com.wattx.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/*
 * @author Prashidha Rawal 23048617
 * */

// Servlet annotation to map MainController to multiple URLs with async support
@WebServlet(asyncSupported = true, urlPatterns = {"/home", "/about", "/contact", "/whitepaper"})
public class MainController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    // In-memory store for contact form submissions (simulating a database)
    private static final List<ContactSubmission> contactSubmissions = new ArrayList<>();

    /**
     * Handles GET requests for public pages (home, about, contact, whitepaper).
     * Forwards the request to the appropriate JSP based on the servlet path.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Determine the requested path
        String path = request.getServletPath();
        String jspPage;

        // Map servlet path to corresponding JSP page
        switch (path) {
            case "/home":
                jspPage = "WEB-INF/pages/main.jsp";
                break;
            case "/about":
                jspPage = "WEB-INF/pages/AboutUs.jsp";
                break;
            case "/contact":
                jspPage = "WEB-INF/pages/ContactUS.jsp";
                break;
            case "/whitepaper":
                jspPage = "WEB-INF/pages/Whitepaper.jsp";
                break;
            default:
                // Default to main page for unrecognized paths
                jspPage = "WEB-INF/pages/main.jsp";
        }

        // Forward request to the selected JSP page
        request.getRequestDispatcher(jspPage).forward(request, response);
    }

    /**
     * Handles POST requests for public pages.
     * Currently unimplemented; intended for processing form submissions (e.g., contact form).
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement POST handling, e.g., for contact form submissions
    }

    /**
     * Validates contact form input for name, email, subject, and message.
     * Ensures fields are non-empty and email follows a valid format.
     *
     * @param name    The name input from the form
     * @param email   The email input from the form
     * @param subject The subject input from the form
     * @param message The message input from the form
     * @return True if all inputs are valid, false otherwise
     */
    private boolean isValidInput(String name, String email, String subject, String message) {
        // Check for null or empty fields and validate email format
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$") ||
            subject == null || subject.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            return false;
        }
        return true;
    }

    /**
     * Inner class to represent a contact form submission.
     * Stores name, email, subject, and message fields.
     */
    private static class ContactSubmission {
        private final String name; // Submitter's name
        private final String email; // Submitter's email
        private final String subject; // Submission subject
        private final String message; // Submission message

        /**
         * Constructor for ContactSubmission.
         *
         * @param name    The name input from the form
         * @param email   The email input from the form
         * @param subject The subject input from the form
         * @param message The message input from the form
         */
        public ContactSubmission(String name, String email, String subject, String message) {
            this.name = name;
            this.email = email;
            this.subject = subject;
            this.message = message;
        }

        /**
         * Returns a string representation of the contact submission.
         *
         * @return A string containing the name, email, and subject
         */
        @Override
        public String toString() {
            return "ContactSubmission{name='" + name + "', email='" + email + "', subject='" + subject + "'}";
        }
    }
}