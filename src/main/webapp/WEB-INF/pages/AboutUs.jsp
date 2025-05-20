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
    <title>WattX | About Us</title>
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

        /* About Section */
        .about {
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

        .about-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-top: 50px;
        }

        .about-text p {
            color: var(--binance-light-gray);
            margin-bottom: 20px;
        }

        .about-image {
            background: url('/placeholder.svg?height=400&width=500') center/cover;
            border-radius: 8px;
            height: 400px;
        }

        /* Team Section */
        .team {
            padding: 100px 0;
            background-color: var(--binance-dark);
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 50px;
        }

        .team-card {
            background-color: var(--binance-black);
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            border: 1px solid #2c2f36;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .team-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            border-color: var(--binance-yellow);
        }

        .team-image {
            width: 120px;
            height: 120px;
            background: url('/placeholder.svg?height=120&width=120') center/cover;
            border-radius: 50%;
            margin: 0 auto 20px;
        }

        .team-card h3 {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .team-card p {
            color: var(--binance-light-gray);
            font-size: 0.9rem;
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

            .about-content {
                grid-template-columns: 1fr;
            }

            .about-image {
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
                <h1>About <span>WattX</span></h1>
                <p>Learn about our mission to revolutionize energy trading with blockchain technology and meet the team driving this innovation.</p>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section class="about">
        <div class="container">
            <div class="section-header">
                <h2>Our <span>Mission</span></h2>
                <p>Empowering a sustainable future through decentralized energy markets</p>
            </div>
            <div class="about-content animate">
                <div class="about-text">
                    <p>WattX is a pioneering decentralized energy trading platform built on blockchain technology. Our mission is to democratize energy markets by enabling peer-to-peer trading without intermediaries, ensuring transparency, security, and efficiency.</p>
                    <p>Founded in 2023, we aim to create a global marketplace where producers and consumers can trade renewable energy seamlessly. Our vision is a world where clean energy is accessible to all, powered by cutting-edge technology and driven by community trust.</p>
                </div>
                <div class="about-image"></div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="team">
        <div class="container">
            <div class="section-header">
                <h2>Meet Our <span>Team</span></h2>
                <p>Our dedicated team of innovators and experts</p>
            </div>
            <div class="team-grid">
                <div class="team-card animate">
                    <div class="team-image"></div>
                    <h3>Jane Doe</h3>
                    <p>CEO & Founder</p>
                </div>
                <div class="team-card animate delay-1">
                    <div class="team-image"></div>
                    <h3>John Smith</h3>
                    <p>CTO</p>
                </div>
                <div class="team-card animate delay-2">
                    <div class="team-image"></div>
                    <h3>Emily Chen</h3>
                    <p>Blockchain Lead</p>
                </div>
                <div class="team-card animate delay-3">
                    <div class="team-image"></div>
                    <h3>Michael Brown</h3>
                    <p>Head of Operations</p>
                </div>
            </div>
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
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        document.querySelectorAll('.about-content, .team-card').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>