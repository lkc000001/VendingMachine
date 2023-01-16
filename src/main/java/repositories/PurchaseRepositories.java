package repositories;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import config.ConnectionDB;
import entity.Member;
import entity.Product;
import entity.Purchase;
import entity.ShoppingCart;
import util.ValidateUtil;

public class PurchaseRepositories {
	
	private Connection conn = ConnectionDB.getMsSqlDBConnection();
	
	public List<Product> queryPurchase(Purchase purchase) {
		StringBuilder sql = new StringBuilder("SELECT id, name, price, cost, stock, unit, classify, image, createtime, enabled FROM PRODUCT ");
					  sql.append("WHERE 1=1");
					  /*if (ValidateUtil.isNotLongNone(product.getId())) {
						  sql.append(" AND id=" + product.getId());
					  }
					  if (ValidateUtil.isNotBlank(product.getName())) {
						  sql.append(" AND name LIKE '%" + product.getName() + "%'");
					  }
					  if (ValidateUtil.isNotBlank(product.getClassify())) {
						  sql.append(" AND classify LIKE '%" + product.getClassify() + "%'");
					  }
					  if (ValidateUtil.isNotBlank(product.getEnabled())) {
						  sql.append(" AND enabled='" + product.getEnabled() + "'");
					  }*/
					  
		List<Product> products = new ArrayList<>();
		try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
			ResultSet rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next()) {
				Product dbProduct = new Product();
				dbProduct.setId(rs.getLong("id"));
				dbProduct.setName(rs.getString("name"));
				dbProduct.setPrice(rs.getInt("price"));
				dbProduct.setCost(rs.getInt("cost"));
				dbProduct.setStock(rs.getInt("stock"));
				dbProduct.setUnit(rs.getString("unit"));
				dbProduct.setImage(rs.getString("image"));
				dbProduct.setClassify(rs.getString("classify"));
				dbProduct.setCreatetime(rs.getTimestamp("createtime"));
				String isEnabled = rs.getString("enabled");
				dbProduct.setEnabled(isEnabled.equals("1") ? "啟用" : "未啟用");
				products.add(dbProduct);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return products;
	}
	
	public int addPurchase(Purchase purchase) {
		String sql = "INSERT INTO PURCHASE (productId, productCost, quantity, createtime ) " +
					 "VALUES (?, ?, ?, ?) ";
		Timestamp sqlDate = new Timestamp(new java.util.Date().getTime());
		int rowcount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1, purchase.getProductId());
			pstmt.setInt(2, purchase.getProductCost());
			pstmt.setInt(3, purchase.getQuantity());
			pstmt.setTimestamp(4, sqlDate);
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
}
