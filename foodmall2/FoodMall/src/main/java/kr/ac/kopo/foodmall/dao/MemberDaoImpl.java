package kr.ac.kopo.foodmall.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.foodmall.model.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	SqlSession sql;
	
	@Override
	public List<Member> list() {
		return sql.selectList("member.list");
	}

	@Override
	public void add(Member item) {
		sql.insert("member.add", item);
	}

	@Override
	public Member item(String memberId) {
		return sql.selectOne("member.item", memberId);
	}

	@Override
	public void update(Member item) {
		sql.update("member.update", item);
	}

	@Override
	public void delete(String memberId) {
		sql.delete("member.delete", memberId);
	}

	@Override
	public int checkId(String memberId) {
		return sql.selectOne("member.checkId", memberId);
	}

	@Override
	public void updateMileage(String memberId, int useMileage) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("useMileage", useMileage);
		
		sql.update("updateMileage", map);
	}

}
