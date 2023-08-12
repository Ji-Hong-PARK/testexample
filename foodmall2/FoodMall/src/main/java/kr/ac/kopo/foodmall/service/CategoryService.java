package kr.ac.kopo.foodmall.service;

import java.util.List;

import kr.ac.kopo.foodmall.model.Category;

public interface CategoryService {

	List<Category> list();

	void add(Category item);

	Category item(int categoryId);

	void update(Category item);

	void delete(int categoryId);

}
