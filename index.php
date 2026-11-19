<?php
// BÀI 2. Form gửi email (nhập người nhận, tiêu đề, nội dung, file đính kèm)
$thongbao = $_GET['msg'] ?? '';
$loi      = $_GET['err'] ?? '';
?>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DEMO GỬI EMAIL</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
</head>
<body>
<div class="container py-4" style="max-width: 720px">
    <h2>Email tới bạn</h2>
    <p><a href="bai3.php">→ Bài 3: gửi cho nhiều người</a></p>

    <?php if ($thongbao): ?>
        <div class="alert alert-success"><?= htmlspecialchars($thongbao) ?></div>
    <?php endif; ?>
    <?php if ($loi): ?>
        <div class="alert alert-danger"><?= htmlspecialchars($loi) ?></div>
    <?php endif; ?>

    <form action="mail.php" enctype="multipart/form-data" method="POST">
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" placeholder="Email" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Subject</label>
            <input type="text" class="form-control" name="tieude" placeholder="Tiêu đề" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Nội dung</label>
            <textarea name="content" id="editor" class="form-control"></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">File đính kèm</label>
            <input type="file" class="form-control" name="file">
        </div>
        <button type="submit" class="btn btn-primary">Gửi</button>
    </form>
</div>
<script>CKEDITOR.replace('editor');</script>
</body>
</html>
