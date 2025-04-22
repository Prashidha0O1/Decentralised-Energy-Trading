<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX | Decentralized Energy Trading Platform</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style> 

:root {
	--binance-yellow: #F0B90B;
	--binance-black: #1E2026;
	--binance-dark: #0B0E11;
	--binance-gray: #474D57;
	--binance-light-gray: #B7BDC6;
	--binance-green: #03A66D;
	--binance-red: #CF304A;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'IBM Plex Sans', sans-serif;
	color: #fff;
	background-color: var(--binance-black);
	line-height: 1.6;
	overflow-x: hidden;
}

.container {
	width: 100%;
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

/* Header & Navigation */
header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
	background-color: var(--binance-dark);
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

nav {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 0;
}

.logo {
	font-size: 24px;
	font-weight: 700;
	color: var(--binance-yellow);
	display: flex;
	align-items: center;
}

.logo span {
	color: #fff;
}

.logo-icon {
	width: 30px;
	height: 30px;
	margin-right: 10px;
	background: var(--binance-yellow);
	border-radius: 50%;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	color: var(--binance-black);
	font-weight: bold;
}

.nav-links {
	display: flex;
	list-style: none;
}

.nav-links li {
	margin-left: 30px;
}

.nav-links a {
	text-decoration: none;
	color: #fff;
	font-weight: 500;
	transition: color 0.3s;
}

.nav-links a:hover {
	color: var(--binance-yellow);
}

.btn {
	display: inline-block;
	padding: 10px 24px;
	background: var(--binance-yellow);
	color: var(--binance-black);
	border-radius: 4px;
	font-weight: 600;
	text-decoration: none;
	transition: all 0.3s;
	border: none;
	cursor: pointer;
}

.btn:hover {
	background: #ffcb3d;
	transform: translateY(-2px);
}

.btn-outline {
	background: transparent;
	border: 1px solid var(--binance-yellow);
	color: var(--binance-yellow);
}

.btn-outline:hover {
	background: var(--binance-yellow);
	color: var(--binance-black);
}

/* Hero Section */
.hero {
	padding: 160px 0 100px;
	background: var(--binance-dark);
	position: relative;
	overflow: hidden;
}

.hero::before {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	width: 50%;
	height: 100%;
	background: url('/placeholder.svg?height=600&width=800') center/cover;
	opacity: 0.1;
	z-index: 1;
}

.hero-content {
	position: relative;
	z-index: 2;
	max-width: 650px;
}

.hero h1 {
	font-size: 3.5rem;
	font-weight: 700;
	margin-bottom: 20px;
	line-height: 1.2;
}

.hero h1 span {
	color: var(--binance-yellow);
}

.hero p {
	font-size: 1.2rem;
	margin-bottom: 30px;
	color: var(--binance-light-gray);
}

.hero-btns {
	display: flex;
	gap: 15px;
}

.market-ticker {
	margin-top: 60px;
	background: rgba(30, 32, 38, 0.7);
	border: 1px solid #2c2f36;
	border-radius: 8px;
	padding: 15px;
	overflow-x: auto;
}

.ticker-items {
	display: flex;
	gap: 30px;
	min-width: 800px;
}

.ticker-item {
	display: flex;
	flex-direction: column;
}

.ticker-pair {
	font-weight: 600;
	display: flex;
	align-items: center;
	gap: 5px;
}

.ticker-price {
	font-size: 1.2rem;
	font-weight: 700;
}

.ticker-change {
	font-size: 0.9rem;
}

.up {
	color: var(--binance-green);
}

.down {
	color: var(--binance-red);
}

/* Features Section */
.features {
	padding: 100px 0;
	background-color: var(--binance-black);
}

.section-header {
	text-align: center;
	margin-bottom: 60px;
}

.section-header h2 {
	font-size: 2.5rem;
	font-weight: 700;
	margin-bottom: 15px;
	position: relative;
	display: inline-block;
}

.section-header h2 span {
	color: var(--binance-yellow);
}

.section-header p {
	font-size: 1.1rem;
	color: var(--binance-light-gray);
	max-width: 700px;
	margin: 0 auto;
}

.features-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
	margin-top: 50px;
}

