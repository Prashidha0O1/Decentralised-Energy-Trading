package com.wattx.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnecttion {
    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/wattx";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private static Connection connection = null;

    // Private constructor to prevent instantiation
    private DBConnecttion() {}

    // Get a database connection (singleton pattern)
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName(DRIVER);
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Database connected successfully!");
            } catch (ClassNotFoundException e) {
                throw new SQLException("MySQL Driver not found: " + e.getMessage());
            } catch (SQLException e) {
                throw new SQLException("Failed to connect to database: " + e.getMessage());
            }
        }
        return connection;
    }

    // Close the connection
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}