package com.wattx.controller.filter;

import com.wattx.util.SessionUtil;
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

    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/market",
        "/login",
        "/signup",
        "/logout",
        "/public"
    );

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Allow public paths to bypass authentication
        if (PUBLIC_PATHS.contains(path) || path.startsWith("/public/")) {
            chain.doFilter(request, response);
            return;
        }

        // Debug session state
        HttpSession session = httpRequest.getSession(false);
        System.out.println("AuthFilter: Path = " + path);
        System.out.println("AuthFilter: Session exists = " + (session != null));
        if (session != null) {
            System.out.println("AuthFilter: User in session = " + (session.getAttribute("user") != null));
        }

        // Check if the user is logged in
        if (!SessionUtil.isLoggedIn(httpRequest)) {
            String queryString = httpRequest.getQueryString();
            String redirectURL = path + (queryString != null ? "?" + queryString : "");
            SessionUtil.setAttribute(httpRequest, "redirectURL", redirectURL);
            System.out.println("AuthFilter: Redirecting to login, redirectURL = " + redirectURL);
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}