.feature-card {
	background-color: var(--binance-dark);
	border-radius: 8px;
	padding: 30px;
	transition: transform 0.3s, box-shadow 0.3s;
	border: 1px solid #2c2f36;
}

.feature-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	border-color: var(--binance-yellow);
}

.feature-icon {
	width: 60px;
	height: 60px;
	background: rgba(240, 185, 11, 0.1);
	border-radius: 8px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 20px;
	color: var(--binance-yellow);
	font-size: 24px;
}

.feature-card h3 {
	font-size: 1.5rem;
	margin-bottom: 15px;
	font-weight: 600;
}

.feature-card p {
	color: var(--binance-light-gray);
}

/* Trading View Section */
.trading-view {
	padding: 100px 0;
	background-color: var(--binance-dark);
	position: relative;
}

.trading-interface {
	background-color: var(--binance-black);
	border-radius: 8px;
	border: 1px solid #2c2f36;
	overflow: hidden;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.trading-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 20px;
	border-bottom: 1px solid #2c2f36;
}

.trading-pair {
	display: flex;
	align-items: center;
	gap: 10px;
	font-weight: 600;
}

.trading-pair-icon {
	width: 24px;
	height: 24px;
	background: var(--binance-yellow);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 12px;
	color: var(--binance-black);
}

.trading-price {
	font-size: 1.2rem;
	font-weight: 700;
	color: var(--binance-green);
}

.trading-tabs {
	display: flex;
	gap: 20px;
}

.trading-tab {
	padding: 5px 10px;
	cursor: pointer;
	border-radius: 4px;
	transition: background-color 0.3s;
}

.trading-tab.active {
	background-color: rgba(240, 185, 11, 0.1);
	color: var(--binance-yellow);
}

.chart-container {
	height: 400px;
	background: url('/placeholder.svg?height=400&width=1000') center/cover;
	position: relative;
}

.chart-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(11, 14, 17, 0.7);
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
}

.chart-overlay h3 {
	font-size: 1.8rem;
	margin-bottom: 20px;
}

.trading-actions {
	display: flex;
	padding: 20px;
	border-top: 1px solid #2c2f36;
	gap: 15px;
}

.action-btn {
	flex: 1;
	padding: 12px;
	border-radius: 4px;
	font-weight: 600;
	text-align: center;
	cursor: pointer;
}

.buy-btn {
	background-color: var(--binance-green);
	color: white;
}

.sell-btn {
	background-color: var(--binance-red);
	color: white;
}

/* How It Works */
.how-it-works {
	padding: 100px 0;
	background-color: var(--binance-black);
	position: relative;
}

.steps {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	margin-top: 50px;
	position: relative;
}

.steps::before {
	content: '';
	position: absolute;
	top: 40px;
	left: 0;
	width: 100%;
	height: 2px;
	background: #2c2f36;
	z-index: 1;
}

.step {
	flex: 1;
	min-width: 250px;
	text-align: center;
	padding: 0 20px;
	position: relative;
	z-index: 2;
}

.step-number {
	width: 80px;
	height: 80px;
	background: var(--binance-dark);
	border: 2px solid var(--binance-yellow);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 20px;
	font-size: 1.8rem;
	font-weight: 700;
	color: var(--binance-yellow);
}

.step h3 {
	font-size: 1.3rem;
	margin-bottom: 15px;
	font-weight: 600;
}

.step p {
	color: var(--binance-light-gray);
}

/* Stats Section */
.stats {
	padding: 100px 0;
	background-color: var(--binance-dark);
}

.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 30px;
	margin-top: 50px;
}

.stat-card {
	background-color: var(--binance-black);
	border-radius: 8px;
	padding: 30px;
	text-align: center;
	border: 1px solid #2c2f36;
}

