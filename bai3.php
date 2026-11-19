<?php
// BÀI 3. Gửi email cho nhiều địa chỉ khác nhau (nhập tay hoặc lấy từ CSDL MySQL)
require __DIR__ . '/config.php';

// ---- Lấy danh sách người nhận từ CSDL ----
$dsDB = [];
$loiDB = '';
mysqli_report(MYSQLI_REPORT_OFF);
$conn = @new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
if ($conn->connect_error) {
    $loiDB = 'Chưa kết nối được CSDL (hãy import database.sql): ' . $conn->connect_error;
} else {
    $conn->set_charset('utf8mb4');
    $rs = $conn->query('SELECT ten, email FROM nguoinhan ORDER BY id');
    if ($rs) {
        while ($row = $rs->fetch_assoc()) {
            $dsDB[] = $row;
        }
    }
}

// ---- Xử lý gửi mail ----
$ketqua = '';
$loi = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $tieude  = trim($_POST['tieude'] ?? '');
    $content = $_POST['content'] ?? '';

    // Gộp email chọn từ CSDL + email nhập tay (cách nhau bằng dấu phẩy)
    $recipients  = trim($_POST['recipients'] ?? '');
    $email_array = $recipients === '' ? [] : explode(',', $recipients);
    $email_array = array_merge($email_array, $_POST['chon'] ?? []);
    $email_array = array_unique(array_map('trim', $email_array));   // bỏ trùng
    $hople   = array_filter($email_array, fn($e) => filter_var($e, FILTER_VALIDATE_EMAIL));
    $khonghl = array_diff(array_filter($email_array), $hople);

    if (!$hople) {
        $loi = 'Chưa có địa chỉ email hợp lệ nào.';
    } else {
        $mail = taoMailer();
        $uploadfile = null;
        try {
            foreach ($hople as $email) {
                $mail->addAddress($email);
            }
            $mail->Subject = $tieude;
            $mail->Body    = $content;
            $mail->AltBody = strip_tags($content);

            if (isset($_FILES['file']) && $_FILES['file']['error'] === UPLOAD_ERR_OK) {
                $uploadfile = tempnam(sys_get_temp_dir(), sha1($_FILES['file']['name']));
                if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
                    $mail->addAttachment($uploadfile, $_FILES['file']['name']);
                }
            }

            $mail->send();
            $ketqua = 'Đã gửi mail tới ' . count($hople) . ' địa chỉ: ' . implode(', ', $hople);
            if ($khonghl) {
                $ketqua .= ' (bỏ qua địa chỉ không hợp lệ: ' . implode(', ', $khonghl) . ')';
            }
        } catch (Exception $e) {
            $loi = 'Mail không gửi được. Lỗi: ' . $mail->ErrorInfo;
        } finally {
            if ($uploadfile && file_exists($uploadfile)) {
                unlink($uploadfile);
            }
        }
    }
}
?>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gửi email nhiều người</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
</head>
<body>
<div class="container py-4" style="max-width: 720px">
    <h2>Gửi email cho nhiều người</h2>
    <p><a href="index.php">← Bài 2</a></p>

    <?php if ($ketqua): ?><div class="alert alert-success"><?= htmlspecialchars($ketqua) ?></div><?php endif; ?>
    <?php if ($loi): ?><div class="alert alert-danger"><?= htmlspecialchars($loi) ?></div><?php endif; ?>

    <form method="POST" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Chọn người nhận từ CSDL</label>
            <?php if ($loiDB): ?>
                <div class="text-danger small"><?= htmlspecialchars($loiDB) ?></div>
            <?php elseif (!$dsDB): ?>
                <div class="text-muted small">Bảng nguoinhan chưa có dữ liệu.</div>
            <?php else: ?>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="chonTatCa"
                           onclick="document.querySelectorAll('.chon').forEach(c => c.checked = this.checked)">
                    <label class="form-check-label fw-bold" for="chonTatCa">Chọn tất cả</label>
                </div>
                <?php foreach ($dsDB as $i => $r): ?>
                    <div class="form-check">
                        <input class="form-check-input chon" type="checkbox" name="chon[]" id="c<?= $i ?>"
                               value="<?= htmlspecialchars($r['email']) ?>">
                        <label class="form-check-label" for="c<?= $i ?>">
                            <?= htmlspecialchars($r['ten']) ?> &lt;<?= htmlspecialchars($r['email']) ?>&gt;
                        </label>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
        <div class="mb-3">
            <label class="form-label">Hoặc nhập thêm email (cách nhau bằng dấu phẩy)</label>
            <input type="text" class="form-control" name="recipients" placeholder="a@gmail.com,b@gmail.com">
        </div>
        <div class="mb-3">
            <label class="form-label">Tiêu đề</label>
            <input type="text" class="form-control" name="tieude" required>
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
