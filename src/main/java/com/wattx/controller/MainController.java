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

@WebServlet(asyncSupported = true, urlPatterns={"/home", "/about", "/contact", "/whitepaper"})
public class MainController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// In-memory store for contact form submissions (simulating a database)
    private static final List<ContactSubmission> contactSubmissions = new ArrayList<>();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String jspPage;

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
                jspPage = "WEB-INF/pages/main.jsp";
        }

        request.getRequestDispatcher(jspPage).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    // Validate form input
    private boolean isValidInput(String name, String email, String subject, String message) {
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$") ||
            subject == null || subject.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            return false;
        }
        return true;
    }
    // Inner class to represent a contact form submission
    private static class ContactSubmission {
        private final String name;
        private final String email;
        private final String subject;
        private final String message;

        public ContactSubmission(String name, String email, String subject, String message) {
            this.name = name;
            this.email = email;
            this.subject = subject;
            this.message = message;
        }

        @Override
        public String toString() {
            return "ContactSubmission{name='" + name + "', email='" + email + "', subject='" + subject + "'}";
        }
    }
}