.stat-value {
	font-size: 2.5rem;
	font-weight: 700;
	margin-bottom: 10px;
	color: var(--binance-yellow);
}

.stat-label {
	color: var(--binance-light-gray);
	font-size: 1.1rem;
}

/* CTA Section */
.cta {
	padding: 100px 0;
	background: linear-gradient(to right, var(--binance-dark),
		var(--binance-black));
	text-align: center;
	position: relative;
	overflow: hidden;
}

.cta::before {
	content: '';
	position: absolute;
	top: -100px;
	right: -100px;
	width: 300px;
	height: 300px;
	background: var(--binance-yellow);
	border-radius: 50%;
	opacity: 0.05;
}

.cta h2 {
	font-size: 2.5rem;
	font-weight: 700;
	margin-bottom: 20px;
}

.cta h2 span {
	color: var(--binance-yellow);
}

.cta p {
	font-size: 1.2rem;
	margin-bottom: 30px;
	max-width: 700px;
	margin-left: auto;
	margin-right: auto;
	color: var(--binance-light-gray);
}

/* Footer */
footer {
	padding: 80px 0 30px;
	background-color: var(--binance-dark);
}

.footer-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 40px;
	margin-bottom: 60px;
}

.footer-col h3 {
	font-size: 1.2rem;
	margin-bottom: 20px;
	font-weight: 600;
	position: relative;
	padding-bottom: 10px;
}

.footer-col h3::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 0;
	width: 40px;
	height: 3px;
	background: var(--binance-yellow);
}

.footer-links {
	list-style: none;
}

.footer-links li {
	margin-bottom: 10px;
}

.footer-links a {
	text-decoration: none;
	color: var(--binance-light-gray);
	transition: color 0.3s;
}

.footer-links a:hover {
	color: var(--binance-yellow);
}

.social-links {
	display: flex;
	gap: 15px;
	margin-top: 20px;
}

.social-link {
	width: 40px;
	height: 40px;
	background-color: rgba(255, 255, 255, 0.1);
	border-radius: 4px;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: background-color 0.3s;
	color: var(--binance-light-gray);
	text-decoration: none;
}

.social-link:hover {
	background-color: var(--binance-yellow);
	color: var(--binance-black);
}

.copyright {
	text-align: center;
	padding-top: 30px;
	border-top: 1px solid #2c2f36;
	color: var(--binance-light-gray);
	font-size: 0.9rem;
}

