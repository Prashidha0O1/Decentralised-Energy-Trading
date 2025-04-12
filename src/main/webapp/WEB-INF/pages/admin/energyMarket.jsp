<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Energy Market</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- your main CSS file -->
    <style>
        body {
            background-color: #0b0e11;
            color: #eaecef;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-left: 220px; /* Adjust if sidebar is fixed */
            padding: 30px;
        }

        h1 {
            color: #f0b90b;
            font-size: 28px;
        }

        .market-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background-color: #1e2329;
            border-radius: 8px;
            overflow: hidden;
        }

        .market-table th, .market-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #2e3239;
        }

        .market-table th {
            background-color: #161a1e;
            color: #f0b90b;
            font-weight: 600;
        }

        .market-table tr:hover {
            background-color: #2a2e35;
        }
    </style>
</head>
<body>
     <!-- Including the sidebar -->

    <div class="container">
        <h1>Energy Market</h1>
        <table class="market-table">
            <thead>
                <tr>
                    <th>Provider</th>
                    <th>Location</th>
                    <th>Available Units</th>
                    <th>Price / Unit</th>
                    <th>Buy</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>GreenVolt</td>
                    <td>Kathmandu</td>
                    <td>500 kWh</td>
                    <td>₿0.00012</td>
                    <td><button>Buy</button></td>
                </tr>
                <tr>
                    <td>SolarTech</td>
                    <td>Pokhara</td>
                    <td>300 kWh</td>
                    <td>₿0.00015</td>
                    <td><button>Buy</button></td>
                </tr>
                <!-- Add more rows as needed -->
            </tbody>
        </table>
    </div>
</body>
</html>
