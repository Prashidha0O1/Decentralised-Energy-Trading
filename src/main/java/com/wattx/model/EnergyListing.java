package com.wattx.model;

import java.sql.Timestamp;

public class EnergyListing {
    private int listingId;
    private String energyType;
    private double quantity; // in kWh
    private double pricePerKwh; // price per kWh
    private String status; // available, partially_sold, sold
    private int createdBy; // user_id of the admin who created it
    private Timestamp createdAt;

    // Constructors
    public EnergyListing() {}

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

    // Getters and Setters
    public int getListingId() {
        return listingId;
    }

    public void setListingId(int listingId) {
        this.listingId = listingId;
    }

    public String getEnergyType() {
        return energyType;
    }

    public void setEnergyType(String energyType) {
        this.energyType = energyType;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public double getPricePerKwh() {
        return pricePerKwh;
    }

    public void setPricePerKwh(double pricePerKwh) {
        this.pricePerKwh = pricePerKwh;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}