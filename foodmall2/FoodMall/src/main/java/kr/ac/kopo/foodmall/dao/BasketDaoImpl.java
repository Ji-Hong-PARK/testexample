package kr.ac.kopo.foodmall.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.foodmall.model.BasketJoin;

@Repository
public class BasketDaoImpl implements BasketDao {

	@Autowired
	SqlSession sql;
	
	@Override
	public List<BasketJoin> productList(String memberId) {
		return sql.selectList("basket.list", memberId);
	}

	@Override
	public void add(String memberId, int productId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("productId", productId);
		
		sql.insert("basket.add", map);
	}

	@Override
	public void delete(String memberId, int productId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("memberId", memberId);
		map.put("productId", productId);

		sql.delete("basket.delete", map);
	}

	@Override
	public int countBasket(String memberId) {
		return sql.selectOne("basket.count", memberId);
	}

	@Override
	public int check(String memberId, int pid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("productId", pid);
		
		return sql.selectOne("basket.check", map);
	}

}
