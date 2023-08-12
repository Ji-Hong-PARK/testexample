package kr.ac.kopo.foodmall.service;

import java.util.List;

import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.util.Pager;

public interface ProductService {

	List<Product> list(Pager pager);

	void add(Product item);

	Product item(int productId);

	void update(Product item);

	void delete(int productId);

	void noUploadUpdate(Product item);

	void dummy(int categoryId);

	List<Product> list(int categoryId, Pager pager);

	List<Product> list(int[] items);

	List<Product> mainList();

	List<Product> cookieList(String[] pidList);

}
