package repositories;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import config.ConnectionDB;
import entity.Member;
import entity.Page;
import entity.Product;
import entity.ShoppingCart;
import entity.Wallet;
import util.DateTimtUtil;
import util.ValidateUtil;

public class ShoppingCartRepositories {
	
	private Connection conn = new ConnectionDB().getConnection();
	
	private DateTimtUtil dateTimtUtil = new DateTimtUtil();
	
	public List<ShoppingCart> queryShoppingCart(ShoppingCart shoppingCart, Page page) {
		StringBuilder sql = new StringBuilder();
			sql.append("SELECT s.orderid, s.memberId, s.productId, s.productPrice, s.productCost, s.buyQuantity, s.createtime, ");
			sql.append("p.name ");
			sql.append("FROM SHOPPINGCART s, PRODUCT p ");
			sql.append("WHERE s.productId=p.id ");
					  if (ValidateUtil.isNotLongNone(shoppingCart.getProductId())) {
						  sql.append(" AND s.productId=" + shoppingCart.getProductId());
					  }
					  if (ValidateUtil.isNotLongNone(shoppingCart.getMemberId())) {
						  sql.append(" AND s.memberId=" + shoppingCart.getMemberId());
					  }
					  if (ValidateUtil.isNotEmpty(shoppingCart.getStartDate())) {
						  sql.append(" AND s.createtime >= " + shoppingCart.getStartDate());
					  }
					  if (ValidateUtil.isNotEmpty(shoppingCart.getEndDate())) {
						  sql.append(" AND s.createtime <= " + shoppingCart.getEndDate());
					  }
			sql.append(" ORDER BY s.id DESC ");
			sql.append(" OFFSET (" + page.getPageIndex() + "-1) * " + page.getPageSize() + " ROWS ");
			sql.append(" FETCH NEXT " + page.getPageSize() + " ROWS ONLY ");
			
	  List<ShoppingCart> shoppingCarts = new ArrayList<ShoppingCart>();
		try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ShoppingCart dbshoppingCart = new ShoppingCart();
				dbshoppingCart.setOrderId(rs.getString("orderid"));
				dbshoppingCart.setMemberId(rs.getLong("memberId"));
				dbshoppingCart.setProductId(rs.getLong("productId"));
				int productPrice = rs.getInt("productPrice");
				dbshoppingCart.setProductPrice(productPrice);
				dbshoppingCart.setProductCost(rs.getInt("productCost"));
				int buyQuantity = rs.getInt("buyQuantity");
				dbshoppingCart.setBuyQuantity(buyQuantity);
				dbshoppingCart.setProductName(rs.getString("name"));
				dbshoppingCart.setTotal(productPrice * buyQuantity);
				dbshoppingCart.setCreatetime(rs.getTimestamp("createtime"));
				shoppingCarts.add(dbshoppingCart);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return shoppingCarts;
	}
	
	public List<ShoppingCart> queryShoppingList (Long memberId) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT s.orderid, s.memberId, s.productId, s.productPrice, s.productCost, s.buyQuantity, s.createtime, ");
		sql.append("p.name ");
		sql.append("FROM SHOPPINGCART s, PRODUCT p ");
		sql.append("WHERE s.memberId=? AND s.productId=p.id ");
		sql.append("ORDER BY s.orderid ");
		
		List<ShoppingCart> shoppingCarts = new ArrayList<ShoppingCart>();
		try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
			pstmt.setLong(1,memberId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ShoppingCart shoppingCart = new ShoppingCart();
				shoppingCart.setOrderId(rs.getString("orderid"));
				shoppingCart.setMemberId(rs.getLong("memberId"));
				shoppingCart.setProductId(rs.getLong("productId"));
				int productPrice = rs.getInt("productPrice");
				shoppingCart.setProductPrice(productPrice);
				shoppingCart.setProductCost(rs.getInt("productCost"));
				int buyQuantity = rs.getInt("buyQuantity");
				shoppingCart.setBuyQuantity(buyQuantity);
				shoppingCart.setProductName(rs.getString("name"));
				shoppingCart.setTotal(productPrice * buyQuantity);
				shoppingCart.setCreatetime(rs.getTimestamp("createtime"));
				shoppingCarts.add(shoppingCart);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return shoppingCarts;
	}
	
	public String getMaxOrderId () {
		String sql = "SELECT MAX(RIGHT(orderid,4)) AS orderidmax FROM SHOPPINGCART WHERE LEFT(orderid,8) = ?";
		
		String dateStr = dateTimtUtil.getNowDateStr(1);
		int maxNumber = 1;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1,dateStr);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				maxNumber = rs.getInt("orderidmax");
			}
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return dateStr + String.format("%04d", maxNumber + 1);
	}
	
	public int addShoppingCarts(List<ShoppingCart> shoppingCarts, Long memberId) {
		Timestamp sqlDate = new Timestamp(new java.util.Date().getTime());
		int rowcount = 0;
		StringBuilder sql = new StringBuilder("INSERT INTO SHOPPINGCART ");
		sql.append("(orderid, memberId, productId, productPrice, productCost, buyQuantity, createtime) VALUES ");
		
		shoppingCarts.forEach(sc -> {
			sql.append(" (");
			sql.append(getMaxOrderId() + ", ");
			sql.append(memberId + ", ");
			sql.append(sc.getProductId() + ", ");
			sql.append(sc.getProductPrice() + ", ");
			sql.append(sc.getProductCost() + ", ");
			sql.append(sc.getBuyQuantity() + ", ");
			sql.append("'" + sqlDate + "' ), ");
		});		
		rowcount = shoppingCarts.size();
		try (PreparedStatement pstmt = conn.prepareStatement(sql.toString().substring(0, sql.length()-2))) {
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	public int count() {
		String sql = "SELECT COUNT(id) AS totalcount FROM SHOPPINGCART ";
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
