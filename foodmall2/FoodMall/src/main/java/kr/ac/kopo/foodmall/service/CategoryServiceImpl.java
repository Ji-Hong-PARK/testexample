package kr.ac.kopo.foodmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.foodmall.dao.CategoryDao;
import kr.ac.kopo.foodmall.model.Category;


@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	CategoryDao dao;
	
	@Override
	public List<Category> list() {
		return dao.list();
	}

	@Override
	public void add(Category item) {
		dao.add(item);
	}

	@Override
	public Category item(int categoryId) {
		return dao.item(categoryId);
	}

	@Override
	public void update(Category item) {
		dao.update(item);
	}

	@Override
	public void delete(int categoryId) {
		dao.delete(categoryId);
	}

}
