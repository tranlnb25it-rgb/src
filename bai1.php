<?php
// BÀI 1. Gửi email cố định theo địa chỉ cho trước
require __DIR__ . '/config.php';

$to      = 'tranlnb.25it@vku.udn.vn';   // <-- sửa thành địa chỉ người nhận
$to_name = 'Người nhận';

$mail = taoMailer();
try {
    $mail->addAddress($to, $to_name);
    $mail->Subject = 'Gửi thư từ PHP';
    $mail->Body    = '<b>Chào bạn!</b><br>Chúc an lành!';
    $mail->AltBody = 'Chào bạn! Chúc an lành!';

    // Đính kèm file 4.jpg nếu có đặt trong thư mục lab_8
    if (file_exists(__DIR__ . '/4.jpg')) {
        $mail->addAttachment(__DIR__ . '/4.jpg', 'picture.jpg');
    }

    $mail->send();
    echo 'Đã gửi mail xong tới ' . htmlspecialchars($to);
} catch (Exception $e) {
    echo 'Mail không gửi được. Lỗi: ', $mail->ErrorInfo;
}
