package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionDB {

	public static Connection getConnection() {
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
	
	public static Connection getMsSqlDBConnection() {
		Connection connection = null;
		try {
			Context ctx = new InitialContext();
			// Context loop JNDI DB Resource
			// 名稱須與 server.xml Resource name(jdbc/mySql) 相同
			DataSource dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/msSql");
			connection = dataSource.getConnection();			
		} catch (NamingException | SQLException e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	
}
