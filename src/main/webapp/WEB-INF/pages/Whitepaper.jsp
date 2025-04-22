```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WattX | Whitepaper</title>
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

        /* Whitepaper Section */
        .whitepaper {
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

        .whitepaper-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-top: 50px;
        }

        .whitepaper-text p {
            color: var(--binance-light-gray);
            margin-bottom: 20px;
        }

        .whitepaper-image {
            background: url('/placeholder.svg?height=400&width=500') center/cover;
            border-radius: 8px;
            height: 400px;
        }

        .whitepaper-download {
            margin-top: 30px;
        }

        /* CTA Section */
        .cta {
            padding: 100px 0;
            background: linear-gradient(to right, var(--binance-dark), var(--binance-black));
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
        @keyframes fadeInUp {
            from {
                opacity: 0;
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
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .nav-links {
                display: none;
            }

            .whitepaper-content {
                grid-template-columns: 1fr;
            }

            .whitepaper-image {
                height: 300px;
            }
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

        @media (max-width: 768px) {
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
                    <li><a href="<%= contextPath %>/home">Home</a></li>
                    <li><a href="<%= contextPath %>/about">About Us</a></li>
                    <li><a href="<%= contextPath %>/contact">Contact Us</a></li>
                    <li><a href="<%= contextPath %>/whitepaper">Whitepaper</a></li>
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
                <h1>Our <span>Whitepaper</span></h1>
                <p>Discover the technical and strategic vision behind WattX’s decentralized energy trading platform.</p>
            </div>
        </div>
    </section>

    <!-- Whitepaper Section -->
    <section class="whitepaper">
        <div class="container">
            <div class="section-header">
                <h2>Explore the <span>Vision</span></h2>
                <p>Learn how WattX is transforming energy markets with blockchain technology</p>
            </div>
            <div class="whitepaper-content animate">
                <div class="whitepaper-text">
                    <p>Our whitepaper outlines the technical architecture, economic model, and strategic roadmap for WattX. It details how we leverage blockchain to create a secure, transparent, and efficient platform for peer-to-peer energy trading.</p>
                    <p>Key topics include our decentralized trading protocol, smart contract implementation, tokenomics, and plans for global scalability. Download the whitepaper to dive into the future of energy markets.</p>
                    <div class="whitepaper-download">
                        <a href="/assets/WattX_Whitepaper.pdf" class="btn" download>Download Whitepaper</a>
                    </div>
                </div>
                <div class="whitepaper-image"></div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <div class="container">
            <h2>Join the <span>Future</span></h2>
            <p>Start trading on WattX and be part of the decentralized energy revolution.</p>
            <a href="<%= contextPath %>/create-wallet" class="btn">Register Now</a>
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
                        <li><a href="<%= contextPath %>/about">About Us</a></li>
                        <li><a href="#">Careers</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Legal</a></li>
                        <li><a href="#">Privacy</a></li>
                    </ul>
                </div>
            </div>
            <div class="copyright">
                © 2025 EnergyTrade. All rights reserved.
            </div>
        </div>
    </footer>

    <script>
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
                    observer.unobserv(entry.target);
                }
            });
        }, observerOptions);

        document.querySelectorAll('.whitepaper-content').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>
