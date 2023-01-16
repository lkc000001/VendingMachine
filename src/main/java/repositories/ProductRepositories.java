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
import entity.Page;
import entity.Product;
import entity.ShoppingCart;
import util.ValidateUtil;

public class ProductRepositories {
	
	private Connection conn = ConnectionDB.getMsSqlDBConnection();
	
	public Product getProductById(Long id) {
		String sql = "SELECT id, name, price, cost, stock, unit, classify, image, createtime, enabled FROM PRODUCT WHERE id=?";
		Product product = new Product();
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1,id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				product.setId(rs.getLong("id"));
				product.setName(rs.getString("name"));
				product.setPrice(rs.getInt("price"));
				product.setCost(rs.getInt("cost"));
				product.setStock(rs.getInt("stock"));
				product.setUnit(rs.getString("unit"));
				product.setImage(rs.getString("image"));
				product.setClassify(rs.getString("classify"));
				product.setCreatetime(rs.getTimestamp("createtime"));
				String isEnabled = rs.getString("enabled");
				product.setEnabled(isEnabled.equals("1") ? "啟用" : "未啟用");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return product;
	}
	
	public List<Product> queryProduct(Product product, Page page) {
		StringBuilder sql = new StringBuilder("SELECT id, name, price, cost, stock, unit, classify, image, createtime, enabled FROM PRODUCT ");
					  sql.append("WHERE 1=1");
					  if (ValidateUtil.isNotLongNone(product.getId())) {
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
					  }
					  sql.append(" ORDER BY id DESC ");
					  sql.append(" OFFSET (" + page.getPageIndex() + "-1) * " + page.getPageSize() + " ROWS ");
					  sql.append(" FETCH NEXT " + page.getPageSize() + " ROWS ONLY ");
					  
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
	
	public int addProduct(Product product) {
		String sql = "INSERT INTO PRODUCT (name, price, cost, stock, unit, classify, image, createtime, enabled) " +
					 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Timestamp sqlDate = new Timestamp(new java.util.Date().getTime());
		int rowcount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, product.getName());
			pstmt.setInt(2, product.getPrice());
			pstmt.setInt(3, product.getCost());
			pstmt.setInt(4, product.getStock());
			pstmt.setString(5, product.getUnit());
			pstmt.setString(6, product.getClassify());
			pstmt.setString(7, product.getImage());
			pstmt.setTimestamp(8, sqlDate);
			pstmt.setString(9, product.getEnabled());
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	public int updateProduct(Product product) {
		String sql = "UPDATE PRODUCT SET name=?, price=?, cost=?, stock=?, unit=?, classify=?, image=?, enabled=? WHERE id=?" ;		 
		int rowcount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, product.getName());
			pstmt.setInt(2, product.getPrice());
			pstmt.setInt(3, product.getCost());
			pstmt.setInt(4, product.getStock());
			pstmt.setString(5, product.getUnit());
			pstmt.setString(6, product.getClassify());
			pstmt.setString(7, product.getImage());
			pstmt.setString(8, product.getEnabled());
			pstmt.setLong(9, product.getId());
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	public int updateStock(ShoppingCart shoppingCarts) {
		String sql = "UPDATE PRODUCT SET stock=? WHERE id=?";
		Product product = getProductById(shoppingCarts.getProductId());
		int rowcount = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, product.getStock() - shoppingCarts.getBuyQuantity());
			pstmt.setLong(2, shoppingCarts.getProductId());
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	public int deleteProduct(Long id) {
		String sql = "DELETE FROM PRODUCT WHERE id=?";
		int rowcount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1, id);
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	public int addStock(Product product) {
		String sql = "UPDATE PRODUCT SET cost=?, stock=? WHERE id=?" ;	
		Timestamp sqlDate = new Timestamp(new java.util.Date().getTime());
		int rowcount = 0;
		int cost =  getProductById(product.getId()).getCost();
		int stock =  getProductById(product.getId()).getStock();
		int newCost = (product.getCost() + cost) / 2;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, product.getStock() + stock);
			pstmt.setInt(2, newCost);
			pstmt.setLong(3, product.getId());
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	public int count(boolean isEnable) {
		String sql = "SELECT COUNT(id) AS totalcount FROM PRODUCT ";
		if(isEnable) {
			sql = "SELECT COUNT(id) AS totalcount FROM PRODUCT WHERE enabled=1";
		} 
		
		int totalCount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt("totalcount");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return totalCount;
	}
}
