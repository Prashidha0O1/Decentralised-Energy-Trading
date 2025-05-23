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
// Servlet annotation to map IndexController to the root URL ("/") with async support
@WebServlet(
    asyncSupported = true, 
    name = "IndexController", 
    urlPatterns = { "/" }
)
public class IndexController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Default constructor.
     */
    public IndexController() {
        super();
    }

    /**
     * Handles GET requests for the root URL ("/").
     * Forwards the request to the main JSP page for rendering.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward request to the main JSP page
        request.getRequestDispatcher("WEB-INF/pages/main.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for the root URL ("/").
     * Delegates to the doGet method to forward the request to the main JSP page.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Delegate POST requests to the doGet method
        doGet(request, response);
    }
}