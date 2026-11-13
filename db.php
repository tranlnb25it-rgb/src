
<?php
// Thông tin kết nối database
$host = 'localhost';
$user = 'root';
$pass = '';
$dbname = 'QLNhanSu';

// Kết nối đến MySQL
$conn = mysqli_connect($host, $user, $pass, $dbname);

// Kiểm tra kết nối
if (!$conn) {
    die("Kết nối thất bại: " . mysqli_connect_error());
}

// Thiết lập bảng mã UTF-8
mysqli_set_charset($conn, 'utf8mb4');

?>
