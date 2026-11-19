<?php
// ============================================================
//  CẤU HÌNH SMTP GMAIL
//  Tài khoản + mật khẩu ứng dụng nằm trong secret.php (copy từ secret.example.php)
// ============================================================
if (!file_exists(__DIR__ . '/secret.php')) {
    die('Thiếu file secret.php — hãy copy secret.example.php thành secret.php và điền thông tin Gmail.');
}
require __DIR__ . '/secret.php';
define('SMTP_NAME', 'Lab 8 - PHP Mail');        // tên người gửi hiển thị

// Cấu hình CSDL cho Bài 3
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'lab8_email');

require __DIR__ . '/PHPMailer-master/src/PHPMailer.php';
require __DIR__ . '/PHPMailer-master/src/SMTP.php';
require __DIR__ . '/PHPMailer-master/src/Exception.php';

use PHPMailer\PHPMailer\PHPMailer;

/**
 * Tạo sẵn một đối tượng PHPMailer đã cấu hình SMTP Gmail.
 */
function taoMailer(): PHPMailer
{
    $mail = new PHPMailer(true);           // true: bật exception
    // $mail->SMTPDebug = 2;               // bật khi cần xem log gửi mail
    $mail->isSMTP();
    $mail->CharSet    = 'UTF-8';           // bắt buộc khi gửi tiếng Việt
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = SMTP_USER;
    $mail->Password   = SMTP_PASS;
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS; // 'ssl'
    $mail->Port       = 465;
    // XAMPP trên Windows thường thiếu chứng chỉ CA -> tắt kiểm tra SSL (giống trong đề bài)
    $mail->SMTPOptions = [
        'ssl' => [
            'verify_peer'       => false,
            'verify_peer_name'  => false,
            'allow_self_signed' => true,
        ],
    ];
    $mail->setFrom(SMTP_USER, SMTP_NAME);
    $mail->isHTML(true);
    return $mail;
}
