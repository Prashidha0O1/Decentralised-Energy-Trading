package com.wattx.controller.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Servlet Filter implementation class AuthFilter
 */
@WebFilter(urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    // List of paths that don't require authentication
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/market",
        "/login",
        "/signup",
        "/logout" // Add any other public paths as needed
    );

    /**
     * @see Filter#init(FilterConfig)
     */
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        // Initialization code if needed
    }

    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Get the request URI and context path
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Allow public paths to bypass authentication
        if (PUBLIC_PATHS.contains(path) || path.startsWith("/public/")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if the user is logged in
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (!isLoggedIn) {
            // Store the intended destination so the login page can redirect back after successful login
            String queryString = httpRequest.getQueryString();
            String redirectURL = path + (queryString != null ? "?" + queryString : "");
            httpRequest.getSession().setAttribute("redirectURL", redirectURL);

            // Redirect to login page
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // User is authenticated, proceed with the request
        chain.doFilter(request, response);
    }

    /**
     * @see Filter#destroy()
     */
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}