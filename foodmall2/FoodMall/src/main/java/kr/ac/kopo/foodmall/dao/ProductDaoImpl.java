package kr.ac.kopo.foodmall.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.util.Pager;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	SqlSession sql;
	
	@Override
	public List<Product> list(Pager pager) {	
		return sql.selectList("product.list", pager);
		
	}
	
	@Override
	public List<Product> mainList() {
		return sql.selectList("product.mainList");
	}
	
	@Override
	public void add(Product item) {
		sql.insert("product.add", item);
	}

	@Override
	public Product item(int productId) {
		return sql.selectOne("product.item", productId);
	}

	@Override
	public void update(Product item) {
		sql.update("product.update", item);
	}
	
	@Override
	public void noUploadUpdate(Product item) {
		sql.update("product.noUploadUpdate", item);
	}

	@Override
	public void delete(int productId) {
		sql.delete("product.delete", productId);
	}

	@Override
	public int total(Pager pager) {
		return sql.selectOne("product.total", pager);
	}

	@Override
	public void updateSales(int productId, int orderCount) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("productId", productId);
		map.put("orderCount", orderCount);
		
		sql.update("product.updateSales", map);
	}

	@Override
	public List<Product> cookieList(String[] pidList) {
	
		return sql.selectList("product.cookieList", pidList);
	}

}
