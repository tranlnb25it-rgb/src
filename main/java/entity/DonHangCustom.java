package entity;

import java.sql.Timestamp;

public class DonHangCustom {
    private int maDonHang;
    private Timestamp ngayDat;
    private double tongTien;
    private String tenDonHang;
    private String trangThaiDonHang;

    // Constructor đầy đủ tham số
    public DonHangCustom(int maDonHang, Timestamp ngayDat, double tongTien, String tenDonHang, String trangThaiDonHang) {
        this.maDonHang = maDonHang;
        this.ngayDat = ngayDat;
        this.tongTien = tongTien;
        this.tenDonHang = tenDonHang;
        this.trangThaiDonHang = trangThaiDonHang;
    }

    // Getter (Để JSP có thể lấy dữ liệu ra hiển thị)
    public int getMaDonHang() { return maDonHang; }
    public Timestamp getNgayDat() { return ngayDat; }
    public double getTongTien() { return tongTien; }
    public String getTenDonHang() { return tenDonHang; }
    public String getTrangThaiDonHang() { return trangThaiDonHang; }
}