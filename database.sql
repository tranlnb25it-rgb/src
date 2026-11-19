-- CSDL cho Bài 3: danh sách người nhận email
CREATE DATABASE IF NOT EXISTS lab8_email CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE lab8_email;

CREATE TABLE IF NOT EXISTS nguoinhan (
    id    INT AUTO_INCREMENT PRIMARY KEY,
    ten   VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

INSERT IGNORE INTO nguoinhan (ten, email) VALUES
('Nguyễn Văn A', 'test1@test.com'),
('Trần Thị B',   'test2@test.com'),
('Lê Văn C',     'test3@test.com');
