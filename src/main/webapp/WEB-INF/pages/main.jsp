<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX - Decentralized Energy Trading</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/style.css">
</head>
<style>
/* Reset and base styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}

body {
    background-color: #0a0e17;
    color: white;
    position: relative;
    overflow-x: hidden;
}

/* Grid background */
.grid-background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: linear-gradient(rgba(10, 14, 23, 0.97) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(10, 14, 23, 0.97) 1px, transparent 1px);
    background-size: 50px 50px;
    background-position: 0 0;
    z-index: -1;
}

/* Navigation */
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 10%;
    position: relative;
    z-index: 10;
}

.logo {
    display: flex;
    align-items: center;
    font-size: 24px;
    font-weight: bold;
    color: white;
    text-decoration: none;
}

.logo-icon {
    background-color: #0066ff;
    width: 36px;
    height: 36px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 10px;
}

.wave {
    width: 24px;
    height: 14px;
    position: relative;
}

.wave::before, .wave::after {
    content: "";
    position: absolute;
    height: 7px;
    width: 20px;
    background-color: white;
    border-radius: 10px;
}

.wave::before {
    top: 0;
}

.wave::after {
    bottom: 0;
}

.nav-links {
    display: flex;
    list-style: none;
}

.nav-links li {
    margin: 0 15px;
}

.nav-links a {
    color: white;
    text-decoration: none;
    font-size: 16px;
    transition: color 0.3s;
}

.nav-links a:hover {
    color: #0066ff;
}

.connect-btn {
    background-color: #0066ff;
    color: white;
    border: none;
    border-radius: 50px;
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
}

.connect-btn:hover {
    background-color: #0055cc;
}

/* Hero Section */
.hero {
    text-align: center;
    padding: 80px 20px;
    max-width: 900px;
    margin: 0 auto;
}

.launching-badge {
    display: inline-flex;
    align-items: center;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 50px;
    padding: 8px 16px;
    margin-bottom: 40px;
    color: white;
}

.launching-badge .star {
    color: #ffcc00;
    margin-right: 8px;
}

.launching-badge .arrow {
    margin-left: 8px;
}

.hero h1 {
    font-size: 56px;
    font-weight: bold;
    margin-bottom: 30px;
    line-height: 1.2;
}

.hero p {
    font-size: 18px;
    line-height: 1.6;
    color: rgba(255, 255, 255, 0.8);
    margin-bottom: 40px;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
}

.cta-container {
    display: inline-flex;
    align-items: center;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 50px;
    padding: 8px 8px 8px 20px;
    margin-top: 20px;
}

.cta-text {
    display: flex;
    align-items: center;
    margin-right: 15px;
}

.cta-text .star {
    color: #ffcc00;
    margin-right: 8px;
}

.get-started-btn {
    background-color: #0066ff;
    color: white;
    border: none;
    border-radius: 50px;
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    display: flex;
    align-items: center;
    transition: background-color 0.3s;
}

.get-started-btn:hover {
    background-color: #0055cc;
}

.get-started-btn .arrow {
    margin-left: 8px;
}

/* Features Section */
.features-section {
    text-align: center;
    padding: 80px 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.features-section h2 {
    font-size: 42px;
    font-weight: bold;
    margin-bottom: 50px;
    line-height: 1.2;
}

.features-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
}

.feature-card {
    background-color: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 30px;
    text-align: left;
    transition: transform 0.3s, background-color 0.3s;
}

.feature-card:hover {
    transform: translateY(-5px);
    background-color: rgba(255, 255, 255, 0.08);
}

.feature-icon {
    width: 50px;
    height: 50px;
    margin-bottom: 20px;
    color: #0066ff;
}

.feature-card h3 {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 15px;
    color: white;
}

.feature-card p {
    font-size: 16px;
    line-height: 1.6;
    color: rgba(255, 255, 255, 0.7);
}

