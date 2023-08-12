package kr.ac.kopo.foodmall.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.foodmall.dao.ProductDao;
import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.util.Pager;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDao dao;
	
	@Override
	public List<Product> list(Pager pager) {
		// 카테고리 선택 없이 모든 상품 검색
		int total = dao.total(pager);
		
		pager.setTotal((float)total);
		
		return dao.list(pager);	
	}
	
	// 카테고리 선택 >> 카테고리에 해당하는 상품 리스트
	@Override
	public List<Product> list(int categoryId, Pager pager) {
		pager.setCategoryId(categoryId);
		
		int total = dao.total(pager);
		pager.setTotal((float)total);
		return dao.list(pager);
	}
	
	// 주문 페이지에 띄워줄 list 메소드
	@Override
	public List<Product> list(int[] items) {
		List<Product> list = new ArrayList<Product>();
		
		for(int item : items) {
			list.add(dao.item(item));
		}
		
		return list;
	}
	
	// 메인페이지에 띄워줄 list (최근에 등록한 8개)
	@Override
	public List<Product> mainList() {
		return dao.mainList();
	}

	@Override
	public void add(Product item) {
		dao.add(item);
	}

	@Override
	public Product item(int productId) {
		return dao.item(productId);
	}

	@Override
	public void update(Product item) {
		dao.update(item);
	}

	@Override
	public void delete(int productId) {
		dao.delete(productId);
	}

	@Override
	public void noUploadUpdate(Product item) {
		dao.noUploadUpdate(item);
		
	}


	@Override
	public void dummy(int categoryId) {
		for(int index=1; index<100; index++) {
			Product item = new Product();
			
			item.setCategoryId(categoryId);
			item.setProductName("상품명 " + index);
			item.setImage("null");
			item.setPrice(5000);
			item.setMileage(50);
			item.setInventory(30);
			item.setProductInfo("info" + index);
			
			dao.add(item);
		}
		
	}

	@Override
	public List<Product> cookieList(String[] pidList) {
		return dao.cookieList(pidList);
	}

}
