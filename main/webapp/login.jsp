<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>ĐĂNG NHẬP | GHIBLI Drink Shop</title>
    <link href="https://fonts.googleapis.com/css2?family=Pangolin&family=Patrick+Hand&family=Nunito:wght@700;900&display=swap" rel="stylesheet">
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
            display: flex; justify-content: center; align-items: center;
            height: 100vh; overflow: hidden;
        }

        /* --- BACKGROUND DECOR --- */
        .leaf-decor { position: absolute; font-size: 3rem; opacity: 0.2; z-index: -1; }

        .login-card {
            background: white; padding: 50px; border-radius: 40px;
            border: 3px solid var(--ghibli-green);
            box-shadow: 20px 20px 0px var(--ghibli-yellow);
            width: 100%; max-width: 450px; text-align: center;
            position: relative;
        }

        h2 { font-family: 'Pangolin', cursive; font-size: 2.8rem; color: var(--ghibli-green); margin-bottom: 10px; }
        p { font-family: 'Patrick Hand', cursive; font-size: 1.4rem; margin-bottom: 30px; }

        .input-group { text-align: left; margin-bottom: 20px; }
        .input-group label { display: block; font-family: 'Patrick Hand'; font-size: 1.3rem; margin-bottom: 8px; }
        .input-group input {
            width: 100%; padding: 15px; border-radius: 15px;
            border: 2px solid #eee; font-size: 1.1rem; box-sizing: border-box;
            outline: none; transition: 0.3s;
        }
        .input-group input:focus { border-color: var(--ghibli-green); background: #f9fdfa; }

        .btn-login {
            width: 100%; background: var(--ghibli-green); color: white;
            padding: 18px; border: none; border-radius: 50px;
            font-family: 'Pangolin'; font-size: 1.8rem; cursor: pointer;
            transition: 0.3s; margin-top: 10px;
        }
        .btn-login:hover { background: var(--ghibli-red); transform: translateY(-3px); }

        .extra-links { margin-top: 25px; font-family: 'Patrick Hand'; font-size: 1.2rem; }
        .extra-links a { color: var(--ghibli-red); text-decoration: none; font-weight: bold; }
        .extra-links a:hover { text-decoration: underline; }

        .back-home { position: absolute; top: -60px; left: 0; color: var(--ghibli-green); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<div class="leaf-decor" style="top:10%; left:10%;">🍃</div>
<div class="leaf-decor" style="bottom:15%; right:15%;">🌱</div>
<div class="leaf-decor" style="top:20%; right:5%;">🌸</div>

<div class="login-card">
    <a href="index.jsp" class="back-home">← Quay về tiệm</a>
    <h2>Mừng bạn về nhà!</h2>
    <p>Nhập chìa khóa để vào khu vườn nhé...</p>

    <!-- 1. Thêm action="login" và method="post" -->
    <form action="login" method="post">

        <!-- 2. Hiển thị thông báo lỗi nếu đăng nhập sai -->
        <% if(request.getAttribute("mess") != null) { %>
        <p style="color: var(--ghibli-red); font-size: 1.1rem; margin-bottom: 15px;">
            <%= request.getAttribute("mess") %>
        </p>
        <% } %>

        <div class="input-group">
            <label>Tên đăng nhập</label>
            <!-- 3. QUAN TRỌNG: Thêm thuộc tính name="user" -->
            <input type="text" name="user" placeholder="Nhập tên đăng nhập của bạn" required>
        </div>
        <div class="input-group">
            <label>Mật khẩu khu vườn</label>
            <!-- 4. QUAN TRỌNG: Thêm thuộc tính name="pass" -->
            <input type="password" name="pass" placeholder="••••••••" required>
        </div>

        <!-- 5. Đổi type="button" thành type="submit" để gửi form -->
        <button type="submit" class="btn-login">MỞ CỬA ✨</button>
    </form>

    <div class="extra-links">
        Chưa có thẻ thông hành? <a href="register.jsp">Đăng ký tại đây</a>
    </div>
</div>
</body>
</html>