package com.wattx.controller;

import com.wattx.util.CookieUtil;
import com.wattx.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/*
 * @author Prashidha Rawal 23048617
 * */
// Servlet annotation to map LogoutController to "/logout" URL with async support
@WebServlet(asyncSupported = true, urlPatterns = { "/logout" })
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests for user logout.
     * Invalidates the session, deletes the username cookie, and redirects to the root URL.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Invalidate the user's session to clear session data
        SessionUtil.invalidateSession(request);

        // Delete the username cookie
        CookieUtil.deleteCookie(response, "username");

        // Redirect based on the referrer URL
        String referrer = request.getHeader("Referer");
        if (referrer != null && referrer.contains("/market")) {
            // Redirect to root URL for market page users
            response.sendRedirect(request.getContextPath() + "/");
        } else if (referrer != null && referrer.contains("/dashboard")) {
            // Redirect to root URL for dashboard (admin) users
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Default redirect to root URL for other cases
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}