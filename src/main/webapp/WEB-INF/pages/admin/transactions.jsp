<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Transactions</title>
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
                        <a href="<%= contextPath %>/transactions" class="active"><i class="fas fa-history"></i> <span>Transactions</span></a>
                    </div>
                </div>
                <div class="menu-section">
                    <div class="menu-section-title">Management</div>
                    <div class="menu-items">
                        <a href="<%= contextPath %>/energy-sources"><i class="fas fa-solar-panel"></i> <span>Energy Sources</span></a>
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
                <div class="topbar-title">Transactions</div>
                <div class="user-menu">
                    <div class="notification-icon"><i class="fas fa-bell"></i></div>
                    <div class="user-profile"><i class="fas fa-user"></i></div>
                </div>
            </div>
            <div class="data-section">
                <div class="section-header">
                    <div class="section-title">Transaction History</div>
                    <div class="section-actions">
                        <button class="btn"><i class="fas fa-filter"></i> <span>Filter</span></button>
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
                                <th>Total Price ($)</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty transactions}">
                                <tr>
                                    <td colspan="7" style="text-align: center;">No transactions available.</td>
                                </tr>
                            </c:if>
                            <c:forEach var="transaction" items="${transactions}">
                                <tr>
                                    <td>${transaction.transactionId}</td>
                                    <td>${transaction.user}</td>
                                    <td>${transaction.energyType}</td>
                                    <td>${transaction.amount}</td>
                                    <td>${transaction.totalPrice}</td>
                                    <td><fmt:formatDate value="${transaction.date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${transaction.status eq 'completed'}">
                                                <span class="status status-completed">Completed</span>
                                            </c:when>
                                            <c:when test="${transaction.status eq 'pending'}">
                                                <span class="status status-pending">Pending</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status status-failed">${transaction.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script>
        function openModal(modalId) {
            document.getElementById(modalId).style.display = 'flex';
        }
        function closeModal() {
            document.querySelectorAll('.modal').forEach(modal => {
                modal.style.display = 'none';
            });
        }
        window.addEventListener('click', function(event) {
            const modals = [];
            modals.forEach(id => {
                const modal = document.getElementById(id);
                if (event.target === modal) {
                    closeModal();
                }
            });
        });
    </script>
</body>
</html>