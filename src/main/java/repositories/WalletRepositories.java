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
import entity.Wallet;
import util.ValidateUtil;

public class WalletRepositories {
	
	private Connection conn = new ConnectionDB().getConnection();
	
	public Wallet getWalletByMemberId(Long memberId) {
		String sql = "SELECT id, memberId, amount, createtime FROM WALLET WHERE memberId=?";
		Wallet wallet = new Wallet();
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1,memberId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				wallet.setId(rs.getLong("id"));
				wallet.setMemberId(rs.getLong("memberId"));
				wallet.setAmount(rs.getInt("amount"));
				wallet.setCreatetime(rs.getTimestamp("createtime"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return wallet;
	}
	
	public int getAmount(Long memberId) {
		String sql = "SELECT SUM(amount) AS amount FROM WALLET WHERE memberId=? ";
		int totalAmount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1,memberId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				totalAmount = rs.getInt("amount");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return totalAmount;
	}
	
	public List<Wallet> queryAmountList(Long memberId) {
		String sql = "SELECT amount, createtime FROM WALLET WHERE memberId=? AND amount > 0 ";
		List<Wallet> wallets = new ArrayList<Wallet>();
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1,memberId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Wallet wallet = new Wallet();
				wallet.setAmount(rs.getInt("amount"));
				wallet.setCreatetime(rs.getTimestamp("createtime"));
				wallets.add(wallet);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return wallets;
	}
	
	public int addWallet(Wallet wallet) {
		String sql = "INSERT INTO WALLET (memberId, amount, createtime) " +
					 "VALUES (?, ?, ?)";
		Timestamp sqlDate = new Timestamp(new java.util.Date().getTime());
		int rowcount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1, wallet.getMemberId());
			pstmt.setInt(2, wallet.getAmount());
			pstmt.setTimestamp(3, sqlDate);
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
}
