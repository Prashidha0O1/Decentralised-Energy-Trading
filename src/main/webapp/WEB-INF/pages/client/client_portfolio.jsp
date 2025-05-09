<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Client Portfolio</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: var(--bg-secondary);
            padding: 20px;
            border-right: 1px solid var(--border);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: bold;
            font-size: 1.4rem;
            margin-bottom: 30px;
            color: var(--text-primary);
            text-decoration: none;
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

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .nav-links a {
            color: var(--text-primary);
            text-decoration: none;
            font-size: 14px;
            padding: 10px;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .nav-links a:hover,
        .nav-links a.active {
            background-color: var(--bg-tertiary);
            color: var(--primary);
        }

        .content {
            flex: 1;
            padding: 40px;
        }

        .welcome-message {
            font-size: 1.5rem;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .portfolio-details {
            background-color: var(--bg-tertiary);
            padding: 20px;
            border-radius: 8px;
            border: 1px solid var(--border);
            margin-bottom: 20px;
            position: relative;
        }

        .portfolio-details h2 {
            font-size: 1.2rem;
            margin-bottom: 10px;
        }

        .portfolio-details p {
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: 5px;
        }

        .update-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: var(--primary);
            color: var(--bg-primary);
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s;
        }

        .update-button:hover {
            background-color: #d4a009;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: var(--bg-secondary);
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            border: 1px solid var(--border);
        }

        .modal-content h2 {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            color: var(--text-primary);
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid var(--border);
            border-radius: 6px;
            background-color: var(--bg-tertiary);
            color: var(--text-primary);
            font-size: 14px;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .form-actions button {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
        }

        .save-button {
            background-color: var(--success);
            color: var(--text-primary);
            border: none;
        }

        .cancel-button {
            background-color: var(--bg-tertiary);
            color: var(--text-primary);
            border: 1px solid var(--border);
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .transactions-table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--bg-tertiary);
            border-radius: 8px;
            overflow: hidden;
        }

        .transactions-table th,
        .transactions-table td {
            padding: 15px;
            text-align: left;
            font-size: 14px;
            border-bottom: 1px solid var(--border);
        }

        .transactions-table th {
            background-color: var(--bg-secondary);
            color: var(--text-primary);
        }

        .transactions-table td {
            color: var(--text-secondary);
        }

        .message {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .message.success {
            background-color: rgba(2, 192, 118, 0.1);
            color: var(--success);
        }

        .message.error {
            background-color: rgba(246, 70, 93, 0.1);
            color: var(--danger);
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <a href="<%= contextPath %>/" class="logo">
            <div class="logo-icon"><i class="fas fa-bolt"></i></div>
            WattX
        </a>
        <div class="nav-links">
            <a href="<%= contextPath %>/market" class="${param.action == null ? 'active' : ''}">Market</a>
            <a href="<%= contextPath %>/market?action=profile" class="${param.action == 'portfolio' ? 'active' : ''}">Portfolio</a>
            <a href="<%= contextPath %>/logout">Logout</a>
        </div>
    </div>
    <div class="content">
        <div class="welcome-message">Welcome, ${user.username}!</div>
        <div class="portfolio-details">
            <h2>Your Profile</h2>
            <p>Username: ${user.username}</p>
            <p>Email: ${user.email}</p>
            <button class="update-button" onclick="openUpdateForm()">Update Profile</button>
        </div>
        <div class="section-title">Transaction History</div>
        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="message success">${success}</div>
        </c:if>
        <table class="transactions-table">
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Energy Type</th>
                    <th>Quantity (kWh)</th>
                    <th>Total Price ($)</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty transactions}">
                    <tr>
                        <td colspan="5">No transactions found.</td>
                    </tr>
                </c:if>
                <c:forEach var="transaction" items="${transactions}">
                    <tr>
                        <td>${transaction.transactionId}</td>
                        <td>${transaction.energyType}</td>
                        <td>${transaction.quantity}</td>
                        <td>${transaction.totalPrice}</td>
                        <td><fmt:formatDate value="${transaction.transactionDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="modal" id="updateProfileModal">
        <div class="modal-content">
            <h2>Update Profile</h2>
            <form id="updateProfileForm" action="<%= contextPath %>/updateProfile" method="POST">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" value="${user.username}" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="${user.email}" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="save-button">Save Changes</button>
                    <button type="button" class="cancel-button" onclick="closeUpdateForm()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openUpdateForm() {
            document.getElementById('updateProfileModal').style.display = 'flex';
        }

        function closeUpdateForm() {
            document.getElementById('updateProfileModal').style.display = 'none';
        }

        // Close modal when clicking outside
        document.getElementById('updateProfileModal').addEventListener('click', function(event) {
            if (event.target === this) {
                closeUpdateForm();
            }
        });
    </script>
</body>
</html>