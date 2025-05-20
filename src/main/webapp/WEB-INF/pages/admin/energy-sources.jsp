<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Energy Sources</title>
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
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
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
    .btn-primary {
        background-color: var(--primary);
    }
    .btn-primary:hover {
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
    .status {
        padding: 5px 10px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 500;
        display: inline-block;
        transition: all 0.3s ease;
    }
    .status-active {
        background-color: rgba(2, 192, 118, 0.15);
        color: var(--success);
    }
    .status-inactive {
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
        .data-table {
            min-width: 100%;
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
                        <a href="<%= contextPath %>/dashboard"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a>
                        <a href="<%= contextPath %>/transactions"><i class="fas fa-history"></i> <span>Transactions</span></a>
                    </div>
                </div>
                <div class="menu-section">
                    <div class="menu-section-title">Management</div>
                    <div class="menu-items">
                        <a href="<%= contextPath %>/energy-sources" class="active"><i class="fas fa-solar-panel"></i> <span>Energy Sources</span></a>
                    </div>
                </div>
                <div class="menu-section">
                    <div class="menu-section-title">Settings</div>
                    <div class="menu-items">
                        <a href="<%= contextPath %>/admin-profile"><i class="fas fa-user"></i> <span>Profile</span></a>
                        <a href="<%= contextPath %>/logout"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="topbar">
                <div class="topbar-title">Energy Sources</div>
                <div class="user-menu">
                    <div class="notification-icon"><i class="fas fa-bell"></i></div>
                    <div class="user-profile"><i class="fas fa-user"></i></div>
                </div>
            </div>
            <div class="data-section">
                <div class="section-header">
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
                                <th>Source ID</th>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Capacity (kWh)</th>
                                <th>Status</th>
                                <th>Created At</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            String[][] energySources = {
                                {"ES-001", "Sunny Hills Solar Farm", "Solar", "950.0", "Active", "2025-03-15 14:30:00"},
                                {"ES-002", "North Wind Turbines", "Wind", "620.0", "Active", "2025-02-20 09:15:00"},
                                {"ES-003", "River Hydro Plant", "Hydro", "400.0", "Inactive", "2025-01-10 11:45:00"},
                                {"ES-004", "Green Biomass Facility", "Biomass", "300.0", "Active", "2025-04-05 16:20:00"},
                                {"ES-005", "Eco Solar Array", "Solar", "700.0", "Active", "2025-03-25 13:10:00"}
                            };
                            for(int i = 0; i < energySources.length; i++) {
                                String statusClass = energySources[i][4].equals("Active") ? "status-active" : "status-inactive";
                            %>
                                <tr>
                                    <td><%= energySources[i][0] %></td>
                                    <td><%= energySources[i][1] %></td>
                                    <td><%= energySources[i][2] %></td>
                                    <td><%= energySources[i][3] %></td>
                                    <td><span class="status <%= statusClass %>"><%= energySources[i][4] %></span></td>
                                    <td><%= energySources[i][5] %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>