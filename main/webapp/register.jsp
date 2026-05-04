<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>GIA NHẬP KHU VƯỜN GHIBLI | Đăng Ký Thành Viên</title>
    <link href="https://fonts.googleapis.com/css2?family=Pangolin&family=Patrick+Hand&family=Nunito:wght@700;900&display=swap" rel="stylesheet">
    <!-- Thêm Font Awesome để dùng icon cho ngày sinh -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --ghibli-green: #386641;
            --ghibli-yellow: #F2E8CF;
            --ghibli-red: #BC4749;
            --ghibli-brown: #3E2723;
            --paper: #FDF9F1;
        }

        body {
            margin: 0; font-family: 'Nunito', sans-serif;
            background-color: var(--paper); color: var(--ghibli-brown);
            padding-top: 100px;
        }

        h1, h2, h3 { font-family: 'Pangolin', cursive; text-align: center; }
        p { font-family: 'Patrick Hand', cursive; font-size: 1.4rem; text-align: center; }

        nav {
            background: white; padding: 15px 8%; display: flex; justify-content: space-between;
            align-items: center; position: fixed; top: 0; width: 100%; box-sizing: border-box;
            z-index: 2000; border-bottom: 3px solid var(--ghibli-green);
        }
        .nav-logo { font-size: 2rem; color: var(--ghibli-green); text-decoration: none; font-family: 'Pangolin', cursive; }

        .container { max-width: 1100px; margin: 0 auto; padding: 40px 20px; }

        .register-wrapper {
            display: grid; grid-template-columns: 1fr 1fr; gap: 50px;
            background: white; padding: 50px; border-radius: 40px;
            border: 3px solid var(--ghibli-green); box-shadow: 15px 15px 0px var(--ghibli-yellow);
        }

        .reg-promo h2 { color: var(--ghibli-red); text-align: left; font-size: 2.5rem; }
        .reg-promo ul { list-style: none; padding: 0; }
        .reg-promo li { font-family: 'Patrick Hand'; font-size: 1.6rem; margin-bottom: 15px; display: flex; align-items: center; }
        .reg-promo li::before { content: '✨'; margin-right: 15px; }

        .form-box { display: flex; flex-direction: column; gap: 15px; }
        .form-box input {
            padding: 12px 20px; border-radius: 15px; border: 2px solid #eee;
            font-size: 1rem; font-family: 'Nunito', sans-serif;
            background: #fafafa;
        }
        .form-box input:focus { outline: none; border-color: var(--ghibli-green); background: white; }

        .dob-label { font-family: 'Pangolin'; color: var(--ghibli-green); margin-bottom: -10px; font-size: 1.1rem; }

        .btn-submit {
            background: var(--ghibli-green); color: white; padding: 15px;
            border: none; border-radius: 50px; font-family: 'Pangolin';
            font-size: 1.6rem; cursor: pointer; transition: 0.3s; margin-top: 10px;
        }
        .btn-submit:hover { background: var(--ghibli-red); transform: scale(1.02); }

        .loyalty-section { margin-top: 80px; text-align: center; }
        .loyalty-grid {
            display: flex; justify-content: space-between; margin-top: 50px;
            position: relative; padding-bottom: 40px; flex-wrap: wrap; gap: 20px;
        }
        .loyalty-grid::before {
            content: ''; position: absolute; top: 40px; left: 0; width: 100%;
            height: 4px; background: var(--ghibli-yellow); z-index: 1;
        }
        .loyalty-item {
            position: relative; z-index: 2; background: var(--paper);
            padding: 20px; border-radius: 20px; width: 20%; min-width: 150px;
        }
        .icon-circle {
            width: 80px; height: 80px; background: white; border: 3px solid var(--ghibli-green);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 2rem; margin: 0 auto 15px;
        }
        .loyalty-item h4 { margin: 10px 0; font-size: 1.4rem; color: var(--ghibli-red); }

        .extra-gifts {
            margin-top: 50px; background: var(--ghibli-yellow);
            padding: 30px; border-radius: 25px; border: 2px dashed var(--ghibli-green);
        }
    </style>
</head>
<body>

