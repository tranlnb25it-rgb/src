package entity;

public class QuaTang {
    private int maQua;
    private String tenQua;
    private int diemDoi;
    private String hinhAnh;
    private int soLuongCon;

    public QuaTang(int maQua, String tenQua, int diemDoi, String hinhAnh, int soLuongCon) {
        this.maQua = maQua;
        this.tenQua = tenQua;
        this.diemDoi = diemDoi;
        this.hinhAnh = hinhAnh;
        this.soLuongCon = soLuongCon;
    }

    // Getters cho JSP gọi ra
    public int getMaQua() { return maQua; }
    public String getTenQua() { return tenQua; }
    public int getDiemDoi() { return diemDoi; }
    public String getHinhAnh() { return hinhAnh; }
    public int getSoLuongCon() { return soLuongCon; }
}