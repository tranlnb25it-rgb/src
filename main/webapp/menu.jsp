<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="entity.NguoiDung"%>
<html>
<head>
    <title>Thực đơn DrinkShop - Khu Vườn Ghibli</title>
    <!-- 1. CÁC THƯ VIỆN HỖ TRỢ -->
    <link href="https://fonts.googleapis.com/css2?family=Pangolin&family=Patrick+Hand&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- 2. NHÚNG FILE STYLE.CSS CỦA BẠN -->
    <link rel="stylesheet" href="style.css">

    <style>
    .about-section {
        padding: 60px 0;
        background-color: #FDF9F1;
        /* Thay Nunito bằng Patrick Hand cho mềm mại */
        font-family: 'Patrick Hand', cursive !important;
    }

    .about-card {
        background: #ffffff;
        border: 2px solid #4e6e5d;
        border-radius: 20px;
        padding: 40px;
        box-shadow: 10px 10px 0px #F2E8CF;
        margin-bottom: 30px;
    }

    /* Đảm bảo tiêu đề luôn dùng phông Pangolin */
    .ghibli-title, .about-card h2, .about-card h3 {
        font-family: 'Pangolin', cursive !important;
        color: #BC4749 !important;
        border-bottom: 2px dashed #4e6e5d;
        display: inline-block;
        margin-bottom: 20px;
    }

    /* Ép tất cả văn bản con bên trong dùng phông viết tay */
    .about-section p, .about-section span, .about-section div {
        font-family: 'Patrick Hand', cursive !important;
        font-size: 1.2rem; /* Tăng nhẹ size để dễ đọc hơn */
        color: #3E2723;
    }
        /* CSS bổ trợ để đảm bảo giao diện menu đồng bộ 100% */
        :root { --ghibli-green: #386641; --ghibli-red: #BC4749; --ghibli-yellow: #F2E8CF; --ghibli-brown: #3E2723; }
        body { background-color: #fdf9f1 !important; font-family: 'Patrick Hand', cursive; padding-bottom: 50px; min-height: 100vh; }
        h1 { font-family: 'Pangolin', cursive; color: var(--ghibli-green) !important; text-shadow: 2px 2px 0px var(--ghibli-yellow); margin-top: 20px; }

        .ghibli-user-panel { background: var(--ghibli-yellow); border: 2px dashed var(--ghibli-green); border-radius: 20px; padding: 8px 18px; font-family: 'Pangolin'; display: inline-block; box-shadow: 4px 4px 0px rgba(56, 102, 65, 0.1); }
        .badge-level { background: var(--ghibli-green); color: white; padding: 2px 12px; border-radius: 12px; font-size: 0.85rem; margin-left: 5px; }

        .btn-ghibli { background: white; border: 2px solid var(--ghibli-green); color: var(--ghibli-green); border-radius: 25px; padding: 8px 25px; font-weight: bold; margin: 5px; transition: 0.3s; cursor: pointer; }
        .btn-ghibli:hover, .btn-ghibli.active { background: var(--ghibli-green); color: white; box-shadow: 4px 4px 0px var(--ghibli-yellow); outline: none; text-decoration: none; }

        .product-card { transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); border-radius: 20px !important; border: 2px solid #eee !important; overflow: hidden; background: white; height: 100%; position: relative; }
        .product-card:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(56, 102, 65, 0.15); border-color: var(--ghibli-green) !important; }
        .price-text { color: var(--ghibli-red); font-size: 1.1rem; font-weight: 900; }

        .cart-floating { position: fixed; bottom: 30px; right: 30px; background-color: var(--ghibli-red); color: white; width: 65px; height: 65px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 26px; cursor: pointer; z-index: 1000; box-shadow: 0 4px 15px rgba(0,0,0,0.3); transition: 0.3s; }
        .cart-floating:hover { transform: scale(1.1); }
        .form-control:focus { border-color: var(--ghibli-green); box-shadow: none; }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<!-- 3. NHÚNG THANH NAVBAR TỪ FILE NAVBAR.JSP -->
<jsp:include page="navbar.jsp" />

<!-- Nút giỏ hàng nhanh -->
<div class="cart-floating" onclick="openCartModal()">
    <i class="fas fa-shopping-basket"></i>
    <span id="cart-count" class="badge badge-warning" style="position:absolute; top:0; right:0; border-radius: 50%; font-size: 0.8rem;">0</span>
</div>

<div class="container mt-4">
    <div class="d-flex justify-content-end align-items-center flex-wrap">
        <!-- Phần này đã có trong Navbar nhưng giữ lại dự phòng nếu bạn chưa muốn dùng Navbar hoàn toàn -->
        <c:if test="${not empty sessionScope.user}">
            <div class="ghibli-user-panel mt-2">
                Chào cư dân <strong>${sessionScope.user.hoTen}</strong>
                <span class="badge-level">
                    ${not empty sessionScope.user.capDo ? sessionScope.user.capDo : 'Thành viên'}
                    <c:choose>
                        <c:when test="${sessionScope.user.capDo == 'Hạt Mầm'}">🌱</c:when>
                        <c:when test="${sessionScope.user.capDo == 'Cành Lá'}">🍃</c:when>
                        <c:when test="${sessionScope.user.capDo == 'Cổ Thụ'}">🌳</c:when>
                        <c:otherwise>✨</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </c:if>
    </div>
</div>

<div class="container">
    <h1 class="text-center mb-4">✨ Thực Đơn Phép Màu ✨</h1>

    <!-- Bộ lọc danh mục -->
    <div class="category-filter text-center mb-5">
        <button class="btn btn-ghibli active" onclick="filterSelection('all', this)">Tất cả</button>
        <button class="btn btn-ghibli" onclick="filterSelection('1', this)">Cà phê</button>
        <button class="btn btn-ghibli" onclick="filterSelection('2', this)">Trà sữa</button>
        <button class="btn btn-ghibli" onclick="filterSelection('3', this)">Đá xay</button>
        <button class="btn btn-ghibli" onclick="filterSelection('4', this)">Nước ép</button>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="row" id="productContainer">
        <c:forEach items="${listP}" var="p">
            <div class="col-lg-3 col-md-4 col-sm-6 mb-5 filter-item">
                <div class="card product-card border-0">
                    <span class="cat-id d-none">${p.categoryId}</span>
                    <div style="overflow: hidden; height: 180px;">
                        <img src="https://loremflickr.com/320/240/drink?random=${p.id}" class="card-img-top" alt="${p.name}" style="height: 100%; width: 100%; object-fit: cover;">
                    </div>
                    <div class="card-body text-center">
                        <h6 class="card-title font-weight-bold" style="font-family: 'Pangolin'; min-height: 45px; color: var(--ghibli-brown);">${p.name}</h6>
                        <p class="price-text">${p.price} VNĐ</p>
                        <button class="btn btn-sm btn-ghibli active rounded-pill w-100 mt-2"
                                onclick="openOrderModal('${p.id}', '${p.name}', '${p.price}')">Thêm vào giỏ</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- MODAL ĐẶT MÓN & GIỎ HÀNG (GIỮ NGUYÊN LOGIC CŨ) -->
<div class="modal fade" id="orderModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 30px; border: 3px solid var(--ghibli-green); background: #fdf9f1;">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title font-weight-bold" id="modalProductName" style="font-family: 'Pangolin'; font-size: 1.6rem; color: var(--ghibli-green);">Tên món</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="orderForm">
                    <input type="hidden" id="modalProductId">
                    <div class="form-group">
                        <label class="font-weight-bold">Số lượng:</label>
                        <input type="number" name="quantity" id="orderQuantity" class="form-control rounded-pill text-center" value="1" min="1">
                    </div>
                    <div class="form-group">
                        <label class="font-weight-bold">Topping thêm (+5.000đ):</label>
                        <div class="custom-control custom-checkbox ml-2">
                            <input type="checkbox" class="custom-control-input" id="top1" name="toppings" value="Trân châu">
                            <label class="custom-control-label" for="top1">Trân châu đen</label>
                        </div>
                        <div class="custom-control custom-checkbox ml-2">
                            <input type="checkbox" class="custom-control-input" id="top2" name="toppings" value="Thạch Ghibli">
                            <label class="custom-control-label" for="top2">Thạch Ghibli</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="font-weight-bold">Ghi chú của bạn:</label>
                        <textarea name="note" class="form-control" style="border-radius: 15px;" rows="2" placeholder="Ví dụ: Ít đường, nhiều đá..."></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer border-0">
                <button type="submit" form="orderForm" class="btn btn-success btn-block rounded-pill py-2" style="background: var(--ghibli-red); border:none;">Xác nhận đặt món</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="cartModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="border-radius: 25px; background: #fdf9f1; border: 2px solid var(--ghibli-green);">
            <div class="modal-header border-0">
                <h5 class="modal-title font-weight-bold" style="font-family: 'Pangolin'; font-size: 1.5rem; color: var(--ghibli-green);">Giỏ hàng hiện tại</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body p-0">
                <div class="table-responsive px-3">
                    <table class="table table-borderless align-middle">
                        <thead class="text-muted" style="border-bottom: 2px solid var(--ghibli-yellow);">
                            <tr>
                                <th>Món ăn</th>
                                <th class="text-center">Đơn giá</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-right">Thành tiền</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="cart-items-list"></tbody>
                    </table>
                </div>
                <div class="px-4 text-right my-3">
                    <span style="font-size: 1.2rem;">Tổng tiền: </span>
                    <span id="cart-total" class="font-weight-bold" style="font-size: 1.8rem; color: var(--ghibli-red);">0</span>
                    <span class="font-weight-bold" style="color: var(--ghibli-red);">VNĐ</span>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button class="btn btn-success rounded-pill px-5 py-2 btn-block" onclick="checkout()" style="background: var(--ghibli-green); border:none;">Tiến hành đặt hàng</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    let cart = [];

    function openOrderModal(id, name, price) {
        document.getElementById('modalProductId').value = id;
        document.getElementById('modalProductName').innerText = name;
        document.getElementById('modalProductName').setAttribute('data-price', price);
        document.getElementById('orderQuantity').value = 1;
        $('#orderModal').modal('show');
    }

    $('#orderForm').on('submit', function(e) {
        e.preventDefault();
        const id = document.getElementById('modalProductId').value;
        const name = document.getElementById('modalProductName').innerText;
        const price = parseFloat(document.getElementById('modalProductName').getAttribute('data-price'));
        const qty = parseInt(document.getElementById('orderQuantity').value);
        const note = this.note.value;

        let toppings = [];
        $("input[name='toppings']:checked").each(function() { toppings.push($(this).val()); });
        let toppingText = toppings.length > 0 ? toppings.join(", ") : "Không";
        let extraPrice = toppings.length * 5000;

        cart.push({
            id: id, name: name, qty: qty, price: price, extra: extraPrice,
            topping: toppingText, total: (price + extraPrice) * qty, note: note
        });

        updateCartUI();
        $('#orderModal').modal('hide');
        this.reset();
        Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: 'Đã thêm vào giỏ', showConfirmButton: false, timer: 1500 });
    });

    function updateCartUI() {
        document.getElementById('cart-count').innerText = cart.length;
        let html = "";
        let totalAll = 0;

        if(cart.length === 0) {
            html = '<tr><td colspan="5" class="text-center py-4 text-muted">Chưa có món nào trong giỏ hết...</td></tr>';
        } else {
            cart.forEach((item, index) => {
                totalAll += item.total;
                html += `<tr>
                    <td>
                        <b class="d-block text-dark">\${item.name}</b>
                        <small class="text-muted">Topping: \${item.topping} | \${item.note || 'Không ghi chú'}</small>
                    </td>
                    <td class="text-center">\${item.price.toLocaleString()}đ</td>
                    <td class="text-center">\${item.qty}</td>
                    <td class="text-right font-weight-bold text-danger">\${item.total.toLocaleString()}đ</td>
                    <td class="text-right">
                        <button class="btn btn-link btn-sm text-danger" onclick="removeItem(\${index})"><i class="fas fa-trash"></i></button>
                    </td>
                </tr>`;
            });
        }

        document.getElementById('cart-items-list').innerHTML = html;
        document.getElementById('cart-total').innerText = totalAll.toLocaleString();
    }

    function removeItem(index) {
        cart.splice(index, 1);
        updateCartUI();
    }

    function openCartModal() {
        $('#cartModal').modal('show');
    }

    function checkout() {
        if (cart.length === 0) return Swal.fire('Giỏ hàng trống!', 'Hãy chọn món trước nhé.', 'warning');

        let cartSummary = cart.map(item => `\${item.name} (x\${item.qty})`).join(' | ');
        let cartData = cart.map(item => `\${item.id},\${item.qty},\${item.price + item.extra},\${item.name}`).join(';');

        Swal.fire({
            title: 'Xác nhận đơn hàng?',
            text: "Gửi đơn hàng này tới quầy pha chế nhé!",
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#386641',
            confirmButtonText: 'Gửi ngay!',
            cancelButtonText: 'Chỉnh sửa thêm'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'saveOrder',
                    type: 'POST',
                    data: { dataCart: cartData, summary: cartSummary },
                    success: function() {
                        Swal.fire('Hoàn tất!', 'Đơn hàng đã được gửi thành công.', 'success').then(() => {
                            cart = [];
                            updateCartUI();
                            location.reload();
                        });
                    },
                    error: function() {
                        Swal.fire('Lỗi kết nối', 'Không thể gửi đơn hàng lúc này.', 'error');
                    }
                });
            }
        });
    }

    function filterSelection(c, btn) {
        var items = document.getElementsByClassName("filter-item");
        if (c == "all") c = "";
        for (var i = 0; i < items.length; i++) {
            var catId = items[i].querySelector(".cat-id").innerText;
            items[i].style.display = (c === "" || catId === c) ? "block" : "none";
        }
        $('.category-filter .btn-ghibli').removeClass('active');
        $(btn).addClass('active');
    }
</script>
</body>
<!-- Nhúng phần About vào bất kỳ đâu bạn muốn -->
<%@ include file="about_section.jsp" %>
</html>