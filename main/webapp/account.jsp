<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hồ Sơ Cư Dân - Tri-Wisdom</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #fdf9f1; font-family: 'Pangolin', cursive; }
        .profile-card {
            background: white;
            border: 2px dashed var(--ghibli-green);
            border-radius: 25px;
            padding: 30px;
        }
        .form-control {
            border-radius: 15px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp"></jsp:include>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6 profile-card shadow-sm">
                <h3 class="text-center mb-4" style="color: #4e6e5d;">🌿 Hồ Sơ Cư Dân</h3>

                <form action="update-account" method="post">
                    <div class="form-group">
                        <label>Tên đăng nhập (Không thể đổi)</label>
                        <input type="text" class="form-control" value="${sessionScope.user.tenDangNhap}" readonly>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" style="border-radius: 15px;">
                            <i class="fas fa-times-circle"></i> ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty mess}">
                        <div class="alert alert-success" style="border-radius: 15px;">
                            <i class="fas fa-check-circle"></i> ${mess}
                        </div>
                    </c:if>

                    <div class="form-group">
                        <label>Họ và tên</label>
                        <input type="text" name="fullName" class="form-control" value="${sessionScope.user.hoTen}" required>
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" class="form-control" value="${sessionScope.user.soDienThoai}">
                    </div>

                    <!-- Trong file account.jsp, phần dưới dấu <hr> -->
                    <h5 style="color: #d66853;">Đổi mật khẩu</h5>

                    <div class="form-group">
                        <label>Mật khẩu hiện tại <span class="text-danger">*</span></label>
                        <input type="password" name="oldPass" class="form-control" placeholder="Nhập mật khẩu đang dùng" required>
                    </div>

                    <div class="form-group">
                        <label>Mật khẩu mới (Để trống nếu không đổi)</label>
                        <input type="password" name="newPass" class="form-control" placeholder="Nhập mật khẩu mới">
                    </div>

                    <hr>
                    <h5 style="color: #d66853;">Đổi mật khẩu (Để trống nếu không đổi)</h5>
                    <div class="form-group">
                        <label>Mật khẩu mới</label>
                        <input type="password" name="newPass" class="form-control">
                    </div>

                    <button type="submit" class="btn btn-success btn-block mt-4" style="border-radius: 15px;">
                        Cập nhật thông tin
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>