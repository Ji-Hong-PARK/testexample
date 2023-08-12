package kr.ac.kopo.foodmall.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.kopo.foodmall.dao.BasketDao;
import kr.ac.kopo.foodmall.dao.ProductDao;
import kr.ac.kopo.foodmall.model.BasketJoin;
import kr.ac.kopo.foodmall.model.Product;

@Service
public class BasketServiceImpl implements BasketService {

	@Autowired
	BasketDao dao;
	
	@Autowired
	ProductDao productDao;
	
	@Override
	public List<BasketJoin> list(String memberId) {

		List<BasketJoin> list = dao.productList(memberId);
		
		return list;
	}

	@Override
	public void add(String memberId, int productId) {
		dao.add(memberId, productId);
	}

	@Override
	public boolean check(String memberId, int pid) {
		int count = dao.check(memberId, pid);
		
		// return true=장바구니에 없음 / false=있음
		if(count>0) {
			//장바구니에 상품이 이미 있다
			return false;
		}else {
			return true;
		}
		
	}
	
	@Override
	public void delete(String memberId, int productId) {
		dao.delete(memberId, productId);

	}

	@Override
	public int countBasket(String memberId) {
		return dao.countBasket(memberId);
	}

	@Override
	@Transactional
	public void listDelete(int[] pidArray, String memberId) {
		for(int pid : pidArray) {
			dao.delete(memberId, pid);
		}
	}

}
