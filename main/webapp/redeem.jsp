<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tiệm Quà Phép Màu - Tri-Wisdom</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #fdf9f1; font-family: 'Pangolin', cursive; }
        .reward-card {
            border: 2px dashed #4e6e5d;
            border-radius: 20px;
            transition: 0.3s;
            background: white;
        }
        .reward-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .points-banner {
            background: #f8e9a1;
            border-radius: 50px;
            padding: 10px 25px;
            display: inline-block;
            border: 2px solid #4e6e5d;
        }
        .btn-redeem {
            background-color: #4e6e5d;
            color: white;
            border-radius: 15px;
            font-weight: bold;
        }
        .btn-redeem:hover { background-color: #d66853; color: white; }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp"></jsp:include>

    <div class="container mt-5 text-center">
        <h1 class="mb-4" style="color: #4e6e5d;">✨ Tiệm Quà Phép Màu ✨</h1>

        <!-- Hiển thị điểm của cư dân -->
        <div class="points-banner mb-5">
            <i class="fas fa-star text-warning"></i>
            Số điểm hiện có: <strong>${sessionScope.user.diemTichLuy}</strong> điểm
        </div>

        <!-- Chèn vào dưới cái div .points-banner -->
        <c:if test="${not empty mess}">
            <div class="alert alert-success mt-3 shadow-sm" style="border-radius: 15px;">
                <i class="fas fa-magic"></i> ${mess}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3 shadow-sm" style="border-radius: 15px;">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <div class="row">
            <c:forEach items="${listRewards}" var="q">
                <div class="col-md-4 mb-4">
                    <div class="card h-100 reward-card p-3">
                        <img src="img/${q.hinhAnh}" class="card-img-top mx-auto" style="width: 150px; height: 150px; object-fit: contain;" alt="${q.tenQua}">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">${q.tenQua}</h5>
                            <p class="text-muted">Còn lại: ${q.soLuongCon}</p>
                            <h4 class="text-success mb-3">${q.diemDoi} <small>điểm</small></h4>

                            <c:choose>
                                <c:when test="${sessionScope.user.diemTichLuy >= q.diemDoi}">
                                    <a href="redeem-action?maQua=${q.maQua}&diem=${q.diemDoi}"
                                       class="btn btn-redeem w-100"
                                       onclick="return confirm('Bạn có muốn đổi món quà này không?')">
                                        Đổi quà ngay
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary w-100" disabled>Chưa đủ điểm</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>