<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>GHIBLI DRINK SHOP | Trạm Dừng Chân Phép Màu</title>
    <link href="https://fonts.googleapis.com/css2?family=Pangolin&family=Patrick+Hand&family=Nunito:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --ghibli-green: #386641;
            --ghibli-yellow: #F2E8CF;
            --ghibli-red: #BC4749;
            --ghibli-brown: #3E2723;
            --sky-blue: #A3D2CA;
            --paper: #FDF9F1;
        }

        body {
            margin: 0;
            font-family: 'Nunito', sans-serif;
            background-color: var(--paper);
            color: var(--ghibli-brown);
            overflow-x: hidden;
            scroll-behavior: smooth; /* Thêm để cuộn trang mượt hơn */
        }

        h1, h2, h3 { font-family: 'Pangolin', cursive; }
        p, li { font-family: 'Patrick Hand', cursive; font-size: 1.6rem; line-height: 1.6; }

        /* --- VOUCHER SINH NHẬT --- */
        .birthday-banner {
            background: linear-gradient(45deg, #F2E8CF, #A3D2CA);
            margin: 100px auto 20px;
            max-width: 900px;
            border-radius: 20px;
            padding: 15px 25px;
            border: 3px dashed var(--ghibli-green);
            box-shadow: 10px 10px 0px rgba(56, 102, 65, 0.1);
            animation: bounce 2s infinite;
            position: relative;
            z-index: 1000;
        }
        .banner-content { display: flex; align-items: center; justify-content: space-between; }
        .gift-icon { font-size: 3rem; }
        .text-group h4 { color: var(--ghibli-red); margin: 0; font-family: 'Pangolin', cursive; font-size: 1.5rem; }
        .text-group p { margin: 5px 0 0; color: var(--ghibli-brown); font-size: 1.2rem; }
        .voucher-code {
            background: white; padding: 8px 20px; border-radius: 50px;
            font-weight: 900; color: var(--ghibli-green); border: 2px solid var(--ghibli-green);
            font-size: 1.3rem; font-family: 'Nunito', sans-serif;
        }

        /* --- NAVBAR --- */
        nav {
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0; width: 100%;
            box-sizing: border-box;
            z-index: 2000;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border-bottom: 3px solid var(--ghibli-green);
        }

        .nav-logo { font-size: 2.5rem; color: var(--ghibli-green); text-decoration: none; font-family: 'Pangolin', cursive; }
        .nav-menu a { text-decoration: none; color: var(--ghibli-brown); margin: 0 15px; font-weight: 900; font-size: 1.1rem; transition: 0.3s; }
        .nav-menu a:hover { color: var(--ghibli-red); }
        .nav-auth { display: flex; gap: 10px; align-items: center; }
        .btn-sm { padding: 10px 20px; border-radius: 50px; text-decoration: none; font-weight: bold; border: 2px solid var(--ghibli-green); font-size: 0.9rem; }
        .btn-login { color: var(--ghibli-green); }
        .btn-register { background: var(--ghibli-red); color: white; border-color: var(--ghibli-red); }
        .nav-user-info { background: var(--ghibli-yellow); border: 2px dashed var(--ghibli-green); border-radius: 20px; padding: 5px 15px; font-family: 'Pangolin'; display: flex; align-items: center; gap: 10px; }

        /* --- ABOUT SECTION STYLES --- */
        .about-section { padding: 60px 0; background-color: #FDF9F1; }
        .about-card { background: #ffffff; border: 2px solid var(--ghibli-green); border-radius: 20px; padding: 40px; box-shadow: 10px 10px 0px var(--ghibli-yellow); margin-bottom: 30px; }
        .ghibli-title { color: var(--ghibli-red); border-bottom: 2px dashed var(--ghibli-green); display: inline-block; margin-bottom: 20px; }
        .team-member { text-align: center; padding: 15px; }
        .team-member img { width: 120px; height: 120px; border-radius: 50%; border: 3px solid var(--ghibli-green); object-fit: cover; }
        .cert-icon { color: #d66853; font-size: 2.5rem; margin-bottom: 10px; }

        /* --- HERO & SECTIONS --- */
        .hero { height: 100vh; background: linear-gradient(to bottom, var(--sky-blue), var(--paper)); display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; padding: 0 20px; }
        .hero h1 { font-size: 6rem; color: white; text-shadow: 5px 5px 0px var(--ghibli-green); margin: 0; }
        .section { padding: 100px 12%; }
        .highlight-card { background: white; border: 3px solid var(--ghibli-green); padding: 50px; border-radius: 40px; margin-top: 50px; box-shadow: 15px 15px 0px var(--ghibli-yellow); }
        .artisan-box { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 40px; margin-top: 50px; }
        .artisan-item { background: #fdfdfd; padding: 40px; border-radius: 30px; border-bottom: 6px solid var(--ghibli-green); text-align: center; }
        footer { background: var(--ghibli-brown); color: var(--ghibli-yellow); padding: 80px 10% 40px; }
        .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 50px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 50px; }

        @keyframes bounce { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-5px); } }
        @keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-20px); } }
        .floating { animation: float 4s ease-in-out infinite; }
    </style>
