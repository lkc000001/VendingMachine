package service;

import java.util.List;

import entity.Member;
import entity.Page;

public interface MemberService {
	
	Member getMemberById(Long id);
	
	Member getMemberByAccount(String account);
	
	String getMemberRole(String account);
	
	List<Member> queryMember(Member member, Page page);
	
	int addMember(Member member);
	
	int updateMember(Member member);
	
	int deleteMember(Long id);
	
	int count();
}
