package kr.ac.kopo.foodmall.service;

import java.util.List;

import kr.ac.kopo.foodmall.model.BasketJoin;
import kr.ac.kopo.foodmall.model.Product;

public interface BasketService {

	List<BasketJoin> list(String memberId);

	void add(String memberId, int productId);

	void delete(String memberId, int productId);

	int countBasket(String memberId);

	boolean check(String memberId, int pid);

	void listDelete(int[] pidArray, String memberId);

}
