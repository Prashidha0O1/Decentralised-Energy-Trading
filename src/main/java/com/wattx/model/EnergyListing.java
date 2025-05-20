package com.wattx.model;

import java.sql.Timestamp;

/**
 * Represents an energy listing in the system, containing details about an energy trade.
 * Used to store information such as energy type, quantity, price, status, and creation details.
 */
public class EnergyListing {
    // Unique identifier for the energy listing
    private int listingId;
    // Type of energy (e.g., solar, wind)
    private String energyType;
    // Quantity of energy in kilowatt-hours (kWh)
    private double quantity;
    // Price per kilowatt-hour (kWh)
    private double pricePerKwh;
    // Status of the listing (e.g., available, partially_sold, sold)
    private String status;
    // User ID of the admin who created the listing
    private int createdBy;
    // Timestamp of when the listing was created
    private Timestamp createdAt;

    /**
     * Default constructor for EnergyListing.
     * Initializes an empty EnergyListing object.
     */
    public EnergyListing() {}

    /**
     * Parameterized constructor for EnergyListing.
     * Initializes an EnergyListing object with specified values.
     *
     * @param listingId    The unique ID of the listing
     * @param energyType   The type of energy (e.g., solar, wind)
     * @param quantity     The quantity of energy in kWh
     * @param pricePerKwh  The price per kWh
     * @param status       The status of the listing (e.g., available, sold)
     * @param createdBy    The user ID of the admin who created the listing
     * @param createdAt    The timestamp of when the listing was created
     */
    public EnergyListing(int listingId, String energyType, double quantity, double pricePerKwh, 
                        String status, int createdBy, Timestamp createdAt) {
        this.listingId = listingId;
        this.energyType = energyType;
        this.quantity = quantity;
        this.pricePerKwh = pricePerKwh;
        this.status = status;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
    }

    /**
     * Gets the listing ID.
     *
     * @return The unique ID of the listing
     */
    public int getListingId() {
        return listingId;
    }

    /**
     * Sets the listing ID.
     *
     * @param listingId The unique ID of the listing
     */
    public void setListingId(int listingId) {
        this.listingId = listingId;
    }

    /**
     * Gets the energy type.
     *
     * @return The type of energy (e.g., solar, wind)
     */
    public String getEnergyType() {
        return energyType;
    }

    /**
     * Sets the energy type.
     *
     * @param energyType The type of energy (e.g., solar, wind)
     */
    public void setEnergyType(String energyType) {
        this.energyType = energyType;
    }

    /**
     * Gets the quantity of energy.
     *
     * @return The quantity in kilowatt-hours (kWh)
     */
    public double getQuantity() {
        return quantity;
    }

    /**
     * Sets the quantity of energy.
     *
     * @param quantity The quantity in kilowatt-hours (kWh)
     */
    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    /**
     * Gets the price per kilowatt-hour.
     *
     * @return The price per kWh
     */
    public double getPricePerKwh() {
        return pricePerKwh;
    }

    /**
     * Sets the price per kilowatt-hour.
     *
     * @param pricePerKwh The price per kWh
     */
    public void setPricePerKwh(double pricePerKwh) {
        this.pricePerKwh = pricePerKwh;
    }

    /**
     * Gets the status of the listing.
     *
     * @return The status (e.g., available, partially_sold, sold)
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the status of the listing.
     *
     * @param status The status (e.g., available, partially_sold, sold)
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Gets the user ID of the admin who created the listing.
     *
     * @return The user ID of the creator
     */
    public int getCreatedBy() {
        return createdBy;
    }

    /**
     * Sets the user ID of the admin who created the listing.
     *
     * @param createdBy The user ID of the creator
     */
    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    /**
     * Gets the creation timestamp of the listing.
     *
     * @return The timestamp when the listing was created
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * Sets the creation timestamp of the listing.
     *
     * @param createdAt The timestamp when the listing was created
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}