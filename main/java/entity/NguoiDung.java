package entity;

import java.util.Date;
import java.util.Calendar;

public class NguoiDung {
    private int maNguoiDung;
    private String tenDangNhap;
    private String matKhau;
    private String hoTen;
    private String soDienThoai;
    private String vaiTro;
    private double tongChiTieu;
    private String voucherHienCo;
    private int diemTichLuy;
    private String capDo;
    private Date ngaySinh; // Đã có sẵn, giờ mình thêm vào Constructor

    // Constructor không tham số
    public NguoiDung() {
    }

    // Constructor đầy đủ tham số (Đã cập nhật thêm ngaySinh)
    public NguoiDung(int maNguoiDung, String tenDangNhap, String matKhau, String hoTen, String soDienThoai,
                     String vaiTro, double tongChiTieu, String voucherHienCo, int diemTichLuy,
                     String capDo, Date ngaySinh) {
        this.maNguoiDung = maNguoiDung;
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.soDienThoai = soDienThoai;
        this.vaiTro = vaiTro;
        this.tongChiTieu = tongChiTieu;
        this.voucherHienCo = voucherHienCo;
        this.diemTichLuy = diemTichLuy;
        this.capDo = capDo;
        this.ngaySinh = ngaySinh;
    }

    // Hàm bổ trợ: Kiểm tra xem hôm nay có phải sinh nhật cư dân không
    public boolean isCheckBirthday() {
        if (ngaySinh == null) return false;

        Calendar calToday = Calendar.getInstance();
        Calendar calDob = Calendar.getInstance();
        calDob.setTime(ngaySinh);

        // So sánh tháng và ngày (tháng trong Calendar bắt đầu từ 0)
        return calToday.get(Calendar.MONTH) == calDob.get(Calendar.MONTH) &&
                calToday.get(Calendar.DAY_OF_MONTH) == calDob.get(Calendar.DAY_OF_MONTH);
    }

    // Getter và Setter cho ngaySinh
    public Date getNgaySinh() { return ngaySinh; }
    public void setNgaySinh(Date ngaySinh) { this.ngaySinh = ngaySinh; }

    // Các Getter và Setter cũ
    public int getMaNguoiDung() { return maNguoiDung; }
    public void setMaNguoiDung(int maNguoiDung) { this.maNguoiDung = maNguoiDung; }

    public String getTenDangNhap() { return tenDangNhap; }
    public void setTenDangNhap(String tenDangNhap) { this.tenDangNhap = tenDangNhap; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }

    public double getTongChiTieu() { return tongChiTieu; }
    public void setTongChiTieu(double tongChiTieu) { this.tongChiTieu = tongChiTieu; }

    public String getVoucherHienCo() { return voucherHienCo; }
    public void setVoucherHienCo(String voucherHienCo) { this.voucherHienCo = voucherHienCo; }

    public int getDiemTichLuy() { return diemTichLuy; }
    public void setDiemTichLuy(int diemTichLuy) { this.diemTichLuy = diemTichLuy; }

    public String getCapDo() { return capDo; }
    public void setCapDo(String capDo) { this.capDo = capDo; }

    @Override
    public String toString() {
        return "NguoiDung{" + "hoTen=" + hoTen + ", vaiTro=" + vaiTro + ", ngaySinh=" + ngaySinh + '}';
    }
}