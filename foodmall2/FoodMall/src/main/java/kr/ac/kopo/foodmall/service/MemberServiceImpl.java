package kr.ac.kopo.foodmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.foodmall.dao.MemberDao;
import kr.ac.kopo.foodmall.model.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao dao;
	
	@Override
	public List<Member> list() {
		return dao.list();
	}

	@Override
	public void add(Member item) {
		dao.add(item);
	}

	@Override
	public Member item(String memberId) {
		return dao.item(memberId);
	}

	@Override
	public void update(Member item) {
		dao.update(item);
	}

	@Override
	public void delete(String memberId) {
		dao.delete(memberId);
	}

	@Override
	public boolean checkId(String memberId) {
		if(dao.checkId(memberId) > 0)
			return false;
		else
			return true;
	}

}
