<?php
require 'db.php';
$message = "";

// 1. XỬ LÝ SỬA USER THEO ID
if (isset($_POST['update_user'])) {
    $id = (int)$_POST['admin_id'];
    $email = mysqli_real_escape_string($conn, $_POST['admin_email']);
    
    // Kiểm tra ID có tồn tại trong CSDL không
    $check = mysqli_query($conn, "SELECT * FROM Users WHERE admin_id = $id");
    if (mysqli_num_rows($check) > 0) {
        $sql_pass = "";
        if (!empty($_POST['admin_password'])) {
            $password = password_hash($_POST['admin_password'], PASSWORD_DEFAULT);
            $sql_pass = ", admin_password = '$password'";
        }

        $sql_img = "";
        if (isset($_FILES['images']) && $_FILES['images']['error'] == 0) {
            $image_name = time() . '_' . basename($_FILES['images']['name']);
            if (move_uploaded_file($_FILES['images']['tmp_name'], "uploads/" . $image_name)) {
                $row_old = mysqli_fetch_assoc($check);
                @unlink("uploads/" . $row_old['images']);
                $sql_img = ", images = '$image_name'";
            }
        }

        $sql = "UPDATE Users SET admin_email = '$email' $sql_pass $sql_img WHERE admin_id = $id";
        if (mysqli_query($conn, $sql)) {
            $message = "<div class='alert alert-warning'>Đã cập nhật thành công thông tin cho User ID: <b>#$id</b>!</div>";
        }
    } else {
        $message = "<div class='alert alert-danger'>Không tìm thấy User có ID: <b>#$id</b> để sửa!</div>";
    }
}

// 2. XỬ LÝ XÓA USER THEO ID
if (isset($_POST['delete_user'])) {
    $id = (int)$_POST['admin_id'];
    
    $res = mysqli_query($conn, "SELECT images FROM Users WHERE admin_id = $id");
    if ($row = mysqli_fetch_assoc($res)) {
        @unlink("uploads/" . $row['images']);
        mysqli_query($conn, "DELETE FROM Users WHERE admin_id = $id");
        $message = "<div class='alert alert-info'>Đã xóa thành công User có ID: <b>#$id</b> khỏi CSDL!</div>";
    } else {
        $message = "<div class='alert alert-danger'>Không tìm thấy User có ID: <b>#$id</b> để xóa!</div>";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản trị Users - Backend</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <span class="navbar-brand fw-bold">BACKEND - SỬA & XÓA USERS</span>
            <a href="index.php" class="btn btn-outline-light btn-sm">Sang trang Frontend</a>
        </div>
    </nav>

    <div class="container">
        <!-- Thông báo kết quả thao tác -->
        <?= $message ?>

        <div class="row g-4 justify-content-center">
            <!-- KHUNG 1: SỬA USER -->
            <div class="col-md-5">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-warning text-dark fw-bold">Sửa Thông Tin User</div>
                    <div class="card-body">
                        <form method="POST" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label class="form-label">Nhập ID cần sửa (admin_id)</label>
                                <input type="number" name="admin_id" class="form-control" required placeholder="Ví dụ: 1">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email mới</label>
                                <input type="email" name="admin_email" class="form-control" required placeholder="emailmoi@gmail.com">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mật khẩu mới (Tùy chọn)</label>
                                <input type="password" name="admin_password" class="form-control" placeholder="Bỏ trống nếu giữ nguyên">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ảnh mới (Tùy chọn)</label>
                                <input type="file" name="images" class="form-control" accept="image/*">
                            </div>
                            <button type="submit" name="update_user" class="btn btn-warning w-100 fw-bold">Cập Nhật User</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- KHUNG 2: XÓA USER -->
            <div class="col-md-5">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-danger text-white fw-bold">Xóa User</div>
                    <div class="card-body d-flex flex-column justify-content-between">
                        <form method="POST" onsubmit="return confirm('Bạn chắc chắn muốn xóa ID này?');">
                            <div class="mb-3">
                                <label class="form-label">Nhập ID cần xóa (admin_id)</label>
                                <input type="number" name="admin_id" class="form-control" required placeholder="Ví dụ: 2">
                            </div>
                            <p class="text-muted small">Lưu ý: Thao tác này sẽ xóa vĩnh viễn dữ liệu người dùng và ảnh đại diện tương ứng khỏi cơ sở dữ liệu.</p>
                            <button type="submit" name="delete_user" class="btn btn-danger w-100 fw-bold mt-3">Xóa Dữ Liệu</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>