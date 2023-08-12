package kr.ac.kopo.foodmall.service;

import java.util.List;

import kr.ac.kopo.foodmall.model.Member;

public interface MemberService {

	List<Member> list();

	void add(Member item);

	Member item(String memberId);

	void update(Member item);

	void delete(String memberId);

	boolean checkId(String memberId);

}
