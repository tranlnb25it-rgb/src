package model;

public class Product {
    private int id;           // Tương ứng cột MaSanPham
    private String name;      // Tương ứng cột TenSanPham
    private double price;     // Tương ứng cột GiaTien
    private String image;     // Tương ứng cột HinhAnh
    private String description; // Tương ứng cột MoTa
    private int categoryId;   // Tương ứng cột MaDanhMuc

    // 1. Constructor không tham số (Bắt buộc phải có)
    public Product() {
    }

    // 2. Constructor có đầy đủ tham số để khởi tạo nhanh
    public Product(int id, String name, double price, String image, String description, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.description = description;
        this.categoryId = categoryId;
    }

    // 3. Getter và Setter (Để các lớp khác có thể truy cập dữ liệu)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    // 4. Hàm toString để bạn có thể in ra kiểm tra (Debug)
    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", price=" + price + "]";
    }
}