<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Decentralised Energy Trading Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= contextPath %>/styles.css">
    <style>
    :root {
        --primary: #F0B90B;
        --secondary: #1E2026;
        --text-primary: #F3F3F3;
        --text-secondary: #848E9C;
        --bg-primary: #0B0E11;
        --bg-secondary: #1E2026;
        --bg-tertiary: #2B3139;
        --success: #02C076;
        --danger: #F6465D;
        --border: #2E333A;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-slash;
    }

    body {
        background-color: var(--bg-primary);
        color: var(--text-primary);
    }

    .container {
        display: flex;
        min-height: 100vh;
    }

    .sidebar {
        width: 240px;
        background-color: var(--bg-secondary);
        border-right: 1px solid var(--border);
        position: fixed;
        top: 0;
        left: 0;
        height: 100vh;
        z-index: 100;
        transition: all 0.3s;
    }

    .sidebar-header {
        padding: 20px 15px;
        border-bottom: 1px solid var(--border);
        display: flex;
        align-items: center;
    }

    .logo {
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: bold;
        font-size: 1.4rem;
    }

    .logo-icon {
        width: 32px;
        height: 32px;
        background-color: var(--primary);
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--bg-primary);
    }

    .sidebar-menu {
        padding: 15px 0;
    }

    .menu-section {
        padding: 0 15px;
        margin-bottom: 15px;
    }

    .menu-section-title {
        font-size: 12px;
        color: var(--text-secondary);
        text-transform: uppercase;
        margin-bottom: 10px;
        padding-left: 10px;
    }

    .menu-items a {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 12px 15px;
        color: var(--text-primary);
        text-decoration: none;
        border-radius: 8px;
        margin-bottom: 5px;
        transition: all 0.2s;
    }

    .menu-items a:hover, .menu-items a.active {
        background-color: rgba(240, 185, 11, 0.1);
        color: var(--primary);
    }

    .menu-items a.active {
        border-left: 3px solid var(--primary);
    }

    .content {
        flex: 1;
        margin-left: 240px;
        padding: 20px;
    }

    .topbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 0;
        border-bottom: 1px solid var(--border);
        margin-bottom: 20px;
    }

    .topbar-title {
        font-size: 1.5rem;
        font-weight: 500;
    }

    .user-menu {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .notification-icon, .user-profile {
        background-color: var(--bg-secondary);
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.2s;
    }

    .notification-icon:hover, .user-profile:hover {
        background-color: var(--primary);
        color: var(--bg-primary);
    }

    .dashboard-cards {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .card {
        background-color: var(--bg-secondary);
        border-radius: 10px;
        padding: 20px;
        border: 1px solid var(--border);
        transition: all 0.3s;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }

    .card-title {
        font-size: 1rem;
        color: var(--text-secondary);
    }

    .card-value {
        font-size: 1.8rem;
        font-weight: 600;
        margin-bottom: 5px;
    }

    .card-change {
        display: flex;
        align-items: center;
        gap: 5px;
        font-size: 0.9rem;
    }

    .up {
        color: var(--success);
    }

    .down {
        color: var(--danger);
    }

    .data-section {
        margin-bottom: 40px;
    }

    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }

    .section-title {
        font-size: 1.2rem;
        font-weight: 500;
    }

    .section-actions {
        display: flex;
        gap: 10px;
    }

    .btn {
        background-color: var(--primary);
        color: var(--bg-primary);
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 14px;
        transition: all 0.2s;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .btn:hover {
        background-color: #d4a00a;
    }

    .btn-danger {
        background-color: var(--danger);
        color: var(--text-primary);
    }

    .btn-danger:hover {
        background-color: #d43a4e;
    }

    .btn-icon {
        width: 32px;
        height: 32px;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: none;
        cursor: pointer;
        transition: all 0.2s ease;
        background-color: var(--bg-tertiary);
        color: var(--text-primary);
        margin-right: 5px;
    }

    .btn-icon:hover {
        transform: translateY(-2px);
    }

    .btn-icon.edit:hover {
        background-color: rgba(240, 185, 11, 0.2);
        color: var(--primary);
    }

    .btn-icon.delete:hover {
        background-color: rgba(246, 70, 93, 0.2);
        color: var(--danger);
    }

    .data-table {
        width: 100%;
        background-color: var(--bg-secondary);
        border-radius: 10px;
        overflow-x: auto;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        min-width: 600px;
    }

    .data-table table {
        width: 100%;
        border-collapse: collapse;
    }

    .data-table th {
        background-color: var(--bg-tertiary);
        text-align: left;
        padding: 15px;
        font-weight: 500;
        color: var(--text-secondary);
        font-size: 14px;
        text-transform: uppercase;
    }

    .data-table td {
        padding: 15px;
        border-bottom: 1px solid var(--border);
        font-size: 14px;
    }

    .data-table tbody tr {
        transition: background-color 0.3s ease;
    }

    .data-table tbody tr:hover {
        background-color: rgba(240, 185, 11, 0.05);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .data-table tbody tr:hover .btn-icon {
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
    }

    .energy-chart {
        background-color: var(--bg-secondary);
        border-radius: 10px;
        padding: 20px;
        max-height: 400px;
        overflow: hidden;
    }

    .chart-container {
        display: flex;
        flex-direction: column;
        gap: 20px;
        height: 100%;
    }

    .chart-container canvas {
        position: relative;
        max-height: 200px;
        width: 100%;
    }

    .status {
        padding: 5px 10px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 500;
        display: inline-block;
        transition: all 0.3s ease;
    }

    .status-pending {
        background-color: rgba(240, 185, 11, 0.15);
        color: var(--primary);
    }

    .status-completed {
        background-color: rgba(2, 192, 118, 0.15);
        color: var(--success);
    }

    .status-failed {
        background-color: rgba(246, 70, 93, 0.15);
        color: var(--danger);
    }

    .data-table tr:hover .status {
        background-color: rgba(240, 185, 11, 0.2);
    }

    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.7);
        z-index: 1000;
        align-items: center;
        justify-content: center;
    }

    .modal-content {
        background-color: var(--bg-secondary);
        border-radius: 10px;
        padding: 20px;
        width: 90%;
        max-width: 500px;
        border: 1px solid var(--border);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    }

    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .modal-title {
        font-size: 1.2rem;
        font-weight: 500;
    }

    .close-btn {
        background: none;
        border: none;
        color: var(--text-secondary);
        font-size: 1.5rem;
        cursor: pointer;
        transition: color 0.2s;
    }

    .close-btn:hover {
        color: var(--text-primary);
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        color: var(--text-secondary);
        margin-bottom: 5px;
        font-size: 0.9rem;
    }

    .form-group select, .form-group input {
        width: 100%;
        padding: 10px;
        background-color: var(--bg-tertiary);
        border: 1px solid var(--border);
        border-radius: 6px;
        color: var(--text-primary);
        font-size: 14px;
    }

    .form-group select:focus, .form-group input:focus {
        outline: none;
        border-color: var(--primary);
    }

    .message {
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 15px;
        font-size: 14px;
        text-align: center;
    }

    .message.success {
        background-color: rgba(2, 192, 118, 0.1);
        color: var(--success);
    }

    .message.error {
        background-color: rgba(246, 70, 93, 0.1);
        color: var(--danger);
    }

    .action-buttons {
        display: flex;
        gap: 5px;
    }

    @media (max-width: 1024px) {
        .sidebar {
            width: 80px;
        }
        
        .logo span, .menu-section-title, .menu-items span {
            display: none;
        }
        
        .content {
            margin-left: 80px;
        }
        
        .menu-items a {
            justify-content: center;
            padding: 15px;
        }
    }

    @media (max-width: 768px) {
        .dashboard-cards {
            grid-template-columns: 1fr;
        }
    }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <div class="logo-icon"><i class="fas fa-bolt"></i></div>
                    <span>WattX</span>
                </div>
            </div>
            <div class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-section-title">Main</div>
                    <div class="menu-items">
                        <a href="<%= contextPath %>/dashboard" class="active"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a>
                        <a href="<%= contextPath %>/transactions"><i class="fas fa-history"></i> <span>Transactions</span></a>
                    </div>
                </div>
                <div class="menu-section">
                    <div class="menu-section-title">Management</div>
                    <div class="menu-items">
                        <a href="<%= contextPath %>/energy-sources"><i class="fas fa-solar-panel"></i> <span>Energy Sources</span></a>
                    </div>
                </div>
                <div class="menu-section">
                    <div class="menu-items">
                        <a href="<%= contextPath %>/admin-profile"><i class="fas fa-user"></i> <span>Profile</span></a>
                        <a href="<%= contextPath %>/logout"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="topbar">
                <div class="topbar-title">Admin Dashboard</div>
                <div class="user-menu">
                    <div class="notification-icon"><i class="fas fa-bell"></i></div>
                    <div class="user-profile"><i class="fas fa-user"></i></div>
                </div>
            </div>
            <div class="dashboard-cards">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">Total Energy Traded</div>
                        <i class="fas fa-bolt" style="color: var(--primary);"></i>
                    </div>
                    <div class="card-value">2,145 kWh</div>
                    <div class="card-change up">
                        <i class="fas fa-arrow-up"></i>
                        <span>12.4% from last week</span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">Active Users</div>
                        <i class="fas fa-users" style="color: var(--primary);"></i>
                    </div>
                    <div class="card-value">843</div>
                    <div class="card-change up">
                        <i class="fas fa-arrow-up"></i>
                        <span>5.7% from last week</span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">Average Energy Price</div>
                        <i class="fas fa-dollar-sign" style="color: var(--primary);"></i>
                    </div>
                    <div class="card-value">$0.12 / kWh</div>
                    <div class="card-change down">
                        <i class="fas fa-arrow-down"></i>
                        <span>2.3% from last week</span>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">Today's Volume</div>
                        <i class="fas fa-chart-pie" style="color: var(--primary);"></i>
                    </div>
                    <div class="card-value">342 kWh</div>
                    <div class="card-change up">
                        <i class="fas fa-arrow-up"></i>
                        <span>8.1% from yesterday</span>
                    </div>
                </div>
            </div>
            <div class="data-section">
                <div class="section-header">
                    <div class="section-title">Energy Market Overview</div>
                    <div class="section-actions">
                        <button class="btn"><i class="fas fa-filter"></i> <span>Filter</span></button>
                        <button class="btn btn-primary" onclick="openModal('newTradeModal')"><i class="fas fa-plus"></i> <span>New Trade</span></button>
                    </div>
                </div>
                <div class="energy-chart">
                    <div class="chart-container">
                        <canvas id="energyChart"></canvas>
                        <canvas id="timelineChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="data-section">
                <div class="section-header">
                    <div class="section-title">Recent Transactions</div>
                    <div class="section-actions">
                        <button class="btn"><i class="fas fa-download"></i> <span>Export</span></button>
                    </div>
                </div>
                <div class="data-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Transaction ID</th>
                                <th>User</th>
                                <th>Energy Type</th>
                                <th>Amount (kWh)</th>
                                <th>Price</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            String[][] transactions = {
                                {"TX-78954", "Alice Smith", "Solar", "42.5", "$5.10", "2025-04-08 09:23:15", "Completed"},
                                {"TX-78953", "Bob Johnson", "Wind", "31.2", "$3.74", "2025-04-08 08:57:42", "Completed"},
                                {"TX-78952", "Charlie Brown", "Hydro", "55.0", "$6.60", "2025-04-08 08:35:19", "Pending"},
                                {"TX-78951", "Diana Prince", "Solar", "28.7", "$3.44", "2025-04-08 08:12:56", "Completed"},
                                {"TX-78950", "Edward Wilson", "Biomass", "63.1", "$7.57", "2025-04-08 07:48:33", "Failed"}
                            };
                            for(int i = 0; i < transactions.length; i++) {
                                String statusClass = "status-completed";
                                if(transactions[i][6].equals("Pending")) {
                                    statusClass = "status-pending";
                                } else if(transactions[i][6].equals("Failed")) {
                                    statusClass = "status-failed";
                                }
                            %>
                                <tr>
                                    <td><%= transactions[i][0] %></td>
                                    <td><%= transactions[i][1] %></td>
                                    <td><%= transactions[i][2] %></td>
                                    <td><%= transactions[i][3] %></td>
                                    <td><%= transactions[i][4] %></td>
                                    <td><%= transactions[i][5] %></td>
                                    <td><span class="status <%= statusClass %>"><%= transactions[i][6] %></span></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="data-section">
                <div class="section-header">
                    <div class="section-title">Energy Listings</div>
                    <div class="section-actions">
                        <button class="btn btn-primary" onclick="openModal('newTradeModal')"><i class="fas fa-plus"></i> <span>New Trade</span></button>
                    </div>
                </div>
                <c:if test="${not empty error}">
                    <div class="message error">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="message success">${success}</div>
                </c:if>
                <div class="data-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Listing ID</th>
                                <th>Energy Type</th>
                                <th>Quantity (kWh)</th>
                                <th>Price per kWh ($)</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty listings}">
                                <tr>
                                    <td colspan="7" style="text-align: center;">No energy listings available.</td>
                                </tr>
                            </c:if>
                            <c:forEach var="listing" items="${listings}">
                                <tr>
                                    <td>${listing.listingId}</td>
                                    <td>${listing.energyType}</td>
                                    <td>${listing.quantity}</td>
                                    <td>${listing.pricePerKwh}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${listing.status eq 'available'}">
                                                <span class="status status-pending">Active</span>
                                            </c:when>
                                            <c:when test="${listing.status eq 'sold'}">
                                                <span class="status status-completed">Sold</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status">${listing.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${listing.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                    </td>
                                    <td class="action-buttons">
                                        <form action="<%= contextPath %>/dashboard" method="GET" style="display:inline;">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="listingId" value="${listing.listingId}">
                                            <button type="submit" class="btn-icon edit"><i class="fas fa-edit"></i></button>
                                        </form>
                                        <button class="btn-icon delete" onclick="openModal('deleteConfirmModal'); setDeleteListingId(${listing.listingId});"><i class="fas fa-trash-alt"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="data-section">
                <div class="section-header">
                    <div class="section-title">Energy Sources Overview</div>
                </div>
                <div class="dashboard-cards">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">Solar</div>
                            <i class="fas fa-sun" style="color: var(--primary);"></i>
                        </div>
                        <div class="card-value">856 kWh</div>
                        <div class="card-change up">
                            <i class="fas fa-arrow-up"></i>
                            <span>15.2% from last week</span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">Wind</div>
                            <i class="fas fa-wind" style="color: var(--primary);"></i>
                        </div>
                        <div class="card-value">621 kWh</div>
                        <div class="card-change up">
                            <i class="fas fa-arrow-up"></i>
                            <span>8.9% from last week</span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">Hydro</div>
                            <i class="fas fa-water" style="color: var(--primary);"></i>
                        </div>
                        <div class="card-value">423 kWh</div>
                        <div class="card-change down">
                            <i class="fas fa-arrow-down"></i>
                            <span>3.1% from last week</span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">Biomass</div>
                            <i class="fas fa-leaf" style="color: var(--primary);"></i>
                        </div>
                        <div class="card-value">245 kWh</div>
                        <div class="card-change up">
                            <i class="fas fa-arrow-up"></i>
                            <span>4.5% from last week</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for New Trade -->
    <div id="newTradeModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">Create New Trade</div>
                <button class="close-btn" onclick="closeModal()">×</button>
            </div>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="message success">${success}</div>
            </c:if>
            <form action="<%= contextPath %>/dashboard" method="POST">
                <input type="hidden" name="action" value="create">
                <div class="form-group">
                    <label for="energyType">Energy Type</label>
                    <select id="energyType" name="energyType" required>
                        <option value="" disabled selected>Select Energy Type</option>
                        <option value="solar">Solar</option>
                        <option value="wind">Wind</option>
                        <option value="hydro">Hydro</option>
                        <option value="coal">Coal</option>
                        <option value="gas">Gas</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="quantity">Quantity (kWh)</label>
                    <input type="number" id="quantity" name="quantity" step="0.1" min="0.1" placeholder="e.g., 50.0" required>
                </div>
                <div class="form-group">
                    <label for="pricePerKwh">Price per kWh ($)</label>
                    <input type="number" id="pricePerKwh" name="pricePerKwh" step="0.01" min="0.01" placeholder="e.g., 0.12" required>
                </div>
                <button type="submit" class="btn btn-primary">Create Trade</button>
            </form>
        </div>
    </div>

    <!-- Modal for Edit Listing -->
    <div id="editTradeModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">Edit Listing</div>
                <button class="close-btn" onclick="closeModal()">×</button>
            </div>
            <form action="<%= contextPath %>/dashboard" method="POST">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="listingId" value="${listing != null ? listing.listingId : ''}">
                <div class="form-group">
                    <label for="editEnergyType">Energy Type</label>
                    <select id="editEnergyType" name="energyType" required>
                        <option value="" disabled>Select Energy Type</option>
                        <option value="solar" ${listing != null && listing.energyType eq 'solar' ? 'selected' : ''}>Solar</option>
                        <option value="wind" ${listing != null && listing.energyType eq 'wind' ? 'selected' : ''}>Wind</option>
                        <option value="hydro" ${listing != null && listing.energyType eq 'hydro' ? 'selected' : ''}>Hydro</option>
                        <option value="coal" ${listing != null && listing.energyType eq 'coal' ? 'selected' : ''}>Coal</option>
                        <option value="gas" ${listing != null && listing.energyType eq 'gas' ? 'selected' : ''}>Gas</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editQuantity">Quantity (kWh)</label>
                    <input type="number" id="editQuantity" name="quantity" step="0.1" min="0.1" value="${listing != null ? listing.quantity : ''}" required>
                </div>
                <div class="form-group">
                    <label for="editPricePerKwh">Price per kWh ($)</label>
                    <input type="number" id="editPricePerKwh" name="pricePerKwh" step="0.01" min="0.01" value="${listing != null ? listing.pricePerKwh : ''}" required>
                </div>
                <button type="submit" class="btn btn-primary">Update Listing</button>
            </form>
        </div>
    </div>

    <!-- Confirmation Modal for Deletion -->
    <div id="deleteConfirmModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">Confirm Deletion</div>
                <button class="close-btn" onclick="closeModal()">×</button>
            </div>
            <p style="margin-bottom: 20px;">Are you sure you want to delete this energy listing? This action cannot be undone.</p>
            <div style="display: flex; justify-content: flex-end; gap: 10px;">
                <button class="btn" onclick="closeModal()">Cancel</button>
                <form action="<%= contextPath %>/dashboard" method="GET" style="margin: 0;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="listingId" id="deleteListingId" value="">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            <% 
            String[][] Transactions = {
                {"TX-78954", "Alice Smith", "Solar", "42.5", "$5.10", "2025-04-08 09:23:15", "Completed"},
                {"TX-78953", "Bob Johnson", "Wind", "31.2", "$3.74", "2025-04-08 08:57:42", "Completed"},
                {"TX-78952", "Charlie Brown", "Hydro", "55.0", "$6.60", "2025-04-08 08:35:19", "Pending"},
                {"TX-78951", "Diana Prince", "Solar", "28.7", "$3.44", "2025-04-08 08:12:56", "Completed"},
                {"TX-78950", "Edward Wilson", "Biomass", "63.1", "$7.57", "2025-04-08 07:48:33", "Failed"}
            };
            java.util.Map<String, Double> energyByType = new java.util.HashMap<>();
            for(int i = 0; i < Transactions.length; i++) {
                String energyType = Transactions[i][2];
                double amount = Double.parseDouble(Transactions[i][3]);
                energyByType.put(energyType, energyByType.getOrDefault(energyType, 0.0) + amount);
            }
            StringBuilder labels = new StringBuilder("[");
            StringBuilder data = new StringBuilder("[");
            boolean first = true;
            for(java.util.Map.Entry<String, Double> entry : energyByType.entrySet()) {
                if(!first) {
                    labels.append(",");
                    data.append(",");
                }
                labels.append("\"").append(entry.getKey()).append("\"");
                data.append(entry.getValue());
                first = false;
            }
            labels.append("]");
            data.append("]");
            StringBuilder timeLabels = new StringBuilder("[");
            StringBuilder timeData = new StringBuilder("[");
            for(int i = 0; i < Transactions.length - 1; i++) {
                for(int j = 0; j < Transactions.length - i - 1; j++) {
                    if(Transactions[j][5].compareTo(Transactions[j + 1][5]) > 0) {
                        String[] temp = Transactions[j];
                        Transactions[j] = Transactions[j + 1];
                        Transactions[j + 1] = temp;
                    }
                }
            }
            first = true;
            for(int i = 0; i < Transactions.length; i++) {
                if(!first) {
                    timeLabels.append(",");
                    timeData.append(",");
                }
                String timeOnly = Transactions[i][5].split(" ")[1].substring(0, 5);
                timeLabels.append("\"").append(timeOnly).append("\"");
                timeData.append(Transactions[i][3]);
                first = false;
            }
            timeLabels.append("]");
            timeData.append("]");
            %>
            const ctx = document.getElementById('energyChart').getContext('2d');
            const energyChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: <%= labels.toString() %>,
                    datasets: [{
                        label: 'Energy Amount (kWh)',
                        data: <%= data.toString() %>,
                        backgroundColor: [
                            'rgba(255, 205, 86, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(75, 192, 192, 0.7)',
                            'rgba(75, 162, 86, 0.7)'
                        ],
                        borderColor: [
                            'rgb(255, 205, 86)',
                            'rgb(54, 162, 235)',
                            'rgb(75, 192, 192)',
                            'rgb(75, 162, 86)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top',
                            labels: { color: '#F3F3F3' }
                        },
                        title: {
                            display: true,
                            text: 'Energy Traded by Source Type (kWh)',
                            color: '#F3F3F3',
                            font: { size: 16 }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(255, 255, 255, 0.1)' },
                            ticks: { color: '#848E9C' }
                        },
                        x: {
                            grid: { color: 'rgba(255, 255, 255, 0.1)' },
                            ticks: { color: '#848E9C' }
                        }
                    }
                }
            });
            const timelineCtx = document.getElementById('timelineChart').getContext('2d');
            const timelineChart = new Chart(timelineCtx, {
                type: 'line',
                data: {
                    labels: <%= timeLabels.toString() %>,
                    datasets: [{
                        label: 'Transaction Amount (kWh)',
                        data: <%= timeData.toString() %>,
                        borderColor: '#F0B90B',
                        backgroundColor: 'rgba(240, 185, 11, 0.2)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top',
                            labels: { color: '#F3F3F3' }
                        },
                        title: {
                            display: true,
                            text: 'Energy Transaction Timeline (Today)',
                            color: '#F3F3F3',
                            font: { size: 16 }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(255, 255, 255, 0.1)' },
                            ticks: { color: '#848E9C' }
                        },
                        x: {
                            grid: { color: 'rgba(255, 255, 255, 0.1)' },
                            ticks: { color: '#848E9C' }
                        }
                    }
                }
            });
        });

        function openModal(modalId) {
            document.getElementById(modalId).style.display = 'flex';
        }

        function closeModal() {
            document.querySelectorAll('.modal').forEach(modal => {
                modal.style.display = 'none';
            });
        }

        function setDeleteListingId(listingId) {
            document.getElementById('deleteListingId').value = listingId;
        }

        window.addEventListener('click', function(event) {
            const modals = ['newTradeModal', 'editTradeModal', 'deleteConfirmModal'];
            modals.forEach(id => {
                const modal = document.getElementById(id);
                if (event.target === modal) {
                    closeModal();
                }
            });
        });

        <c:if test="${not empty listing}">
            openModal('editTradeModal');
        </c:if>
    </script>
</body>
</html>