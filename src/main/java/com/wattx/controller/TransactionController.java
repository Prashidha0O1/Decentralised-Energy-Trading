package com.wattx.controller;

import com.wattx.model.Transaction;
import com.wattx.config.DBConnecttion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// Servlet annotation to map TransactionController to "/transactions" URL with async support
@WebServlet(asyncSupported = true, urlPatterns = { "/transactions" })
public class TransactionController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Serialization ID for servlet

    /**
     * Handles GET requests for the transactions page.
     * Retrieves all transactions and forwards to the transactions JSP for display.
     *
     * @param request  The HTTP request object
     * @param response The HTTP response object
     * @throws ServletException If a servlet-specific error occurs
     * @throws IOException      If an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch all transactions from the database
        List<Transaction> transactions = getTransactions();
        // Set transactions for JSP rendering
        request.setAttribute("transactions", transactions);
        // Forward to the transactions JSP page
        request.getRequestDispatcher("/WEB-INF/pages/admin/transactions.jsp").forward(request, response);
    }

    /**
     * Retrieves all transactions from the database, ordered by transaction date (descending).
     *
     * @return A list of Transaction objects
     */
    private List<Transaction> getTransactions() {
        List<Transaction> transactions = new ArrayList<>();
        try (Connection conn = DBConnecttion.getConnection()) {
            // Query to fetch all transactions, ordered by date
            String sql = "SELECT * FROM transactions ORDER BY transaction_date DESC";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();
                // Map result set to Transaction objects
                while (rs.next()) {
                    Transaction transaction = new Transaction();
                    transaction.setEnergyType(rs.getString("energy_type")); // Note: energy_type not in transactions table
                    transaction.setTotalPrice(rs.getDouble("total_price"));
                    transactions.add(transaction);
                }
            }
        } catch (SQLException e) {
            // Log database errors
            e.printStackTrace();
        }
        return transactions;
    }
}