package kr.ac.kopo.foodmall.dao;

import java.util.List;

import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.util.Pager;

public interface ProductDao {

	List<Product> list(Pager pager);

	void add(Product item);

	Product item(int productId);

	void update(Product item);

	void delete(int productId);

	void noUploadUpdate(Product item);

	int total(Pager pager);

	List<Product> mainList();

	void updateSales(int productId, int orderCount);

	List<Product> cookieList(String[] pidList);

}
