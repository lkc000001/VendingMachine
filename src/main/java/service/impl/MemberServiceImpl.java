package service.impl;

import java.util.List;

import entity.Member;
import entity.Page;
import repositories.MemberRepositories;
import service.MemberService;

public class MemberServiceImpl implements MemberService {

	MemberRepositories memberRepositories = new MemberRepositories();
	
	@Override
	public Member getMemberById(Long id) {
		//AppUserRepositories appUserRepositories = new AppUserRepositories();
		return memberRepositories.getMemberById(id);
	}

	@Override
	public Member getMemberByAccount(String account) {
		return memberRepositories.getMemberByAccount(account);
	}

	@Override
	public String getMemberRole(String account) {
		return memberRepositories.getMemberRole(account);
	}
	
	@Override
	public List<Member> queryMember(Member member, Page page) {
		return memberRepositories.queryMember(member, page);
	}

	@Override
	public int addMember(Member member) {
		return memberRepositories.addMember(member);
	}

	@Override
	public int updateMember(Member member) {
		return memberRepositories.updateMember(member);
	}

	@Override
	public int deleteMember(Long id) {
		return memberRepositories.deleteMember(id);
	}

	@Override
	public int count() {
		return memberRepositories.count();
	}
}
