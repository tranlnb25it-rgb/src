package context;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import java.sql.Connection;
import java.sql.DriverManager;

@SpringBootApplication
@ServletComponentScan(basePackages = {"control", "context"}) // Quét các Servlet trong gói control
public class DrinkShopApplication {
    public static void main(String[] args) {
        SpringApplication.run(DrinkShopApplication.class, args);
    }

    // Hàm kết nối chuẩn dùng jTDS giống như UserDAO của bạn
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("net.sourceforge.jtds.jdbc.Driver");
            // Đã sửa Port 14330 và Driver jTDS
            String url = "jdbc:jtds:sqlserver://localhost:14330/QuanLyBanDoUong";
            String user = "sa";
            String pass = "230323";
            conn = DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}