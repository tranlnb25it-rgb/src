<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .voucher-card {
        background: #fff;
        border-radius: 15px;
        display: flex;
        filter: drop-shadow(0 5px 10px rgba(0,0,0,0.1));
        margin-bottom: 25px;
        overflow: hidden;
        border-left: 8px solid #4e6e5d;
        position: relative;
    }
    /* Tạo lỗ hổng trang trí cho giống vé xé */
    .voucher-card::before, .voucher-card::after {
        content: '';
        position: absolute;
        left: 28%;
        width: 20px;
        height: 20px;
        background: #fdf9f1; /* Khớp với màu nền trang */
        border-radius: 50%;
    }
    .voucher-card::before { top: -10px; }
    .voucher-card::after { bottom: -10px; }

    .voucher-left {
        width: 30%;
        padding: 20px;
        background: #f8fbf9;
        display: flex;
        align-items: center;
        justify-content: center;
        border-right: 2px dashed #eee;
    }
    .voucher-right {
        width: 70%;
        padding: 20px;
        background: #fff;
    }
    .btn-ghibli {
        background: #4e6e5d;
        color: white !important;
        border-radius: 30px;
        padding: 5px 20px;
        font-family: 'Pangolin';
        text-decoration: none;
        transition: 0.3s;
    }
    .btn-ghibli:hover { background: #d66853; }
</style>

<div class="container mt-3">
    <!-- Nút quay về trang chủ với icon Ghibli -->
    <a href="${pageContext.request.contextPath}/" class="back-home-link">
        <i class="fas fa-long-arrow-alt-left"></i> Quay về trang chủ
    </a>
</div>

<style>
    .back-home-link {
        color: #4e6e5d;
        font-family: 'Pangolin';
        text-decoration: none;
        font-size: 1.1rem;
        transition: 0.3s;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    .back-home-link:hover {
        color: #d66853;
        transform: translateX(-5px);
        text-decoration: none;
    }
</style>

<div class="container py-5" style="background: #fdf9f1; min-height: 100vh;">
    <h2 class="text-center mb-5" style="font-family: 'Pangolin'; color: #4e6e5d;">📜 Kho Lưu Trữ Ưu Đãi</h2>

    <div class="row justify-content-center">
        <div class="col-md-8">

            <%-- VOUCHER 1: CHÀO XUÂN --%>
            <c:if test="${!fn:contains(usedOffers, 'CHAOXUAN')}">
                <div class="voucher-card">
                    <div class="voucher-left">
                        <i class="fas fa-seedling fa-3x" style="color: #4e6e5d;"></i>
                    </div>
                    <div class="voucher-right">
                        <h4 style="font-family: 'Pangolin';">Combo Chào Xuân 🌸</h4>
                        <p class="text-muted">Tặng 1 bánh ngọt cho mọi đơn hàng từ 2 ly.</p>
                        <a href="use-offer?code=CHAOXUAN" class="btn-ghibli">Sử dụng ngay</a>
                    </div>
                </div>
            </c:if>

            <%-- VOUCHER 2: CÀNH LÁ --%>
            <c:if test="${(sessionScope.user.capDo == 'Cành Lá' || sessionScope.user.capDo == 'Lâu Đài') && !fn:contains(usedOffers, 'CANHLA10')}">
                <div class="voucher-card" style="border-left-color: #f1c40f;">
                    <div class="voucher-left"><i class="fas fa-star fa-3x" style="color: #f1c40f;"></i></div>
                    <div class="voucher-right">
                        <h4 style="font-family: 'Pangolin'; color: #d4a017;">Ưu Đãi Cành Lá ⭐</h4>
                        <p class="text-muted">Giảm 10% tổng hóa đơn vào thứ Hai hàng tuần.</p>
                        <a href="use-offer?code=CANHLA10" class="btn-ghibli" style="background: #f1c40f;">Dùng ưu đãi</a>
                    </div>
                </div>
            </c:if>

            <%-- Nếu danh sách trống (Đã dùng hết) --%>
            <c:if test="${fn:length(usedOffers) >= 3 || (sessionScope.user.capDo == 'Hạt Mầm' && fn:contains(usedOffers, 'CHAOXUAN'))}">
                <div class="text-center mt-5">
                    <p style="font-family: 'Pangolin'; color: #888;">Cư dân đã sử dụng hết ưu đãi hiện có. Hãy tích điểm để nhận thêm nhé! 🌱</p>
                </div>
            </c:if>

        </div>
    </div>
</div>