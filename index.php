<?php
require 'db.php';
$result = mysqli_query($conn, "SELECT * FROM Users ORDER BY admin_id DESC");
?>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Nhân sự - Frontend</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; }
        .user-card { transition: transform 0.2s; border: none; border-radius: 12px; overflow: hidden; }
        .user-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .avatar-img { height: 220px; object-fit: cover; width: 100%; }
     </style>
</head>
<body>  
    <nav class="navbar navbar-dark bg-primary mb-4 shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.php">HỆ THỐNG NHÂN SỰ</a>
            <a href="admin.php" class="btn btn-light btn-sm fw-semibold">Vào trang Quản trị (Admin)</a>
        </div>
    </nav>

    <div class="container">
        <h3 class="text-center mb-4 fw-bold text-dark">DANH SÁCH NGƯỜI DÙNG (USERS)</h3>
        <div class="row g-4">
            <?php while ($row = mysqli_fetch_assoc($result)): ?>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card user-card shadow-sm h-100">
                        <img src="uploads/<?= htmlspecialchars($row['images']) ?>" class="avatar-img" alt="Avatar" onerror="this.src='https://via.placeholder.com/300x220?text=No+Image'">
                        <div class="card-body text-center">
                            <span class="badge bg-secondary mb-2">ID: #<?= $row['admin_id'] ?></span>
                            <h6 class="card-title text-truncate fw-bold" title="<?= htmlspecialchars($row['admin_email']) ?>">
                                <?= htmlspecialchars($row['admin_email']) ?>
                            </h6>
                        </div>
                    </div>
                </div>
            <?php endwhile; ?>
        </div>
    </div>
</body>
</html> 
