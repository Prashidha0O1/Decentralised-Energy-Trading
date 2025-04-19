<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Client Dashboard</title>
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
        
        .listings-section {
            background-color: var(--bg-secondary);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid var(--border);
            margin-bottom: 20px;
        }
        
        .section-title {
            font-size: 1.2rem;
            font-weight: 500;
            margin-bottom: 15px;
        }
        
        .listings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .listing-card {
            background-color: var(--bg-tertiary);
            padding: 15px;
            border-radius: 8px;
            border: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            gap: 10px;
            position: relative;
        }
        
        .listing-card h3 {
            font-size: 1.1rem;
            text-transform: capitalize;
        }
        
        .listing-card p {
            font-size: 14px;
            color: var(--text-secondary);
        }
        
        .btn {
            background-color: var(--primary);
            color: var(--bg-primary);
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.2s;
            border: none;
            cursor: pointer;
            text-align: center;
        }
        
        .btn:hover {
            background-color: #d4a00a;
        }
        
        .btn-buy {
            position: relative;
        }
        
        .btn-buy .tooltip {
            visibility: hidden;
            background-color: var(--bg-secondary);
            color: var(--text-primary);
            text-align: center;
            border-radius: 6px;
            padding: 5px 10px;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            transform: translateX(-50%);
            font-size: 12px;
            border: 1px solid var(--border);
            opacity: 0;
            transition: opacity 0.3s;
        }
        
        .btn-buy:hover .tooltip {
            visibility: visible;
            opacity: 1;
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
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            max-width: 90%;
            border: 1px solid var(--border);
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
        }
        
        .close-btn:hover {
            color: var(--text-primary);
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
        }
        
        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid var(--border);
            background-color: var(--bg-tertiary);
            color: var(--text-primary);
            font-size: 14px;
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
    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <div class="logo-icon"><i class="fas fa-bolt"></i></div>
                    WattX
                </div>
            </div>
            <div class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-section-title">Main</div>
                    <div class="menu-items">
                        <a href="<%= contextPath %>/dashboard" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                        <a href="#"><i class="fas fa-shopping-cart"></i> Purchases</a>
                    </div>
                </div>
                <div class="menu-section">
                    <div class="menu-section-title">Settings</div>
                    <div class="menu-items">
                        <a href="#"><i class="fas fa-user"></i> Profile</a>
                        <a href="<%= contextPath %>/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="topbar">
                <div class="topbar-title">Dashboard</div>
                <div class="user-menu">
                    <div class="notification-icon"><i class="fas fa-bell"></i></div>
                    <div class="user-profile"><i class="fas fa-user"></i></div>
                </div>
            </div>
            <div class="listings-section">
                <div class="section-title">Available Energy Listings</div>
                <c:if test="${not empty error}">
                    <div class="message error">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="message success">${success}</div>
                </c:if>
                <div class="listings-grid">
                    <c:if test="${empty listings}">
                        <p>No available listings at the moment.</p>
                    </c:if>
                    <c:forEach var="listing" items="${listings}">
                        <div class="listing-card">
                            <h3>${listing.energyType}</h3>
                            <p>Quantity: ${listing.quantity} kWh</p>
                            <p>Price: $${listing.pricePerKwh}/kWh</p>
                            <form action="<%= contextPath %>/dashboard" method="GET" style="margin: 0;">
                                <input type="hidden" name="action" value="buy">
                                <input type="hidden" name="listingId" value="${listing.listingId}">
                                <button type="submit" class="btn btn-buy">
                                    Buy
                                    <span class="tooltip">Buy ${listing.energyType} at $${listing.pricePerKwh}/kWh</span>
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <!-- Purchase Modal -->
    <div id="purchaseModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">Purchase Energy Listing</div>
                <button class="close-btn" onclick="closeModal()">×</button>
            </div>
            <form action="<%= contextPath %>/dashboard" method="POST">
                <input type="hidden" name="action" value="purchase">
                <input type="hidden" name="listingId" value="${listing != null ? listing.listingId : ''}">
                <div class="form-group">
                    <label for="buyerEmail">Your Email</label>
                    <input type="email" id="buyerEmail" name="buyerEmail" placeholder="e.g., user@example.com" required>
                </div>
                <div class="form-group">
                    <p>Energy Type: ${listing != null ? listing.energyType : ''}</p>
                    <p>Quantity: ${listing != null ? listing.quantity : ''} kWh</p>
                    <p>Price: $${listing != null ? listing.pricePerKwh : ''}/kWh</p>
                    <p>Total: $${listing != null ? listing.quantity * listing.pricePerKwh : ''}</p>
                </div>
                <button type="submit" class="btn btn-primary">Confirm Purchase</button>
            </form>
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

        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            const purchaseModal = document.getElementById('purchaseModal');
            if (event.target === purchaseModal) {
                closeModal();
            }
        });

        // Auto-open Purchase Modal if in buy mode
        <c:if test="${not empty listing}">
            openModal('purchaseModal');
        </c:if>
    </script>
</body>
</html>