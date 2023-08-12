package kr.ac.kopo.foodmall.dao;

import java.util.List;

import kr.ac.kopo.foodmall.model.BasketJoin;
import kr.ac.kopo.foodmall.model.Product;

public interface BasketDao {

	List<BasketJoin> productList(String memberId);

	void add(String memberId, int productId);

	void delete(String memberId, int productId);

	int countBasket(String memberId);

	int check(String memberId, int pid);

}
