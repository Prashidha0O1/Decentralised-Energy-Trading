package com.wattx.model;

import java.sql.Timestamp;

/**
 * Represents a user in the system, storing details such as user ID, username, password, role, email, and creation timestamp.
 * Used for authentication, authorization, and user profile management.
 */
public class User {
    // Unique identifier for the user
    private int userId;
    // Unique username for the user
    private String username;
    // Hashed password for secure authentication
    private String password;
    // User role (e.g., "admin" or "customer")
    private String role;
    // User's email address
    private String email;
    // Timestamp of when the user account was created
    private Timestamp createdAt;

    /**
     * Default constructor for User.
     * Initializes an empty User object.
     */
    public User() {}

    /**
     * Parameterized constructor for User.
     * Initializes a User object with specified values.
     *
     * @param userId     The unique ID of the user
     * @param username   The username of the user
     * @param password   The hashed password of the user
     * @param role       The role of the user (e.g., "admin", "customer")
     * @param email      The email address of the user
     * @param createdAt  The timestamp when the user account was created
     */
    public User(int userId, String username, String password, String role, String email, Timestamp createdAt) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.role = role;
        this.email = email;
        this.createdAt = createdAt;
    }

    /**
     * Gets the user ID.
     *
     * @return The unique ID of the user
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID.
     *
     * @param userId The unique ID of the user
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Gets the username.
     *
     * @return The username of the user
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the username.
     *
     * @param username The username of the user
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Gets the hashed password.
     *
     * @return The hashed password of the user
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the hashed password.
     *
     * @param password The hashed password of the user
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Gets the user role.
     *
     * @return The role of the user (e.g., "admin", "customer")
     */
    public String getRole() {
        return role;
    }

    /**
     * Sets the user role.
     *
     * @param role The role of the user (e.g., "admin", "customer")
     */
    public void setRole(String role) {
        this.role = role;
    }

    /**
     * Gets the user's email address.
     *
     * @return The email address of the user
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the user's email address.
     *
     * @param email The email address of the user
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Gets the creation timestamp of the user account.
     *
     * @return The timestamp when the user account was created
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * Sets the creation timestamp of the user account.
     *
     * @param createdAt The timestamp when the user account was created
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}