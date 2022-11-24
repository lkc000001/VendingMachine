package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionDB {

	public Connection getConnection() {
		String connectionUrl =
                "jdbc:sqlserver://127.0.0.1:1433;"
                        + "database=VENDINGMACHINE;"
                        + "user=tommy;"
                        + "password=12345678;";
			// 資料庫連線物件
			Connection conn = null;
			try {
				// 建立資料庫 driver
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				conn = DriverManager.getConnection(connectionUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
