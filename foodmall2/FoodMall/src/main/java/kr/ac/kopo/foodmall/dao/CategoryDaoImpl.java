package kr.ac.kopo.foodmall.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.foodmall.model.Category;

@Repository
public class CategoryDaoImpl implements CategoryDao {

	@Autowired
	SqlSession sql;
	
	@Override
	public List<Category> list() {
		return sql.selectList("category.list");
	}

	@Override
	public void add(Category item) {
		sql.insert("category.add", item);
	}

	@Override
	public Category item(int categoryId) {
		return sql.selectOne("category.item", categoryId);
	}

	@Override
	public void update(Category item) {
		sql.update("category.update", item);
	}

	@Override
	public void delete(int categoryId) {
		sql.delete("category.delete", categoryId);
	}

}