</head>
<body>

<nav>
    <a href="index.jsp" class="nav-logo">GHIBLI</a>
    <div class="nav-menu">
        <a href="#story">Ký Ức</a>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="menu" style="color: var(--ghibli-red);">✨ Thực Đơn Cư Dân ✨</a>
            </c:when>
            <c:otherwise>
                <a href="menu">Thực Đơn</a>
            </c:otherwise>
        </c:choose>
        <a href="#artisans">Nghệ Nhân</a>
        <a href="#about">Về chúng mình</a> <!-- Thêm link cuộn trang -->
    </div>

    <div class="nav-auth">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="nav-user-info shadow-sm">
                    <span>Chào cư dân <b>${sessionScope.user.hoTen}</b></span>
                    <a href="logout" class="text-danger" title="Tạm biệt"><i class="fas fa-sign-out-alt ml-2"></i></a>
                </div>
            </c:when>
            <c:otherwise>
                <a href="login" class="btn-sm btn-login">Đăng Nhập</a>
                <a href="register" class="btn-sm btn-register">Đăng ký ngay 🌱</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<c:if test="${not empty sessionScope.user and not empty sessionScope.user.voucherHienCo}">
    <div class="birthday-banner">
        <div class="banner-content">
            <span class="gift-icon">🎁</span>
            <div class="text-group">
                <h4>CHÚC MỪNG SINH NHẬT CƯ DÂN ${sessionScope.user.hoTen.toUpperCase()}!</h4>
                <p>Tri-Wisdom gửi tặng bạn mã giảm giá 20% toàn menu (Hạn dùng 10 ngày)</p>
            </div>
            <div class="voucher-code">${sessionScope.user.voucherHienCo}</div>
        </div>
    </div>
</c:if>

<section class="hero">
    <h1 class="floating">GHIBLI Drink Shop</h1>
    <p style="font-size: 2.2rem; color: var(--ghibli-green); font-weight: bold;">"Nơi thời gian ngừng trôi bên hiên nhà gỗ"</p>
</section>

<section class="section" id="story">
    <div class="intro-text">
        <h2 style="text-align: center;">Chào bạn, người khách phương xa...</h2>
        <div class="highlight-card">
            <p>Tại <b>GHIBLI Drink Shop</b>, chúng tôi không chỉ pha chế đồ uống, chúng tôi "đóng gói" những mảnh ký ức đó vào từng chiếc ly thủy tinh.</p>
            <p>Lấy cảm hứng từ sự tỉ mỉ của những thước phim vẽ tay, quán là nơi bạn có thể tìm thấy hương vị của sự chân thành.</p>
        </div>
    </div>
</section>

<section class="section" id="artisans" style="background: #E8F3F1;">
    <h2 style="text-align: center;">Những Người Dệt Nên Phép Màu</h2>
    <div class="artisan-box">
        <div class="artisan-item">
            <span style="font-size: 4rem;">✨</span>
            <h3>Bậc Thầy Ánh Sáng</h3>
            <p>Nghệ nhân chuyên trách các dòng trà hoa.</p>
        </div>
        <div class="artisan-item">
            <span style="font-size: 4rem;">🔥</span>
            <h3>Người Giữ Lửa Thiêng</h3>
            <p>Người bảo hộ cho hương vị cà phê nồng nàn.</p>
        </div>
        <div class="artisan-item">
            <span style="font-size: 4rem;">☁️</span>
            <h3>Người Gom Mây Trời</h3>
            <p>Phù thủy của những lớp kem béo ngậy.</p>
        </div>
    </div>
</section>

<!-- CHỈ DÙNG INCLUDE Ở ĐÂY LÀ ĐỦ ĐỂ HIỆN PHẦN VỀ CHÚNG MÌNH -->
<%@ include file="about_section.jsp" %>

<footer>
    <div class="footer-grid">
        <div class="footer-col">
            <span class="footer-logo">GHIBLI Drink Shop</span>
            <p>Tỉ mỉ đến từng giọt hạnh phúc.</p>
        </div>
        <div class="footer-col">
            <h4>Ghé Thăm Tiệm</h4>
            <ul>
                <li>📍 123 Đường Mây Trắng, Đà Nẵng</li>
                <li>⏰ 07:00 - 22:00</li>
            </ul>
        </div>
    </div>
    <p style="text-align: center; margin-top: 40px; opacity: 0.5;">&copy; 2026 GHIBLI Drink Shop.</p>
</footer>

</body>
</html>