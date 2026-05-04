<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 1. NHÚNG PHÔNG CHỮ TỪ GOOGLE FONTS (QUAN TRỌNG NHẤT) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Pangolin&family=Patrick+Hand&family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

<style>

/* ÉP PHÔNG CHỮ MỀM MẠI CHO TOÀN BỘ TRANG */
    body {
        font-family: 'Nunito', sans-serif !important;
    }

    /* --- CSS CHO NAVBAR --- */
    .navbar-ghibli {
        background-color: rgba(253, 249, 241, 0.98);
        backdrop-filter: blur(5px);
        border-bottom: 3px solid #4e6e5d;
        padding: 12px 0;
        z-index: 1050;
        box-shadow: 0 2px 15px rgba(0,0,0,0.05);
    }
    .nav-link-ghibli {
        color: #4e6e5d !important;
        font-weight: bold;
        margin: 0 15px;
        font-family: 'Pangolin', cursive !important;
        font-size: 1.1rem;
        transition: 0.3s;
    }
    .nav-link-ghibli:hover {
        color: #BC4749 !important;
        transform: translateY(-2px);
    }
    .navbar-brand:hover {
        transform: scale(1.05);
        transition: 0.3s;
        filter: drop-shadow(0 0 5px rgba(78, 110, 93, 0.5));
    }
    .nav-user-info {
        background: #F2E8CF;
        border: 2px dashed #4e6e5d;
        border-radius: 20px;
        padding: 5px 15px;
        font-family: 'Pangolin' cursive !important;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .badge-level {
        background: #4e6e5d;
        color: white;
        padding: 2px 8px;
        border-radius: 10px;
        font-size: 0.8rem;
    }

    /* --- CSS CHO BANNER VOUCHER --- */
    .birthday-banner {
        background: linear-gradient(135deg, #ffffff 0%, #f2e8cf 100%);
        border: 2px dashed #4e6e5d;
        border-radius: 15px;
        padding: 15px;
        margin: 20px auto;
        max-width: 850px;
        box-shadow: 8px 8px 0px rgba(78, 110, 93, 0.1);
        animation: slideDown 0.6s ease-out;
    }
    .banner-content {
        display: flex;
        align-items: center;
        justify-content: space-around;
        text-align: center;
    }
    .text-group h4 { font-family: 'Pangolin'cursive !important;color: #BC4749; color: #BC4749; margin: 0; }
    .text-group p { font-family: 'Patrick Hand' , cursive !important; margin: 5px 0 0; font-size: 1.2rem; color: #3E2723; }
    .voucher-code {
        background: #BC4749;
        color: white;
        padding: 8px 20px;
        border-radius: 50px;
        font-weight: 900;
        box-shadow: 3px 3px 0px #3E2723;
    }
    @keyframes slideDown {
        from { opacity: 0; transform: translateY(-30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* Thêm CSS cho Dropdown để đồng bộ phông chữ */
        .dropdown-item {
            font-family: 'Pangolin', cursive !important;
            color: #4e6e5d;
        }
</style>

<!-- 1. THANH NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-ghibli sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp" style="display: flex; align-items: center; gap: 10px; text-decoration: none;">
            <i class="fas fa-leaf" style="color: #4e6e5d; font-size: 24px;"></i>
            <span style="font-weight: bold; color: #4e6e5d; font-family: 'Pangolin';">Tri-Wisdom</span>
        </a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <i class="fas fa-bars" style="color: #4e6e5d"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link-ghibli" href="index.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link-ghibli" href="menu">Thực đơn</a></li>
                <li class="nav-item"><a class="nav-link-ghibli" href="index.jsp#about">Về chúng mình</a></li>

                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link-ghibli" href="special-offers">
                            <i class="fas fa-gift mr-1" style="color: #d66853;"></i> Khuyến mãi
                        </a>
                    </li>
                    <li class="nav-item"><a class="nav-link-ghibli" href="order-tracking">Đơn hàng</a></li>
                </c:if>
            </ul>

            <div class="navbar-nav ml-auto">
                <c:choose>
                   <c:when test="${not empty sessionScope.user}">
                       <div class="nav-item dropdown">
                           <a class="nav-link dropdown-toggle nav-user-info shadow-sm" href="#" id="userDropdown" role="button" data-toggle="dropdown">
                               <span>Chào, <strong>${sessionScope.user.hoTen}</strong></span>
                               <span class="badge-level">${not empty sessionScope.user.capDo ? sessionScope.user.capDo : 'Thành viên'}</span>
                           </a>
                           <div class="dropdown-menu dropdown-menu-right shadow border-0" style="border-radius: 15px; font-family: 'Pangolin';">
                               <a class="dropdown-item" href="order-tracking"><i class="fas fa-history mr-2"></i> Lịch sử mua hàng</a>

                               <!-- KHÔI PHỤC PHẦN ĐỔI QUÀ VÀ CÀI ĐẶT -->
                               <a class="dropdown-item" href="redeem-rewards">
                                   <i class="fas fa-gift mr-2"></i> Đổi quà tích điểm
                               </a>
                               <a class="dropdown-item" href="account-settings">
                                   <i class="fas fa-user-cog mr-2"></i> Cài đặt tài khoản
                               </a>

                               <div class="dropdown-divider"></div>
                               <a class="dropdown-item" href="logout" style="color: #BC4749;"><i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất</a>
                           </div>
                       </div>
                   </c:when>
                    <c:otherwise>
                        <a href="login" class="nav-link-ghibli" style="border: 2px solid #4e6e5d; border-radius: 20px; padding: 5px 20px;">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- 2. BANNER VOUCHER SINH NHẬT -->
<c:if test="${not empty sessionScope.user and not empty sessionScope.user.voucherHienCo}">
    <div class="container">
        <div class="birthday-banner">
            <div class="banner-content">
                <span style="font-size: 2.5rem;">🎁</span>
                <div class="text-group">
                    <h4>QUÀ TẶNG TỪ TRI-WISDOM!</h4>
                    <p>Chúc mừng sinh nhật cư dân <b>${sessionScope.user.hoTen}</b>!</p>
                </div>
                <div class="voucher-code">${sessionScope.user.voucherHienCo}</div>
            </div>
        </div>
    </div>
</c:if>