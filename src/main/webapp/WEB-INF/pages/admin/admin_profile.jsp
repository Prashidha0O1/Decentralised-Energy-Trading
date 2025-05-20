<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Profile</title>
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
    .profile-section {
        background-color: var(--bg-secondary);
        border-radius: 10px;
        padding: 20px;
        border: 1px solid var(--border);
    }
    .profile-details {
        display: grid;
        gap: 15px;
    }
    .detail-item {
        display: flex;
        justify-content: space-between;
        padding: 10px;
        background-color: var(--bg-tertiary);
        border-radius: 6px;
    }
    .detail-item label {
        color: var(--text-secondary);
        font-size: 14px;
    }
    .detail-item span {
        font-size: 14px;
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
    .form-group input {
        width: 100%;
        padding: 10px;
        background-color: var(--bg-tertiary);
        border: 1px solid var(--border);
        border-radius: 6px;
        color: var(--text-primary);
        font-size: 14px;
    }
    .form-group input:focus {
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
                        <a href="<%= contextPath %>/energy-sources"><i class="fas fa-solar-panel"></i> <span>Energy Sources</span></a>
                    </div>
                </div>
                <div class="menu-section">
                    <div class="menu-section-title">Settings</div>
                    <div class="menu-items">
                        <a href="<%= contextPath %>/admin-profile" class="active"><i class="fas fa-user"></i> <span>Profile</span></a>
                        <a href="<%= contextPath %>/logout"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="topbar">
                <div class="topbar-title">Profile</div>
                <div class="user-menu">
                    <div class="notification-icon"><i class="fas fa-bell"></i></div>
                    <div class="user-profile"><i class="fas fa-user"></i></div>
                </div>
            </div>
            <div class="profile-section">
                <div class="section-header">
                    <div class="section-title">Admin Profile</div>
                    <button class="btn" onclick="openModal('editProfileModal')"><i class="fas fa-edit"></i> <span>Edit Profile</span></button>
                </div>
                <c:if test="${not empty error}">
                    <div class="message error">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="message success">${success}</div>
                </c:if>
                <div class="profile-details">
                    <div class="detail-item">
                        <label>Username:</label>
                        <span>${user.username}</span>
                    </div>
                    <div class="detail-item">
                        <label>Email:</label>
                        <span>${user.email}</span>
                    </div>
                    <div class="detail-item">
                        <label>Role:</label>
                        <span>${user.role}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Edit Profile -->
    <div id="editProfileModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">Edit Profile</div>
                <button class="close-btn" onclick="closeModal()">×</button>
            </div>
            <form action="<%= contextPath %>/admin-profile" method="POST">
                <input type="hidden" name="action" value="update">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" value="${user.username}" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="${user.email}" required>
                </div>
                <div class="form-group">
                    <label for="password">New Password (leave blank to keep current)</label>
                    <input type="password" id="password" name="password">
                </div>
                <button type="submit" class="btn btn-primary">Save Changes</button>
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
        window.addEventListener('click', function(event) {
            const modals = ['editProfileModal'];
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