/* Animations */
@keyframes fadeInUp {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.animate {
	animation: fadeInUp 0.6s ease-out forwards;
}

.delay-1 {
	animation-delay: 0.2s;
}

.delay-2 {
	animation-delay: 0.4s;
}

.delay-3 {
	animation-delay: 0.6s;
}

/* Responsive */
@media ( max-width : 768px) {
	.hero h1 {
		font-size: 2.5rem;
	}
	.nav-links {
		display: none;
	}
	.hero-btns {
		flex-direction: column;
		align-items: flex-start;
	}
	.steps::before {
		display: none;
	}
	.step {
		margin-bottom: 40px;
	}
	.trading-actions {
		flex-direction: column;
	}
}

/* Binance-style candlestick chart */
.candlestick-chart {
	height: 400px;
	width: 100%;
	position: relative;
	overflow: hidden;
}

.chart-grid {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: grid;
	grid-template-rows: repeat(10, 1fr);
	grid-template-columns: repeat(20, 1fr);
}

.grid-line-horizontal {
	border-bottom: 1px solid rgba(44, 47, 54, 0.5);
	grid-column: 1/-1;
}

.grid-line-vertical {
	border-right: 1px solid rgba(44, 47, 54, 0.5);
	grid-row: 1/-1;
}

.candle {
	position: absolute;
	width: 8px;
	background-color: var(--binance-green);
	bottom: 0;
	transform: translateX(-50%);
}

.candle.down {
	background-color: var(--binance-red);
}

.candle-wick {
	position: absolute;
	width: 2px;
	background-color: #fff;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
}

/* Mobile menu */
.mobile-menu-btn {
	display: none;
	background: none;
	border: none;
	color: white;
	font-size: 24px;
	cursor: pointer;
}

@media ( max-width : 768px) {
	.mobile-menu-btn {
		display: block;
	}
}
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container">
            <nav>
                <div class="logo">
                    <div class="logo-icon">⚡</div>
                    Watt<span>X</span>
                </div>
                <ul class="nav-links">
                    <li><a href="#features">Features</a></li>
                    <li><a href="#trading">Trading</a></li>
                    <li><a href="#how-it-works">How It Works</a></li>
                    <li><a href="#stats">Stats</a></li>
                </ul>
                <button class="mobile-menu-btn">☰</button>
                <a href="<%= contextPath %>/create-wallet" class="btn">Register Now</a>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero-content animate">
                <h1>Trade Energy <span>Efficiently</span> on the World's Leading Decentralized Platform</h1>
                <p>EnergyTrade is a secure and transparent platform for peer-to-peer energy trading using blockchain technology. Buy, sell, and trade energy with zero intermediaries.</p>
                <div class="hero-btns">
                    <a href="#" class="btn">Start Trading</a>
                    <a href="#" class="btn btn-outline">Create Account</a>
                </div>
                
                <div class="market-ticker">
                    <div class="ticker-items">
                        <div class="ticker-item">
                            <div class="ticker-pair">
                                <div class="ticker-pair-icon">S</div>
                                SOLAR/USD
                            </div>
                            <div class="ticker-price">0.1243</div>
                            <div class="ticker-change up">+5.67%</div>
                        </div>
                        <div class="ticker-item">
                            <div class="ticker-pair">
                                <div class="ticker-pair-icon">W</div>
                                WIND/USD
                            </div>
                            <div class="ticker-price">0.0892</div>
                            <div class="ticker-change up">+2.34%</div>
                        </div>
                        <div class="ticker-item">
                            <div class="ticker-pair">
                                <div class="ticker-pair-icon">H</div>
                                HYDRO/USD
                            </div>
                            <div class="ticker-price">0.1567</div>
                            <div class="ticker-change down">-1.23%</div>
                        </div>
                        <div class="ticker-item">
                            <div class="ticker-pair">
                                <div class="ticker-pair-icon">B</div>
                                BIO/USD
                            </div>
                            <div class="ticker-price">0.0723</div>
                            <div class="ticker-change up">+3.45%</div>
                        </div>
                        <div class="ticker-item">
                            <div class="ticker-pair">
                                <div class="ticker-pair-icon">G</div>
                                GEO/USD
                            </div>
                            <div class="ticker-price">0.2134</div>
                            <div class="ticker-change up">+0.87%</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
        <div class="container">
            <div class="section-header">
                <h2>Why Choose <span>EnergyTrade</span></h2>
                <p>Our platform offers unique advantages that traditional energy markets can't match</p>
            </div>
            <div class="features-grid">
                <div class="feature-card animate">
                    <div class="feature-icon">🔒</div>
                    <h3>Secure Blockchain Technology</h3>
                    <p>All energy trades are secured by advanced blockchain technology, ensuring transparency and immutability of transactions.</p>
                </div>
                <div class="feature-card animate delay-1">
                    <div class="feature-icon">💰</div>
                    <h3>Zero Intermediary Fees</h3>
                    <p>Trade directly with energy producers and consumers without middlemen, reducing costs significantly.</p>
                </div>
                <div class="feature-card animate delay-2">
                    <div class="feature-icon">⚡</div>
                    <h3>Real-Time Trading</h3>
                    <p>Execute trades instantly with our high-performance matching engine, just like on Binance.</p>
                </div>
                <div class="feature-card animate delay-1">
                    <div class="feature-icon">📊</div>
                    <h3>Advanced Trading Tools</h3>
                    <p>Access professional-grade charts, order books, and trading tools to optimize your energy trading strategy.</p>
                </div>
                <div class="feature-card animate delay-2">
                    <div class="feature-icon">🌐</div>
                    <h3>Global Energy Market</h3>
                    <p>Connect with energy producers and consumers worldwide, expanding your trading opportunities.</p>
                </div>
                <div class="feature-card animate delay-3">
                    <div class="feature-icon">🛡️</div>
                    <h3>Secure Wallet System</h3>
                    <p>Store your energy assets and tokens securely with our industry-leading wallet technology.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Trading View Section -->
    <section class="trading-view" id="trading">
        <div class="container">
            <div class="section-header">
                <h2>Advanced <span>Trading Platform</span></h2>
                <p>Experience professional-grade tools for energy trading</p>
            </div>
            <div class="trading-interface animate">
                <div class="trading-header">
                    <div class="trading-pair">
                        <div class="trading-pair-icon">S</div>
                        SOLAR/USD
                        <span class="trading-price">0.1243</span>
                        <span class="up">+5.67%</span>
                    </div>
                    <div class="trading-tabs">
                        <div class="trading-tab active">Chart</div>
                        <div class="trading-tab">Order Book</div>
                        <div class="trading-tab">Market Trades</div>
                    </div>
                </div>
                <div class="candlestick-chart">
                    <div class="chart-grid">
                        <!-- Grid lines -->
                        <div class="grid-line-horizontal" style="grid-row: 2"></div>
                        <div class="grid-line-horizontal" style="grid-row: 4"></div>
                        <div class="grid-line-horizontal" style="grid-row: 6"></div>
                        <div class="grid-line-horizontal" style="grid-row: 8"></div>
                        <div class="grid-line-horizontal" style="grid-row: 10"></div>
                        
                        <div class="grid-line-vertical" style="grid-column: 5"></div>
                        <div class="grid-line-vertical" style="grid-column: 10"></div>
                        <div class="grid-line-vertical" style="grid-column: 15"></div>
                        <div class="grid-line-vertical" style="grid-column: 20"></div>
                    </div>
                    
                    <!-- Candles will be added with JavaScript -->
                </div>
                <div class="trading-actions">
                    <div class="action-btn buy-btn">Buy SOLAR</div>
                    <div class="action-btn sell-btn">Sell SOLAR</div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works -->
    <section class="how-it-works" id="how-it-works">
        <div class="container">
            <div class="section-header">
                <h2>How <span>EnergyTrade</span> Works</h2>
                <p>Our platform makes decentralized energy trading simple and accessible</p>
            </div>
            <div class="steps">
                <div class="step animate">
                    <div class="step-number">1</div>
                    <h3>Create Your Account</h3>
                    <p>Sign up and complete verification to start trading energy on our platform.</p>
                </div>
                <div class="step animate delay-1">
                    <div class="step-number">2</div>
                    <h3>Connect Energy Source</h3>
                    <p>Link your energy production or consumption system to our secure platform.</p>
                </div>
                <div class="step animate delay-2">
                    <div class="step-number">3</div>
                    <h3>Deposit Funds</h3>
                    <p>Add funds to your account using cryptocurrency or traditional payment methods.</p>
                </div>
                <div class="step animate delay-3">
                    <div class="step-number">4</div>
                    <h3>Start Trading</h3>
                    <p>Buy, sell, and trade energy assets with other users through our advanced trading interface.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats" id="stats">
        <div class="container">
            <div class="section-header">
                <h2>Platform <span>Statistics</span></h2>
                <p>Join thousands of users already trading on our platform</p>
            </div>
            <div class="stats-grid">
                <div class="stat-card animate">
                    <div class="stat-value">50K+</div>
                    <div class="stat-label">Active Traders</div>
                </div>
                <div class="stat-card animate delay-1">
                    <div class="stat-value">$2.5M</div>
                    <div class="stat-label">24h Trading Volume</div>
                </div>
                <div class="stat-card animate delay-2">
                    <div class="stat-value">120+</div>
                    <div class="stat-label">Energy Pairs</div>
                </div>
                <div class="stat-card animate delay-3">
                    <div class="stat-value">99.9%</div>
                    <div class="stat-label">Uptime</div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <div class="container">
            <h2>Start Trading <span>Today</span></h2>
            <p>Join the world's leading decentralized energy trading platform and take control of your energy assets.</p>
            <a href="#" class="btn">Register Now</a>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <div class="logo">
                        <div class="logo-icon">⚡</div>
                        Energy<span>Trade</span>
                    </div>
                    <p style="color: var(--binance-light-gray); margin-top: 20px;">The world's leading decentralized energy trading platform powered by blockchain technology.</p>
                    <div class="social-links">
                        <a href="#" class="social-link">📱</a>
                        <a href="#" class="social-link">💻</a>
                        <a href="#" class="social-link">📷</a>
                        <a href="#" class="social-link">🐦</a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3>Products</h3>
                    <ul class="footer-links">
                        <li><a href="#">Spot Trading</a></li>
                        <li><a href="#">Futures</a></li>
                        <li><a href="#">Energy Staking</a></li>
                        <li><a href="#">Energy Savings</a></li>
                        <li><a href="#">API</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>Support</h3>
                    <ul class="footer-links">
                        <li><a href="#">Help Center</a></li>
                        <li><a href="#">Trading Rules</a></li>
                        <li><a href="#">Fees</a></li>
                        <li><a href="#">API Documentation</a></li>
                        <li><a href="#">Support Tickets</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>Company</h3>
                    <ul class="footer-links">
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Careers</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Legal</a></li>
                        <li><a href="#">Privacy</a></li>
                    </ul>
                </div>
            </div>
            <div class="copyright">
                &copy; 2025 EnergyTrade. All rights reserved.
            </div>
        </div>
    </footer>

    <script>
        // Create candlestick chart
        document.addEventListener('DOMContentLoaded', function() {
            const chartContainer = document.querySelector('.candlestick-chart');
            const candleCount = 40;
            
            for (let i = 0; i < candleCount; i++) {
                // Random candle data
                const open = Math.random() * 100 + 50;
                const close = Math.random() * 100 + 50;
                const high = Math.max(open, close) + Math.random() * 20;
                const low = Math.min(open, close) - Math.random() * 20;
                
                const isUp = close >= open;
                
                // Create candle
                const candle = document.createElement('div');
                candle.classList.add('candle');
                if (!isUp) candle.classList.add('down');
                
                // Create wick
                const wick = document.createElement('div');
                wick.classList.add('candle-wick');
                
                // Position and size
                const left = (i + 1) * (100 / (candleCount + 1));
                const height = Math.abs(close - open) / 2;
                const bottom = Math.min(open, close) / 2;
                const wickHeight = (high - low) / 2;
                const wickBottom = low / 2;
                
                candle.style.left = `${left}%`;
                candle.style.height = `${height}px`;
                candle.style.bottom = `${bottom}px`;
                
                wick.style.left = `${left}%`;
                wick.style.height = `${wickHeight}px`;
                wick.style.bottom = `${wickBottom}px`;
                
                chartContainer.appendChild(wick);
                chartContainer.appendChild(candle);
            }
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                
                const targetId = this.getAttribute('href');
                if (targetId === '#') return;
                
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 80,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Mobile menu toggle
        const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
        const navLinks = document.querySelector('.nav-links');
        
        if (mobileMenuBtn) {
            mobileMenuBtn.addEventListener('click', function() {
                navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
            });
        }

        // Animate elements when they come into view
        const observerOptions = {
            threshold: 0.1
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate');
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        document.querySelectorAll('.feature-card, .step, .stat-card, .trading-interface').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>