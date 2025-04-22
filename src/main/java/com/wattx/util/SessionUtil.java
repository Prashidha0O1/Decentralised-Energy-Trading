package com.wattx.util;

import com.wattx.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class for managing HTTP sessions.
 */
public class SessionUtil {

    /**
     * Gets the current session or creates a new one if it doesn't exist.
     *
     * @param request The HttpServletRequest object.
     * @param create  Whether to create a new session if one doesn't exist.
     * @return The HttpSession, or null if create is false and no session exists.
     */
    public static HttpSession getSession(HttpServletRequest request, boolean create) {
        return request.getSession(create);
    }

    /**
     * Sets an attribute in the session.
     *
     * @param request The HttpServletRequest object.
     * @param name    The name of the attribute.
     * @param value   The value of the attribute.
     */
    public static void setAttribute(HttpServletRequest request, String name, Object value) {
        HttpSession session = getSession(request, true);
        session.setAttribute(name, value);
    }

    /**
     * Gets an attribute from the session.
     *
     * @param request The HttpServletRequest object.
     * @param name    The name of the attribute.
     * @return The attribute value, or null if not found.
     */
    public static Object getAttribute(HttpServletRequest request, String name) {
        HttpSession session = getSession(request, false);
        return (session != null) ? session.getAttribute(name) : null;
    }

    /**
     * Removes an attribute from the session.
     *
     * @param request The HttpServletRequest object.
     * @param name    The name of the attribute to remove.
     */
    public static void removeAttribute(HttpServletRequest request, String name) {
        HttpSession session = getSession(request, false);
        if (session != null) {
            session.removeAttribute(name);
        }
    }

    /**
     * Invalidates the current session (e.g., for logout).
     *
     * @param request The HttpServletRequest object.
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = getSession(request, false);
        if (session != null) {
            session.invalidate();
        }
    }

    /**
     * Checks if a user is logged in by verifying the presence of a User object in the session.
     *
     * @param request The HttpServletRequest object.
     * @return True if the user is logged in, false otherwise.
     */
    public static boolean isLoggedIn(HttpServletRequest request) {
        User user = (User) getAttribute(request, "user");
        return user != null;
    }

    /**
     * Gets the logged-in user from the session.
     *
     * @param request The HttpServletRequest object.
     * @return The User object, or null if no user is logged in.
     */
    public static User getLoggedInUser(HttpServletRequest request) {
        return (User) getAttribute(request, "user");
    }
}