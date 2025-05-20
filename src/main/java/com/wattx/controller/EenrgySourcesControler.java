package com.wattx.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


/*
 * @author Prashidha Rawal 23048617
 * */
// Servlet annotation to map the EnergySourcesController to "/energy-sources" URL with async support
@WebServlet(asyncSupported = true, urlPatterns = { "/energy-sources" })
public class EenrgySourcesControler extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests for the energy sources page.
     * Forwards the request to the energy-sources JSP for rendering.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward request to the energy sources JSP page
        request.getRequestDispatcher("/WEB-INF/pages/admin/energy-sources.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for the energy sources page.
     * Forwards the request to the energy-sources JSP for rendering.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward request to the energy sources JSP page
        request.getRequestDispatcher("/WEB-INF/pages/admin/energy-sources.jsp").forward(request, response);
    }
}