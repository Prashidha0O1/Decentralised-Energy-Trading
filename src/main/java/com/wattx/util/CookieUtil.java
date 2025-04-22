package com.wattx.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Utility class for managing HTTP cookies with advanced features like encryption, location-based cookies, and analytics.
 */
public class CookieUtil {

    private static final String ENCRYPTION_KEY = "16ByteSecretKey!"; // Must be 16 bytes for AES; store securely in production
    private static final Map<String, Integer> cookieAccessCount = new ConcurrentHashMap<>();

    /**
     * Creates a cookie with the specified name, value, lifespan, and SameSite attribute.
     *
     * @param response The HttpServletResponse object to add the cookie to.
     * @param name     The name of the cookie.
     * @param value    The value of the cookie.
     * @param maxAge   The lifespan of the cookie in seconds (e.g., 30 days = 30 * 24 * 60 * 60).
     * @param sameSite The SameSite attribute (e.g., "Strict", "Lax", "None").
     */
    public static void createCookie(HttpServletResponse response, String name, String value, int maxAge, String sameSite) {
        if (name == null || name.isEmpty() || value == null || !isValidCookieName(name)) {
            throw new IllegalArgumentException("Invalid cookie name or value");
        }
        if (!isValidSameSite(sameSite)) {
            throw new IllegalArgumentException("Invalid SameSite attribute");
        }
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true); // Prevent client-side scripts from accessing the cookie
        cookie.setSecure(true); // Ensure cookies are sent over HTTPS
        response.addCookie(cookie);
        // Add SameSite via raw header (workaround for older Servlet APIs)
        String cookieHeader = String.format("%s=%s; Path=/; HttpOnly; Secure; SameSite=%s", name, value, sameSite);
        response.addHeader("Set-Cookie", cookieHeader);
        cookieAccessCount.merge(name, 1, Integer::sum);
    }

    /**
     * Creates a location-specific cookie by prefixing the name with a location identifier.
     *
     * @param response The HttpServletResponse object.
     * @param name     The base name of the cookie.
     * @param value    The value of the cookie.
     * @param maxAge   The lifespan of the cookie in seconds.
     * @param location The location identifier (e.g., "US", "EU").
     * @param sameSite The SameSite attribute.
     */
    public static void createLocationCookie(HttpServletResponse response, String name, String value, int maxAge, String location, String sameSite) {
        if (location == null || location.isEmpty()) {
            throw new IllegalArgumentException("Location cannot be null or empty");
        }
        String locationPrefixedName = location + "_" + name;
        createCookie(response, locationPrefixedName, value, maxAge, sameSite);
    }

    /**
     * Creates a domain-specific cookie.
     *
     * @param response The HttpServletResponse object.
     * @param name     The name of the cookie.
     * @param value    The value of the cookie.
     * @param maxAge   The lifespan of the cookie in seconds.
     * @param domain   The domain for the cookie (e.g., ".example.com").
     * @param sameSite The SameSite attribute.
     */
    public static void createDomainCookie(HttpServletResponse response, String name, String value, int maxAge, String domain, String sameSite) {
        if (name == null || name.isEmpty() || value == null || !isValidCookieName(name)) {
            throw new IllegalArgumentException("Invalid cookie name or value");
        }
        if (!isValidSameSite(sameSite)) {
            throw new IllegalArgumentException("Invalid SameSite attribute");
        }
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setSecure(true);
        if (domain != null && !domain.isEmpty()) {
            cookie.setDomain(domain);
        }
        response.addCookie(cookie);
        String cookieHeader = String.format("%s=%s; Path=/; HttpOnly; Secure; SameSite=%s%s",
                name, value, sameSite, domain != null ? "; Domain=" + domain : "");
        response.addHeader("Set-Cookie", cookieHeader);
        cookieAccessCount.merge(name, 1, Integer::sum);
    }

    /**
     * Creates a versioned cookie with a version suffix.
     *
     * @param response The HttpServletResponse object.
     * @param name     The base name of the cookie.
     * @param value    The value of the cookie.
     * @param maxAge   The lifespan of the cookie in seconds.
     * @param version  The version of the cookie (e.g., "v1").
     * @param sameSite The SameSite attribute.
     */
    public static void createVersionedCookie(HttpServletResponse response, String name, String value, int maxAge, String version, String sameSite) {
        String versionedName = name + "_" + version;
        createCookie(response, versionedName, value, maxAge, sameSite);
    }

    /**
     * Creates an encrypted cookie for sensitive data.
     *
     * @param response The HttpServletResponse object.
     * @param name     The name of the cookie.
     * @param value    The value to encrypt and store.
     * @param maxAge   The lifespan of the cookie in seconds.
     * @param sameSite The SameSite attribute.
     * @throws Exception If encryption fails.
     */
    public static void createEncryptedCookie(HttpServletResponse response, String name, String value, int maxAge, String sameSite) throws Exception {
        String encryptedValue = encrypt(value);
        createCookie(response, name, encryptedValue, maxAge, sameSite);
    }

    /**
     * Creates a cookie with a session backup.
     *
     * @param request  The HttpServletRequest object.
     * @param response The HttpServletResponse object.
     * @param name     The name of the cookie.
     * @param value    The value of the cookie.
     * @param maxAge   The lifespan of the cookie in seconds.
     * @param sameSite The SameSite attribute.
     */
    public static void createCookieWithSessionBackup(HttpServletRequest request, HttpServletResponse response,
                                                    String name, String value, int maxAge, String sameSite) {
        createCookie(response, name, value, maxAge, sameSite);
        SessionUtil.setAttribute(request, "cookie_" + name, value);
    }

    /**
     * Retrieves a cookie by name from the request.
     *
     * @param request The HttpServletRequest object.
     * @param name    The name of the cookie.
     * @return The Cookie object, or null if not found.
     */
    public static Cookie getCookie(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    cookieAccessCount.merge(name, 1, Integer::sum);
                    return cookie;
                }
            }
        }
        return null;
    }

    /**
     * Gets the value of a cookie by name.
     *
     * @param request The HttpServletRequest object.
     * @param name    The name of the cookie.
     * @return The value of the cookie, or null if not found.
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie cookie = getCookie(request, name);
        return (cookie != null) ? cookie.getValue() : null;
    }

    /**
     * Retrieves the value of a location-specific cookie.
     *
     * @param request  The HttpServletRequest object.
     * @param name     The base name of the cookie.
     * @param location The location identifier (e.g., "US", "EU").
     * @return The cookie value, or null if not found.
     */
    public static String getLocationCookieValue(HttpServletRequest request, String name, String location) {
        if (location == null || location.isEmpty()) {
            return null;
        }
        String locationPrefixedName = location + "_" + name;
        return getCookieValue(request, locationPrefixedName);
    }

    /**
     * Retrieves the value of a versioned cookie.
     *
     * @param request The HttpServletRequest object.
     * @param name    The base name of the cookie.
     * @param version The version of the cookie.
     * @return The cookie value, or null if not found.
     */
    public static String getVersionedCookieValue(HttpServletRequest request, String name, String version) {
        String versionedName = name + "_" + version;
        return getCookieValue(request, versionedName);
    }

    /**
     * Retrieves the decrypted value of an encrypted cookie.
     *
     * @param request The HttpServletRequest object.
     * @param name    The name of the cookie.
     * @return The decrypted value, or null if not found or decryption fails.
     * @throws Exception If decryption fails.
     */
    public static String getDecryptedCookieValue(HttpServletRequest request, String name) throws Exception {
        String encryptedValue = getCookieValue(request, name);
        return encryptedValue != null ? decrypt(encryptedValue) : null;
    }

    /**
     * Retrieves a cookie value, falling back to session if cookie is unavailable.
     *
     * @param request The HttpServletRequest object.
     * @param name    The name of the cookie.
     * @return The cookie or session value, or null if not found.
     */
    public static String getCookieValueWithSessionFallback(HttpServletRequest request, String name) {
        String value = getCookieValue(request, name);
        if (value == null) {
            value = (String) SessionUtil.getAttribute(request, "cookie_" + name);
        }
        return value;
    }

    /**
     * Deletes a cookie by setting its lifespan to 0.
     *
     * @param request  The HttpServletRequest object.
     * @param response The HttpServletResponse object.
     * @param name     The name of the cookie to delete.
     */
    public static void deleteCookie(HttpServletRequest request, HttpServletResponse response, String name) {
        Cookie cookie = getCookie(request, name);
        if (cookie != null) {
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
            cookieAccessCount.merge(name, 1, Integer::sum);
        }
    }

    /**
     * Gets cookie access statistics for analytics.
     *
     * @return A map of cookie names to their access counts.
     */
    public static Map<String, Integer> getCookieAccessStats() {
        return new HashMap<>(cookieAccessCount);
    }

    /**
     * Validates the cookie name to ensure it contains only allowed characters.
     *
     * @param name The cookie name.
     * @return True if valid, false otherwise.
     */
    private static boolean isValidCookieName(String name) {
        return name.matches("[a-zA-Z0-9_\\-]+");
    }

    /**
     * Validates the SameSite attribute.
     *
     * @param sameSite The SameSite value.
     * @return True if valid, false otherwise.
     */
    private static boolean isValidSameSite(String sameSite) {
        return sameSite != null && ("Strict".equals(sameSite) || "Lax".equals(sameSite) || "None".equals(sameSite));
    }

    /**
     * Encrypts a value using AES.
     *
     * @param value The value to encrypt.
     * @return The encrypted value as a Base64 string.
     * @throws Exception If encryption fails.
     */
    private static String encrypt(String value) throws Exception {
        Cipher cipher = Cipher.getInstance("AES");
        SecretKeySpec key = new SecretKeySpec(ENCRYPTION_KEY.getBytes(), "AES");
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] encrypted = cipher.doFinal(value.getBytes());
        return Base64.getEncoder().encodeToString(encrypted);
    }

    /**
     * Decrypts an encrypted value using AES.
     *
     * @param encryptedValue The Base64-encoded encrypted value.
     * @return The decrypted value.
     * @throws Exception If decryption fails.
     */
    private static String decrypt(String encryptedValue) throws Exception {
        Cipher cipher = Cipher.getInstance("AES");
        SecretKeySpec key = new SecretKeySpec(ENCRYPTION_KEY.getBytes(), "AES");
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(encryptedValue));
        return new String(decrypted);
    }
}