<nav>
    <a href="index" class="nav-logo">GHIBLI</a>
    <div class="nav-menu">
        <a href="index" style="text-decoration: none; color: var(--ghibli-brown);">Trang Chủ</a>
        <a href="login" style="margin-left: 20px; text-decoration: none; color: var(--ghibli-green); font-weight: bold;">Đăng Nhập</a>
    </div>
</nav>

<div class="container">
    <div class="register-wrapper">
        <div class="reg-promo">
            <h2>Gia Nhập Ngay!</h2>
            <p style="text-align: left;">Trở thành một phần của khu vườn để nhận những đặc quyền chỉ dành riêng cho bạn.</p>
            <ul>
                <li>Nhận ngay Voucher <b>Giảm 30%</b> cho đơn hàng đầu tiên.</li>
                <li>Tích lũy "Hạt Mầm" qua mỗi lần mua hàng.</li>
                <li>Nhận quà tặng thủ công vào ngày sinh nhật.</li>
                <li>Ưu tiên thưởng thức các món mới theo mùa.</li>
            </ul>
        </div>

        <form class="form-box" action="register" method="post">
            <h3 style="margin-bottom: 5px;">Điền thông tin nhận thẻ</h3>

            <p style="color: var(--ghibli-red); font-size: 1.1rem; text-align: center; margin: 0;">${mess}</p>

            <input type="text" name="user" placeholder="Tên đăng nhập (viết liền)..." required>
            <input type="password" name="pass" placeholder="Mật khẩu của bạn..." required>
            <input type="text" name="name" placeholder="Tên của bạn hoặc biệt danh..." required>

            <!-- Ô nhập Ngày Sinh mới thêm vào -->
            <label class="dob-label"><i class="fas fa-birthday-cake"></i> Ngày sinh của bạn:</label>
            <input type="date" name="dob" required>

            <input type="text" name="phone" placeholder="Số điện thoại nhận quà..." required>
            <input type="email" name="email" placeholder="Email (không bắt buộc)...">

            <button type="submit" class="btn-submit">NHẬN THẺ THÔNG HÀNH ✨</button>
            <p style="font-size: 0.9rem; opacity: 0.7; margin-top: 5px;">* Thông tin được bảo vệ bởi phép thuật Ghibli.</p>
        </form>
    </div>

    <div class="loyalty-section">
        <h2>Lộ Trình Ưu Đãi Cư Dân</h2>
        <div class="loyalty-grid">
            <div class="loyalty-item">
                <div class="icon-circle">🌱</div>
                <h4>HẠT MẦM</h4>
                <p style="font-size: 1.1rem;">Mới đăng ký: Giảm 30% đơn đầu.</p>
            </div>
            <div class="loyalty-item">
                <div class="icon-circle">🍃</div>
                <h4>CÀNH LÁ</h4>
                <p style="font-size: 1.1rem;">Tích lũy 500k: Tặng túi vải Ghibli.</p>
            </div>
            <div class="loyalty-item">
                <div class="icon-circle">🌳</div>
                <h4>CỔ THỤ</h4>
                <p style="font-size: 1.1rem;">Tích lũy 1.5tr: Tặng quà sinh nhật VIP.</p>
            </div>
            <!-- Đã sửa lỗi thiếu thẻ div ở đây -->
            <div class="loyalty-item">
                <div class="icon-circle">🏰</div>
                <h4>LÂU ĐÀI</h4>
                <p style="font-size: 1.1rem;">Khách VIP: Giảm 15% vĩnh viễn.</p>
            </div>
        </div>

        <div class="extra-gifts">
            <h3 style="color: var(--ghibli-brown);">🎁 CÙNG NHIỀU PHẦN QUÀ HẤP DẪN KHÁC</h3>
            <p>Hàng tháng, tiệm sẽ bốc thăm may mắn để tặng cư dân tích cực nhất.</p>
        </div>
    </div>
</div>

<footer style="text-align: center; padding: 40px; opacity: 0.5;">
    <p>&copy; 2026 GHIBLI Drink Shop - Tri-Wisdom Team.</p>
</footer>

</body>
</html>