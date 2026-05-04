package dao;

import entity.DonHangCustom;
import entity.NguoiDung;
import model.Product;
import context.DrinkShopApplication;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {



    public Connection getConnection() throws Exception {
        Class.forName("net.sourceforge.jtds.jdbc.Driver");
        String url = "jdbc:jtds:sqlserver://localhost:14330/QuanLyBanDoUong";
        String user = "sa";
        String pass = "230323";
        return DriverManager.getConnection(url, user, pass);
    }

    // 2. Hàm Đăng ký (Đã thêm log kiểm tra)
    public void register(String user, String pass, String name, String phone) {
        // --- CODE CHECK GIỮA GIAO DIỆN VÀ DAO ---
        System.out.println(">>> DAO NHẬN DỮ LIỆU ĐĂNG KÝ:");
        System.out.println("    User: " + user);
        System.out.println("    Pass: " + pass);
        System.out.println("    Name: " + name);
        // ---------------------------------------

        String query = "INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, SoDienThoai, VaiTro) VALUES (?, ?, ?, ?, 'User')";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, name);
            ps.setString(4, phone);
            ps.executeUpdate();
            System.out.println(">>> KẾT QUẢ: Đã gửi lệnh INSERT vào SQL thành công.");
        } catch (Exception e) {
            System.err.println(">>> LỖI ĐĂNG KÝ: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM SanPham";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Product(rs.getInt("MaSanPham"), rs.getString("TenSanPham"),
                        rs.getDouble("GiaTien"), rs.getString("HinhAnh"),
                        rs.getString("MoTa"), rs.getInt("MaDanhMuc")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean insertFullOrder(int accountId, String dataCart, String summary) {
        System.out.println(">>> ĐANG GỌI LƯU ĐƠN: Account=" + accountId + " | Summary=" + summary);
        if (dataCart == null || dataCart.isEmpty()) return false;
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            double total = 0;
            String[] items = dataCart.split(";");
            for (String i : items) {
                String[] d = i.split(",");
                if (d.length >= 3) total += (Integer.parseInt(d[1]) * Double.parseDouble(d[2]));
            }
            String sqlOrder = "INSERT INTO DonHang (MaNguoiDung, NgayDat, TongTien, TenDonHang) VALUES (?, GETDATE(), ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, accountId);
            ps.setDouble(2, total);
            ps.setString(3, summary);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) orderId = rs.getInt(1);
            String sqlDetail = "INSERT INTO ChiTietDonHang (MaDonHang, MaSanPham, SoLuong, GiaLucMua) VALUES (?, ?, ?, ?)";
            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
            for (String i : items) {
                String[] d = i.split(",");
                if (d.length >= 3) {
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, Integer.parseInt(d[0]));
                    psDetail.setInt(3, Integer.parseInt(d[1]));
                    psDetail.setDouble(4, Double.parseDouble(d[2]));
                    psDetail.executeUpdate();
                }
            }
            String sqlUpdateSpend = "UPDATE NguoiDung SET tongChiTieu = tongChiTieu + ?, diemTichLuy = diemTichLuy + (? / 1000) WHERE MaNguoiDung = ?";            PreparedStatement psUpdate = conn.prepareStatement(sqlUpdateSpend);
            psUpdate.setDouble(1, total);
            psUpdate.setDouble(2, total); // Thêm dòng này để tính điểm từ tổng tiền đơn hàng
            psUpdate.setInt(3, accountId);
            psUpdate.executeUpdate();
            String sqlCheckLevel = "SELECT tongChiTieu FROM NguoiDung WHERE MaNguoiDung = ?";
            PreparedStatement psCheck = conn.prepareStatement(sqlCheckLevel);
            psCheck.setInt(1, accountId);
            ResultSet rsLevel = psCheck.executeQuery();
            if (rsLevel.next()) {
                double totalSpent = rsLevel.getDouble("tongChiTieu");
                String newLevel = "Hạt Mầm";
                if (totalSpent >= 3000000) newLevel = "Lâu Đài";
                else if (totalSpent >= 1500000) newLevel = "Cổ Thụ";
                else if (totalSpent >= 500000) newLevel = "Cành Lá";
                String sqlUpdateLevel = "UPDATE NguoiDung SET capDo = ? WHERE MaNguoiDung = ?";
                PreparedStatement psLevel = conn.prepareStatement(sqlUpdateLevel);
                psLevel.setString(1, newLevel);
                psLevel.setInt(2, accountId);
                psLevel.executeUpdate();
            }
            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) { try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } }
            e.printStackTrace();
        } finally {
            if (conn != null) { try { conn.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }
        return false;
    }

    // 5. Hàm Đăng nhập (Cập nhật logic hiện voucher trong 10 ngày)
    public NguoiDung login(String user, String pass) {
        String query = "SELECT * FROM NguoiDung WHERE TenDangNhap = ? AND MatKhau = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                NguoiDung n = new NguoiDung(
                        rs.getInt("MaNguoiDung"), rs.getString("TenDangNhap"),
                        rs.getString("MatKhau"), rs.getString("HoTen"),
                        rs.getString("SoDienThoai"), rs.getString("VaiTro"),
                        rs.getDouble("tongChiTieu"), rs.getString("voucherHienCo"),
                        rs.getInt("diemTichLuy"), rs.getString("capDo"),
                        rs.getDate("NgaySinh")
                );

                // --- LOGIC VOUCHER 10 NGÀY ---
                if (n.getNgaySinh() != null) {
                    // Lấy ngày tháng hiện tại
                    java.util.Calendar calToday = java.util.Calendar.getInstance();
                    int dayToday = calToday.get(java.util.Calendar.DAY_OF_YEAR);

                    // Lấy ngày tháng sinh nhật (nhưng tính theo năm hiện tại)
                    java.util.Calendar calBday = java.util.Calendar.getInstance();
                    calBday.setTime(n.getNgaySinh());
                    calBday.set(java.util.Calendar.YEAR, calToday.get(java.util.Calendar.YEAR));
                    int dayBday = calBday.get(java.util.Calendar.DAY_OF_YEAR);

                    // Nếu hôm nay nằm trong khoảng từ ngày sinh đến 10 ngày sau
                    if (dayToday >= dayBday && dayToday <= (dayBday + 10)) {
                        n.setVoucherHienCo("TRIWISDOM_HBD_20");
                        System.out.println(">>> ƯU ĐÃI: Cư dân đang trong tuần lễ sinh nhật!");
                    }
                }
                return n;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
    // Thêm đoạn này vào cuối class UserDAO
    public List<DonHangCustom> getOrderHistory(int accountId) {
        List<DonHangCustom> list = new ArrayList<>();
        // SQL này đã khớp với các cột: MaDonHang, NgayDat, TongTien, TenDonHang, TrangThaiDonHang trong DB của bạn
        String query = "SELECT MaDonHang, NgayDat, TongTien, TenDonHang, TrangThaiDonHang FROM DonHang WHERE MaNguoiDung = ? ORDER BY NgayDat DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new DonHangCustom(
                        rs.getInt("MaDonHang"),
                        rs.getTimestamp("NgayDat"),
                        rs.getDouble("TongTien"),
                        rs.getString("TenDonHang"),
                        rs.getString("TrangThaiDonHang")
                ));
            }
            System.out.println(">>> DAO: Đã tìm thấy " + list.size() + " đơn hàng cho cư dân ID " + accountId);
        } catch (Exception e) {
            System.err.println(">>> LỖI DAO khi lấy lịch sử đơn: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // 1. Lấy danh sách quà tặng
    public List<entity.QuaTang> getAllRewards() {
        List<entity.QuaTang> list = new ArrayList<>();
        String query = "SELECT * FROM QuaTang WHERE SoLuongCon > 0";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new entity.QuaTang(
                        rs.getInt("MaQua"), rs.getString("TenQua"),
                        rs.getInt("DiemDoi"), rs.getString("HinhAnh"),
                        rs.getInt("SoLuongCon")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. Xử lý đổi quà (Trừ điểm người dùng và trừ số lượng quà)
    public boolean redeemReward(int userId, int maQua, int diemDoi) {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // Trừ điểm của cư dân
            String sqlMinusPoint = "UPDATE NguoiDung SET diemTichLuy = diemTichLuy - ? WHERE MaNguoiDung = ? AND diemTichLuy >= ?";
            PreparedStatement ps1 = conn.prepareStatement(sqlMinusPoint);
            ps1.setInt(1, diemDoi);
            ps1.setInt(2, userId);
            ps1.setInt(3, diemDoi);
            int check1 = ps1.executeUpdate();

            // Trừ số lượng quà trong kho
            String sqlMinusStock = "UPDATE QuaTang SET SoLuongCon = SoLuongCon - 1 WHERE MaQua = ?";
            PreparedStatement ps2 = conn.prepareStatement(sqlMinusStock);
            ps2.setInt(1, maQua);
            int check2 = ps2.executeUpdate();

            if (check1 > 0 && check2 > 0) {
                conn.commit();
                return true;
            }
        } catch (Exception e) {
            try { if(conn != null) conn.rollback(); } catch(Exception ex) {}
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateAccount(int userId, String name, String phone, String pass) {
        String query = "UPDATE NguoiDung SET HoTen = ?, SoDienThoai = ?, MatKhau = ? WHERE MaNguoiDung = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, pass);
            ps.setInt(4, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public void register(String user, String pass, String name, Date dob, String phone) {
        // 1. Câu lệnh SQL phải khớp y hệt tên cột trong hình bạn gửi
        String query = "INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, NgaySinh, SoDienThoai, VaiTro, CapDo, TongChiTieu, DiemTichLuy) "
                + "VALUES (?, ?, ?, ?, ?, 'User', N'Hạt Mầm', 0, 0)";

        try (Connection conn = getConnection(); // Dùng getConnection() có sẵn trong DAO của bạn
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, name);
            ps.setDate(4, dob);
            ps.setString(5, phone);

            ps.executeUpdate();
            System.out.println(">>> Đăng ký thành công cư dân: " + user);

        } catch (Exception e) {
            System.err.println(">>> LỖI ĐĂNG KÝ: " + e.getMessage());
            e.printStackTrace();
        }
    }
}