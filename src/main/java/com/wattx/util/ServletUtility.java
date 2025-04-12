package com.wattx.util;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class ServletUtility {

    // Forward to a JSP page
    public static void forward(String page, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String jspPath = "/WEB-INF/pages/" + page;
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    // Redirect to a URL
    public static void redirect(String url, HttpServletResponse response) throws IOException {
        response.sendRedirect(url);
    }

    // Set an error message in the request
    public static void setErrorMessage(String message, HttpServletRequest request) {
        request.setAttribute("error", message);
    }

    // Set a success message in the request
    public static void setSuccessMessage(String message, HttpServletRequest request) {
        request.setAttribute("success", message);
    }

    // Get a trimmed parameter from the request
    public static String getParameter(String name, HttpServletRequest request) {
        String value = request.getParameter(name);
        return (value != null) ? value.trim() : null;
    }

    // Get an integer parameter from the request (e.g., for IDs)
    public static int getIntParameter(String name, HttpServletRequest request, int defaultValue) {
        String value = request.getParameter(name);
        try {
            return (value != null) ? Integer.parseInt(value.trim()) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    // Set a user object in the session (e.g., after login)
    public static void setUserInSession(Object user, HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
    }

    // Get the user object from the session
    public static Object getUserFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return session.getAttribute("user");
    }

    // Remove user from session (e.g., on logout)
    public static void removeUserFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        session.invalidate();
    }
}