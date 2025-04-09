<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Decentralised Energy Trading Platform</title>
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
            background-color: var(--bg-tertiary);
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
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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
            margin-bottom: 30px;
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
            background-color: var(--bg-tertiary);
            color: var(--text-primary);
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background-color: var(--primary);
            color: var(--secondary);
        }
        
        .btn:hover {
            opacity: 0.9;
        }
        
        /* Add these styles to your existing CSS */
		.data-table {
		    width: 100%;
		    background-color: var(--bg-secondary);
		    border-radius: 10px;
		    overflow: hidden;
		    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
		    position: relative;
		}
		
		.data-table table {
		    width: 100%;
		    border-collapse: separate;
		    border-spacing: 0;
		}
		
		.data-table th {
		    background-color: var(--bg-tertiary);
		    text-align: left;
		    padding: 15px;
		    font-weight: 500;
		    color: var(--text-secondary);
		    position: relative;
		    z-index: 1;
		}
		
		.data-table td {
		    padding: 15px;
		    border-top: 1px solid var(--border);
		    transition: all 0.3s ease;
		}
		
		.data-table tbody tr {
		    position: relative;
		    transition: all 0.3s ease;
		}
		
		/* This is the key effect */
		.data-table tbody tr:hover {
		    transform: translateY(-4px) scale(1.01);
		    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
		    z-index: 10;
		    background-color: var(--bg-secondary);
		}
		
		/* Blur effect for other rows when one is hovered */
		.data-table tbody:hover tr:not(:hover) {
		    filter: blur(1px);
		    opacity: 0.7;
		}
		
		/* Reset blur when mouse leaves the table */
		.data-table tbody:not(:hover) tr {
		    filter: blur(0);
		    opacity: 1;
		}
		
		
        
        .energy-chart {
            background-color: var(--bg-secondary);
            border-radius: 10px;
            padding: 20px;
            height: 400px;
        }
        
        .chart-section {
            margin-bottom: 40px; /* Increase spacing between chart and table */
        }
        
        .chart-container {
            height: 400px;
            display: grid;
            grid-template-rows: 1fr;
            gap: 20px;
        }
        
        /* Make sure the data-table doesn't overlap with other elements */
        .data-table {
            margin-top: 420px;
            clear: both; /* Ensure it clears any floating elements */
        }
        
        /* Option to show only one chart instead of two */
        .single-chart {
            height: 100%;
            width: 100%;
        }

        .status {
		    padding: 5px 10px;
		    border-radius: 20px;
		    font-size: 0.8rem;
		    font-weight: 500;
		    display: inline-block;
		    transition: all 0.3s ease;
		}
	
		.data-table tr:hover .status {
		    transform: scale(1.05);
		    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
		}
		
		.status-completed {
		    background-color: rgba(2, 192, 118, 0.15);
		    color: var(--success);
		}
		
		.status-pending {
		    background-color: rgba(240, 185, 11, 0.15);
		    color: var(--primary);
		}
		
		.status-failed {
		    background-color: rgba(246, 70, 93, 0.15);
		    color: var(--danger);
		}
        
        /* Responsive styles */
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
                    <div class="logo-icon">W</div>
                    <span>WattX</span>
                </div>
            </div>
            
            <div class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-section-title">Dashboard</div>
                    <div class="menu-items">
                        <a href="#" class="active">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Overview</span>
                        </a>
                        <a href="#">
                            <i class="fas fa-bolt"></i>
                            <span>Energy Market</span>
                        </a>
                        <a href="#">
                            <i class="fas fa-exchange-alt"></i>
                            <span>Transactions</span>
                        </a>
                        <a href="#">
                            <i class="fas fa-chart-line"></i>
                            <span>Analytics</span>
                        </a>
                    </div>
                </div>
                
                <div class="menu-section">
                    <div class="menu-section-title">Management</div>
                    <div class="menu-items">
                        <a href="#">
                            <i class="fas fa-users"></i>
                            <span>Users</span>
                        </a>
                        <a href="#">
                            <i class="fas fa-solar-panel"></i>
                            <span>Energy Sources</span>
                        </a>
                        <a href="#">
                            <i class="fas fa-wallet"></i>
                            <span>Wallets</span>
                        </a>
                    </div>
                </div>
                
                <div class="menu-section">
                    <div class="menu-section-title">Settings</div>
                    <div class="menu-items">
                        <a href="#">
                            <i class="fas fa-cog"></i>
                            <span>General</span>
                        </a>
                        <a href="#">
                            <i class="fas fa-shield-alt"></i>
                            <span>Security</span>
                        </a>
                        <a href="#">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="content">
            <div class="topbar">
                <div class="topbar-title">WattX Dashboard</div>
                <div class="user-menu">
                    <div class="notification-icon">
                        <i class="fas fa-bell"></i>
                    </div>
                    <div class="user-profile">
                        <i class="fas fa-user"></i>
                    </div>
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
                        <button class="btn">
                            <i class="fas fa-filter"></i>
                            <span>Filter</span>
                        </button>
                        <button class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            <span>New Trade</span>
                        </button>
                    </div>
                </div>
                
                <div class="energy-chart">
                    <div class="chart-container">
                        <canvas id="energyChart"></canvas>
                    </div>
                </div>
            </div>
            
            <div class="data-section">
                <div class="section-header">
                    <div class="section-title">Recent Transactions</div>
                    <div class="section-actions">
                        <button class="btn">
                            <i class="fas fa-download"></i>
                            <span>Export</span>
                        </button>
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
                            // This would typically come from your database or backend service
                            // Here we're just showing an example of how JSP would be used
                            // In a real implementation, you would fetch this data from your backend
                            
                            // Sample data for demonstration
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
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Get the transaction data from JSP
            <% 
            // This would typically come from your database
            // We're using the same sample data from your transactions table
            String[][] Transactions = {
                {"TX-78954", "Alice Smith", "Solar", "42.5", "$5.10", "2025-04-08 09:23:15", "Completed"},
                {"TX-78953", "Bob Johnson", "Wind", "31.2", "$3.74", "2025-04-08 08:57:42", "Completed"},
                {"TX-78952", "Charlie Brown", "Hydro", "55.0", "$6.60", "2025-04-08 08:35:19", "Pending"},
                {"TX-78951", "Diana Prince", "Solar", "28.7", "$3.44", "2025-04-08 08:12:56", "Completed"},
                {"TX-78950", "Edward Wilson", "Biomass", "63.1", "$7.57", "2025-04-08 07:48:33", "Failed"}
            };
            
            // Prepare data for the chart
            // Create maps to hold totals by energy type
            java.util.Map<String, Double> energyByType = new java.util.HashMap<>();
            
            for(int i = 0; i < transactions.length; i++) {
                String energyType = transactions[i][2];
                double amount = Double.parseDouble(transactions[i][3]);
                
                // Add to total for this energy type
                if(energyByType.containsKey(energyType)) {
                    energyByType.put(energyType, energyByType.get(energyType) + amount);
                } else {
                    energyByType.put(energyType, amount);
                }
            }
            
            // Convert to JSON-like strings for JavaScript
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
            %>
            
            // Chart configuration
            const ctx = document.getElementById('energyChart').getContext('2d');
            const energyChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: <%= labels.toString() %>,
                    datasets: [{
                        label: 'Energy Amount (kWh)',
                        data: <%= data.toString() %>,
                        backgroundColor: [
                            'rgba(255, 205, 86, 0.7)',  // Yellow for Solar
                            'rgba(54, 162, 235, 0.7)',  // Blue for Wind
                            'rgba(75, 192, 192, 0.7)',  // Teal for Hydro
                            'rgba(75, 162, 86, 0.7)'    // Green for Biomass
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
                            labels: {
                                color: '#F3F3F3'  // Match your theme text color
                            }
                        },
                        title: {
                            display: true,
                            text: 'Energy Traded by Source Type (kWh)',
                            color: '#F3F3F3',
                            font: {
                                size: 16
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#848E9C'
                            }
                        },
                        x: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#848E9C'
                            }
                        }
                    }
                }
            });
            
            // Add a secondary chart for a line graph showing transaction timeline
            const timelineCtx = document.createElement('canvas');
            timelineCtx.id = 'timelineChart';
            document.querySelector('.chart-container').appendChild(timelineCtx);
            
            // Sort transactions by date for timeline
            <% 
            // Create arrays for timeline chart
            StringBuilder timeLabels = new StringBuilder("[");
            StringBuilder timeData = new StringBuilder("[");
            
            // Sort array by date (simple bubble sort for demonstration)
            for(int i = 0; i < transactions.length - 1; i++) {
                for(int j = 0; j < transactions.length - i - 1; j++) {
                    if(transactions[j][5].compareTo(transactions[j + 1][5]) > 0) {
                        String[] temp = transactions[j];
                        transactions[j] = transactions[j + 1];
                        transactions[j + 1] = temp;
                    }
                }
            }
            
            // Generate timeline data
            first = true;
            for(int i = 0; i < transactions.length; i++) {
                if(!first) {
                    timeLabels.append(",");
                    timeData.append(",");
                }
                // Format time for display (extract just the time portion)
                String timeOnly = transactions[i][5].split(" ")[1].substring(0, 5);
                timeLabels.append("\"").append(timeOnly).append("\"");
                timeData.append(transactions[i][3]);
                first = false;
            }
            
            timeLabels.append("]");
            timeData.append("]");
            %>
            
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
                            labels: {
                                color: '#F3F3F3'
                            }
                        },
                        title: {
                            display: true,
                            text: 'Energy Transaction Timeline (Today)',
                            color: '#F3F3F3',
                            font: {
                                size: 16
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#848E9C'
                            }
                        },
                        x: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#848E9C'
                            }
                        }
                    }
                }
            });
            
            // Set chart container styles to accommodate two charts
            document.querySelector('.chart-container').style.display = 'grid';
            document.querySelector('.chart-container').style.gridTemplateRows = '1fr 1fr';
            document.querySelector('.chart-container').style.gap = '20px';
        });
    </script>
</body>
</html>