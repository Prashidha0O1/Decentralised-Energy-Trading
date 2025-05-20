package com.wattx.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * @author Prashidha Rawal 23048617
 * */
//Class to manage database connection using MySQL
public class DBConnecttion {
 // Database credentials and configuration
 private static final String URL = "jdbc:mysql://localhost:3306/wattx"; // JDBC URL for MySQL database
 private static final String USER = "root"; // Database username
 private static final String PASSWORD = ""; // Database password (empty in this case)
 private static final String DRIVER = "com.mysql.cj.jdbc.Driver"; // MySQL JDBC driver class

 // Static connection object to maintain a single connection (singleton pattern)
 private static Connection connection = null;

 // Private constructor to prevent instantiation of this utility class
 private DBConnecttion() {}

 /**
  * Establishes and returns a connection to the MySQL database using the singleton pattern.
  * If the connection is null or closed, a new connection is created.
  * 
  * @return Connection object to the database
  * @throws SQLException if the driver is not found or connection fails
  */
 public static Connection getConnection() throws SQLException {
     // Check if connection is null or closed
     if (connection == null || connection.isClosed()) {
         try {
             // Load the MySQL JDBC driver
             Class.forName(DRIVER);
             // Establish connection using the provided URL, username, and password
             connection = DriverManager.getConnection(URL, USER, PASSWORD);
             // Log successful connection
             System.out.println("Database connected successfully!");
         } catch (ClassNotFoundException e) {
             // Throw SQLException if the driver class is not found
             throw new SQLException("MySQL Driver not found: " + e.getMessage());
         } catch (SQLException e) {
             // Throw SQLException if connection to the database fails
             throw new SQLException("Failed to connect to database: " + e.getMessage());
         }
     }
     // Return the active connection
     return connection;
 }

 /**
  * Closes the active database connection if it exists.
  * Logs a message on successful closure or any errors encountered.
  */
 public static void closeConnection() {
     // Check if connection exists
     if (connection != null) {
         try {
             // Close the database connection
             connection.close();
             // Log successful closure
             System.out.println("Database connection closed.");
         } catch (SQLException e) {
             // Log error if closing the connection fails
             System.err.println("Error closing connection: " + e.getMessage());
         }
     }
 }
}