<?php
// BÀI 2 - Bước 2. Xử lý form index.php và gửi mail
require __DIR__ . '/config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: index.php');
    exit;
}

$to      = trim($_POST['email'] ?? '');
$tieude  = trim($_POST['tieude'] ?? '');
$content = $_POST['content'] ?? '';
$to_name = 'bạn';

if (!filter_var($to, FILTER_VALIDATE_EMAIL)) {
    header('Location: index.php?err=' . urlencode('Địa chỉ email không hợp lệ'));
    exit;
}

$mail = taoMailer();
$uploadfile = null;
try {
    $mail->addAddress($to, $to_name);
    $mail->Subject = $tieude;
    $mail->Body = '
        <div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title"><b>Xin chào ' . $to_name . '</b></h5>
                <p class="card-text">' . $content . '</p>
            </div>
        </div>';
    $mail->AltBody = strip_tags($content);

    // File đính kèm (nếu người dùng có chọn file)
    if (isset($_FILES['file']) && $_FILES['file']['error'] === UPLOAD_ERR_OK) {
        $uploadfile = tempnam(sys_get_temp_dir(), sha1($_FILES['file']['name']));
        if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
            $mail->addAttachment($uploadfile, $_FILES['file']['name']);
        }
    }

    $mail->send();
    header('Location: index.php?msg=' . urlencode("Đã gửi mail tới $to"));
} catch (Exception $e) {
    header('Location: index.php?err=' . urlencode('Mail không gửi được. Lỗi: ' . $mail->ErrorInfo));
} finally {
    if ($uploadfile && file_exists($uploadfile)) {
        unlink($uploadfile);   // xoá file tạm
    }
}
