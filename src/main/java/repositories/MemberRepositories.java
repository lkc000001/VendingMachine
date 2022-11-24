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
import util.ValidateUtil;

public class MemberRepositories {
	
	private Connection conn = new ConnectionDB().getConnection();
	
	public Member getMemberById(Long id) {
		String sql = "SELECT id, account, pwd, name, createtime, enabled, role FROM MEMBER WHERE id=?";
		Member member = new Member();
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1,id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				member.setId(rs.getLong("id"));
				member.setAccount(rs.getString("account"));
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEnabled(rs.getString("enabled"));
				member.setRole(rs.getString("role"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return member;
	}
	
	public Member getMemberByAccount(String account) {
		String sql = "SELECT id, account, pwd, name, createtime, enabled, role FROM MEMBER WHERE account=?";
		Member member = new Member();
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1,account);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				member.setId(rs.getLong("id"));
				member.setAccount(rs.getString("account"));
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEnabled(rs.getString("enabled"));
				member.setRole(rs.getString("role"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return member;
	}
	
	public String getMemberRole(String account) {
		String sql = "SELECT role FROM MEMBER WHERE account=? AND enabled=1";
		String role = "";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1,account);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				role = rs.getString("role");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return role;
	}
	
	public List<Member> queryMember(Member member, Page page) {
		StringBuilder sql = new StringBuilder("SELECT id, account, name, createtime, enabled, role FROM MEMBER ");
					  sql.append("WHERE 1=1");
					  if (ValidateUtil.isNotLongNone(member.getId())) {
						  sql.append(" AND id=" + member.getId());
					  }
					  if (ValidateUtil.isNotBlank(member.getAccount())) {
						  sql.append(" AND account LIKE '%" + member.getAccount() + "%'");
					  }
					  if (ValidateUtil.isNotBlank(member.getName())) {
						  sql.append(" AND name LIKE '%" + member.getName() + "%'");
					  }
					  if (ValidateUtil.isNotBlank(member.getEnabled())) {
						  sql.append(" AND enabled='" + member.getEnabled() + "'");
					  }
					  if (ValidateUtil.isNotBlank(member.getRole())) {
						  sql.append(" AND role='" + member.getRole() + "'");
					  }
					  sql.append(" ORDER BY id DESC ");
					  sql.append(" OFFSET (" + page.getPageIndex() + "-1) * " + page.getPageSize() + " ROWS ");
					  sql.append(" FETCH NEXT " + page.getPageSize() + " ROWS ONLY ");
					  
		List<Member> Members = new ArrayList<>();
		try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
			ResultSet rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next()) {
				Member dbMember = new Member();
				dbMember.setId(rs.getLong("id"));
				dbMember.setAccount(rs.getString("account"));
				//member.setPwd(rs.getString("pwd"));
				dbMember.setName(rs.getString("name"));
				dbMember.setCreatetime(rs.getDate("createtime"));
				String isEnabled = rs.getString("enabled");
				dbMember.setEnabled(isEnabled.equals("1") ? "啟用" : "未啟用");
				dbMember.setRole(getRoleName(rs.getString("role")));
				Members.add(dbMember);
				
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return Members;
	}
	
	public int addMember(Member member) {
		String sql = "INSERT INTO MEMBER (account, pwd, name, createtime, enabled, role) " +
					 "VALUES (?, ?, ?, ?, ?, ?)";
		Timestamp sqlDate = new Timestamp(new java.util.Date().getTime());
		int rowcount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, member.getAccount());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, sqlDate);
			pstmt.setString(5, member.getEnabled());
			pstmt.setString(6, member.getRole());
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	public int updateMember(Member member) {
		String sql = "UPDATE MEMBER SET name=?, enabled=?, role=? WHERE id=?" ;		 
		int rowcount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getEnabled());
			pstmt.setString(3, member.getRole());
			pstmt.setLong(4, member.getId());
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	public int deleteMember(Long id) {
		String sql = "DELETE FROM MEMBER WHERE id=?";
		int rowcount = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setLong(1, id);
			rowcount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return rowcount;
	}
	
	private String getRoleName(String role) {
		if(role == null) {
			return "使用者";
		}
		switch (role) {
		case "1":
			return "使用者";
		case "8":
			return "系統人員";
		case "9":
			return "系統管理員";
		}
		return "使用者";
	}
	
	public int count() {
		String sql = "SELECT COUNT(id) AS totalcount FROM MEMBER ";
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
