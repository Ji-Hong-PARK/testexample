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
		// ī�װ� ���� ���� ��� ��ǰ �˻�
		int total = dao.total(pager);
		
		pager.setTotal((float)total);
		
		return dao.list(pager);	
	}
	
	// ī�װ� ���� >> ī�װ��� �ش��ϴ� ��ǰ ����Ʈ
	@Override
	public List<Product> list(int categoryId, Pager pager) {
		pager.setCategoryId(categoryId);
		
		int total = dao.total(pager);
		pager.setTotal((float)total);
		return dao.list(pager);
	}
	
	// �ֹ� �������� ����� list �޼ҵ�
	@Override
	public List<Product> list(int[] items) {
		List<Product> list = new ArrayList<Product>();
		
		for(int item : items) {
			list.add(dao.item(item));
		}
		
		return list;
	}
	
	// ������������ ����� list (�ֱٿ� ����� 8��)
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
			item.setProductName("��ǰ�� " + index);
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