/* Process Section */
.process-section {
    text-align: center;
    padding: 80px 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.process-badge {
    display: inline-flex;
    align-items: center;
    background-color: rgba(255, 255, 255, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 50px;
    padding: 8px 20px;
    margin-bottom: 30px;
    color: white;
    font-weight: 500;
}

.process-section h2 {
    font-size: 42px;
    font-weight: bold;
    margin-bottom: 20px;
    line-height: 1.2;
}

.process-section .subtitle {
    font-size: 18px;
    line-height: 1.6;
    color: rgba(255, 255, 255, 0.7);
    margin-bottom: 60px;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
}

.steps-container {
    display: flex;
    justify-content: space-between;
    gap: 30px;
    margin-top: 50px;
}

.step {
    flex: 1;
    padding: 30px;
    text-align: left;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.step-icon {
    width: 50px;
    height: 50px;
    margin-bottom: 20px;
    opacity: 0.9;
}

.step h3 {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
}

.step p {
    font-size: 16px;
    line-height: 1.6;
    color: rgba(255, 255, 255, 0.7);
}

/* Responsive styles */
@media (max-width: 768px) {
    .navbar {
        flex-direction: column;
        padding: 20px 5%;
    }

    .nav-links {
        margin: 20px 0;
        flex-wrap: wrap;
        justify-content: center;
    }

    .nav-links li {
        margin: 5px 10px;
    }

    .hero h1 {
        font-size: 36px;
    }

    .hero p {
        font-size: 16px;
    }

    .features-grid {
        grid-template-columns: 1fr;
    }

    .steps-container {
        flex-direction: column;
    }

    .step {
        margin-bottom: 20px;
    }
}
</style>
<body>
    <div class="grid-background"></div>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="<%= contextPath %>/home" class="logo">
            <div class="logo-icon">
                <div class="wave"></div>
            </div>
            WattX
        </a>
        <ul class="nav-links">
            <li><a href="<%= contextPath %>/trade">Trade Energy</a></li>
            <li><a href="<%= contextPath %>/how-it-works">How It Works</a></li>
            <li><a href="<%= contextPath %>/pricing">Pricing</a></li>
            <li><a href="<%= contextPath %>/blog">Blog</a></li>
        </ul>
        <button class="connect-btn">Create Wallet</button>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="launching-badge">
            <span class="star">✨</span>
            Launching Soon
            <span class="arrow">›</span>
        </div>
        <h1>Decentralized Energy<br>Trading For Everyone</h1>
        <p>Buy, sell, and store energy effortlessly through our decentralized platform, while contributing to sustainability with footfall-powered energy.</p>
        
        <div class="cta-container">
            <div class="cta-text">
                <span class="star">✨</span>
                Join the Future of Energy Trading Now!
            </div>
            <button class="get-started-btn">
                Get Started
                <span class="arrow">›</span>
            </button>
        </div>
    </section>

    <!-- Process Section -->
    <section class="process-section">
	    <div class="process-badge">The Process</div>
	    <h2>Three Simple Steps to<br>Start Trading Energy</h2>
	    <p class="subtitle">Begin your energy trading journey in just 3 easy steps</p>
	    
	    <div class="steps-container">
	        <div class="step">
	            <img src="${pageContext.request.contextPath}/resources/images/signup.png" alt="Sign Up Icon" class="step-icon">
	            <h3>I. Sign Up</h3>
	            <p>Create your free account to start buying, selling, or storing energy.</p>
	        </div>
	        
	        <div class="step">
	            <img src="<%= contextPath %>/resources/images/trade.png" alt="Trade Icon" class="step-icon">
	            <h3>II. Trade</h3>
	            <p>Select whether you're selling surplus solar power or purchasing energy at low prices.</p>
	        </div>
	        
	        <div class="step">
	            <img src="<%= contextPath %>/resources/images/store.png" alt="Store Icon" class="step-icon">
	            <h3>III. Store & Use</h3>
	            <p>Securely store energy for future projects or manage your energy portfolio with ease.</p>
	        </div>
	    </div>
	</section>

    <!-- Features Section -->
    <section class="features-section">
        <h2>Features</h2>
        <div class="features-grid">
            <div class="feature-card">
                <svg class="feature-icon" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path d="M19 14V6c0-1.1-.9-2-2-2H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zm-9-1c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm13-6v11c0 1.1-.9 2-2 2H4v-2h17V7h2z"/>
                </svg>
                <h3>Seamless Energy Trading</h3>
                <p>Buy, sell, and store energy with ease using our smart contract-powered platform.</p>
            </div>
            
            <div class="feature-card">
                <svg class="feature-icon" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11v8.8z"/>
                </svg>
                <h3>Transparent Transactions</h3>
                <p>All trades are secure and transparent, thanks to blockchain technology and decentralized smart contracts.</p>
            </div>
            
            <div class="feature-card">
                <svg class="feature-icon" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path d="M11.8 10.9c-2.27-.59-3-1.2-3-2.15 0-1.09 1.01-1.85 2.7-1.85 1.78 0 2.44.85 2.5 2.1h2.21c-.07-1.72-1.12-3.3-3.21-3.81V3h-3v2.16c-1.94.42-3.5 1.68-3.5 3.61 0 2.31 1.91 3.46 4.7 4.13 2.5.6 3 1.48 3 2.41 0 .69-.49 1.79-2.7 1.79-2.06 0-2.87-.92-2.98-2.1h-2.2c.12 2.19 1.76 3.42 3.68 3.83V21h3v-2.15c1.95-.37 3.5-1.5 3.5-3.55 0-2.84-2.43-3.81-4.7-4.4z"/>
                </svg>
                <h3>Energy Price Optimization</h3>
                <p>Purchase energy at low prices and store it for future high-demand periods, ensuring cost savings.</p>
            </div>
            
            <div class="feature-card">
                <svg class="feature-icon" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path d="M13 3h-2v10h2V3zm4.83 2.17l-1.42 1.42C17.99 7.86 19 9.81 19 12c0 3.87-3.13 7-7 7s-7-3.13-7-7c0-2.19 1.01-4.14 2.58-5.42L6.17 5.17C4.23 6.82 3 9.26 3 12c0 4.97 4.03 9 9 9s9-4.03 9-9c0-2.74-1.23-5.18-3.17-6.83z"/>
                </svg>
                <h3>Sustainable Footfall Energy</h3>
                <p>Generate energy from foot traffic in public spaces with our innovative piezoelectric technology.</p>
            </div>
            
            <div class="feature-card">
                <svg class="feature-icon" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
                </svg>
                <h3>Real-Time Data & Analytics</h3>
                <p>Track energy prices, usage, and trades in real-time with built-in analytics for informed decisions.</p>
            </div>
            
            <div class="feature-card">
                <svg class="feature-icon" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z"/>
                </svg>
                <h3>Decentralized & Secure</h3>
                <p>Experience the security of decentralized transactions with no intermediaries, ensuring fair and direct trading.</p>
            </div>
        </div>
    </section>
</body>
</html>