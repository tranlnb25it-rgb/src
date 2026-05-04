package dao; // Trân nhớ đổi lại tên package cho đúng với dự án của bạn nhé

import context.DrinkShopApplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class KhuyenMaiDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Hàm 1: Lưu mã khi cư dân nhấn "Dùng ngay"
    public void saveUsedOffer(int userId, String offerCode) {
        String query = "INSERT INTO SuDungKhuyenMai (MaNguoiDung, MaKhuyenMai) VALUES (?, ?)";
        try {
            conn = new DrinkShopApplication().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, offerCode);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(); // Đóng kết nối sau khi dùng xong
        }
    }

    // Hàm 2: Lấy danh sách các mã đã dùng để ẩn đi
    public List<String> getUsedOffers(int userId) {
        List<String> list = new ArrayList<>();
        String query = "SELECT MaKhuyenMai FROM SuDungKhuyenMai WHERE MaNguoiDung = ?";
        try {
            conn = new DrinkShopApplication().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("MaKhuyenMai"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    // Hàm phụ để đóng kết nối cho gọn code
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}