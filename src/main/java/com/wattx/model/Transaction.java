package com.wattx.model;

import java.sql.Timestamp;

/**
 * Represents a transaction in the system, capturing details of an energy purchase.
 * Stores information such as the transaction ID, associated listing, energy type, buyer, quantity, price, and date.
 */
public class Transaction {
    // Unique identifier for the transaction
    private int transactionId;
    // ID of the associated energy listing
    private int listingId;
    // Type of energy purchased (e.g., solar, wind)
    private String energyType;
    // Email of the buyer
    private String buyerEmail;
    // Quantity of energy purchased in kilowatt-hours (kWh)
    private double quantity;
    // Total price of the transaction
    private double totalPrice;
    // Timestamp of when the transaction occurred
    private Timestamp transactionDate;

    /**
     * Gets the transaction ID.
     *
     * @return The unique ID of the transaction
     */
    public int getTransactionId() {
        return transactionId;
    }

    /**
     * Sets the transaction ID.
     *
     * @param transactionId The unique ID of the transaction
     */
    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    /**
     * Gets the listing ID.
     *
     * @return The ID of the associated energy listing
     */
    public int getListingId() {
        return listingId;
    }

    /**
     * Sets the listing ID.
     *
     * @param listingId The ID of the associated energy listing
     */
    public void setListingId(int listingId) {
        this.listingId = listingId;
    }

    /**
     * Gets the energy type.
     *
     * @return The type of energy purchased (e.g., solar, wind)
     */
    public String getEnergyType() {
        return energyType;
    }

    /**
     * Sets the energy type.
     *
     * @param energyType The type of energy purchased (e.g., solar, wind)
     */
    public void setEnergyType(String energyType) {
        this.energyType = energyType;
    }

    /**
     * Gets the buyer's email.
     *
     * @return The email of the buyer
     */
    public String getBuyerEmail() {
        return buyerEmail;
    }

    /**
     * Sets the buyer's email.
     *
     * @param buyerEmail The email of the buyer
     */
    public void setBuyerEmail(String buyerEmail) {
        this.buyerEmail = buyerEmail;
    }

    /**
     * Gets the quantity of energy purchased.
     *
     * @return The quantity in kilowatt-hours (kWh)
     */
    public double getQuantity() {
        return quantity;
    }

    /**
     * Sets the quantity of energy purchased.
     *
     * @param quantity The quantity in kilowatt-hours (kWh)
     */
    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    /**
     * Gets the total price of the transaction.
     *
     * @return The total price
     */
    public double getTotalPrice() {
        return totalPrice;
    }

    /**
     * Sets the total price of the transaction.
     *
     * @param totalPrice The total price
     */
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    /**
     * Gets the transaction date.
     *
     * @return The timestamp when the transaction occurred
     */
    public Timestamp getTransactionDate() {
        return transactionDate;
    }

    /**
     * Sets the transaction date.
     *
     * @param transactionDate The timestamp when the transaction occurred
     */
    public void setTransactionDate(Timestamp transactionDate) {
        this.transactionDate = transactionDate;
    }
}