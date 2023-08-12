package kr.ac.kopo.foodmall.dao;

import java.util.List;

import kr.ac.kopo.foodmall.model.Category;

public interface CategoryDao {

	List<Category> list();

	void add(Category item);

	Category item(int categoryId);

	void update(Category item);

	void delete(int categoryId);

}
