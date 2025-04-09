<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | WattX</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #0066ff;
            --primary-dark: #0055cc;
            --dark-bg: #0a0e17;
            --sidebar-bg: #0c111f;
            --card-bg: rgba(255, 255, 255, 0.05);
            --text-light: rgba(255, 255, 255, 0.9);
            --text-lighter: rgba(255, 255, 255, 0.6);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: var(--dark-bg);
            color: white;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: var(--sidebar-bg);
            padding: 20px 0;
            height: 100vh;
            position: fixed;
            border-right: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            padding: 0 20px 30px;
            text-align: center;
        }

        .logo h2 {
            font-size: 22px;
            margin-top: 10px;
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 5px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: var(--text-lighter);
            text-decoration: none;
            transition: all 0.3s;
        }

        .nav-link:hover, .nav-link.active {
            background-color: rgba(0, 102, 255, 0.2);
            color: white;
            border-left: 3px solid var(--primary);
        }

        .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 30px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 24px;
        }

        .user-menu {
            display: flex;
            align-items: center;
        }

        .user-menu img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-left: 15px;
        }

        /* Dashboard Cards */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background-color: var(--card-bg);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            backdrop-filter: blur(5px);
        }

        .card h3 {
            font-size: 14px;
            color: var(--text-lighter);
            margin-bottom: 10px;
        }

        .card .value {
            font-size: 24px;
            font-weight: bold;
        }

        /* Tables */
        .table-container {
            background-color: var(--card-bg);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            overflow-x: auto;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .table-title {
            font-size: 18px;
        }

        .search-box {
            display: flex;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            padding: 8px 12px;
        }

        .search-box input {
            background: transparent;
            border: none;
            color: white;
            margin-left: 8px;
            outline: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        th {
            color: var(--text-lighter);
            font-weight: normal;
            font-size: 14px;
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.03);
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-pending {
            background-color: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .status-completed {
            background-color: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .status-cancelled {
            background-color: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        .action-btn {
            background-color: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 12px;
        }

        .action-btn:hover {
            background-color: var(--primary);
            color: white;
        }

        .action-btn.delete {
            border-color: #dc3545;
            color: #dc3545;
        }

        .action-btn.delete:hover {
            background-color: #dc3545;
            color: white;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .stats-cards {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
                overflow: hidden;
            }
            .sidebar .logo-text, .nav-link span {
                display: none;
            }
            .main-content {
                margin-left: 70px;
            }
            .stats-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <div class="logo-icon">
                <svg width="30" height="30" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 2L3 6V18L12 22L21 18V6L12 2Z" stroke="var(--primary)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M12 22V12" stroke="var(--primary)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M7 12L17 7" stroke="var(--primary)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <h2>WattX</h2>
        </div>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="<%= contextPath %>/admin/dashboard" class="nav-link active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= contextPath %>/admin/trades" class="nav-link">
                    <i class="fas fa-exchange-alt"></i>
                    <span>Trades</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= contextPath %>/admin/users" class="nav-link">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= contextPath %>/admin/assets" class="nav-link">
                    <i class="fas fa-bolt"></i>
                    <span>Energy Assets</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= contextPath %>/admin/settings" class="nav-link">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Admin Dashboard</h1>
            <div class="user-menu">
                <span>Admin User</span>
                <img src="https://ui-avatars.com/api/?name=Admin+User&background=0066ff&color=fff" alt="Admin">
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="card">
                <h3>Total Trades</h3>
                <div class="value">1,248</div>
            </div>
            <div class="card">
                <h3>Pending Requests</h3>
                <div class="value">42</div>
            </div>
            <div class="card">
                <h3>Completed Today</h3>
                <div class="value">87</div>
            </div>
            <div class="card">
                <h3>Total Volume (kWh)</h3>
                <div class="value">12,456</div>
            </div>
        </div>

        <!-- Trade Requests Table -->
        <div class="table-container">
            <div class="table-header">
                <h2 class="table-title">Pending Trade Requests</h2>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search requests...">
                </div>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Type</th>
                        <th>Asset</th>
                        <th>Amount (kWh)</th>
                        <th>Price/Unit</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#TR-1001</td>
                        <td>john.doe@email.com</td>
                        <td>Buy</td>
                        <td>Solar</td>
                        <td>150.00</td>
                        <td>$2.45</td>
                        <td>2023-06-15 14:30</td>
                        <td><span class="status status-pending">Pending</span></td>
                        <td>
                            <button class="action-btn">Approve</button>
                            <button class="action-btn delete">Reject</button>
                        </td>
                    </tr>
                    <tr>
                        <td>#TR-1002</td>
                        <td>jane.smith@email.com</td>
                        <td>Sell</td>
                        <td>Wind</td>
                        <td>85.50</td>
                        <td>$3.10</td>
                        <td>2023-06-15 13:45</td>
                        <td><span class="status status-pending">Pending</span></td>
                        <td>
                            <button class="action-btn">Approve</button>
                            <button class="action-btn delete">Reject</button>
                        </td>
                    </tr>
                    <!-- More rows would be dynamically generated from server-side data -->
                </tbody>
            </table>
        </div>

        <!-- Recent Orders Table -->
        <div class="table-container">
            <div class="table-header">
                <h2 class="table-title">Recent Completed Orders</h2>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search orders...">
                </div>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Buyer</th>
                        <th>Seller</th>
                        <th>Asset</th>
                        <th>Amount (kWh)</th>
                        <th>Total Value</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#ORD-5001</td>
                        <td>energy_co@email.com</td>
                        <td>solar_farm@email.com</td>
                        <td>Solar</td>
                        <td>200.00</td>
                        <td>$490.00</td>
                        <td>2023-06-15 12:20</td>
                        <td><span class="status status-completed">Completed</span></td>
                    </tr>
                    <tr>
                        <td>#ORD-5002</td>
                        <td>wind_energy@email.com</td>
                        <td>green_power@email.com</td>
                        <td>Wind</td>
                        <td>120.50</td>
                        <td>$372.55</td>
                        <td>2023-06-15 11:05</td>
                        <td><span class="status status-completed">Completed</span></td>
                    </tr>
                    <!-- More rows would be dynamically generated from server-side data -->
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>