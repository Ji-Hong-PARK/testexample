package kr.ac.kopo.foodmall.dao;

import java.util.List;

import kr.ac.kopo.foodmall.model.Member;

public interface MemberDao {

	List<Member> list();

	void add(Member item);

	Member item(String memberId);

	void update(Member item);

	void delete(String memberId);

	int checkId(String memberId);

	void updateMileage(String memberId, int useMileage);

}
