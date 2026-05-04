<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lịch sử đơn hàng - Tri-Wisdom</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <%-- Chèn Navbar của bạn vào đây --%>
    <jsp:include page="navbar.jsp"></jsp:include>

    <div class="container mt-5">
        <h2 class="mb-4">📦 Đơn hàng của bạn</h2>

        <table class="table table-hover bg-white shadow-sm">
            <thead class="table-dark">
                <tr>
                    <th>Mã đơn</th>
                    <th>Ngày đặt</th>
                    <th>Tóm tắt đơn hàng</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listOrders}" var="o">
                    <tr>
                        <td>#${o.maDonHang}</td>
                        <td>${o.ngayDat}</td>
                        <td>${o.tenDonHang}</td>
                        <td class="text-danger fw-bold">${o.tongTien} VNĐ</td>
                        <td>
                            <span class="badge ${o.trangThaiDonHang == 'Đã hoàn thành' ? 'bg-success' : 'bg-warning text-dark'}">
                                ${o.trangThaiDonHang}
                            </span>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listOrders}">
                    <tr>
                        <td colspan="5" class="text-center">Bạn chưa có đơn hàng nào. Hãy đặt món ngay nhé!</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>