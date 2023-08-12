package kr.ac.kopo.foodmall.model;

public class Category {
	private int categoryId;
	private String categoryName;
	private char categoryState;
	
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public char getCategoryState() {
		return categoryState;
	}
	public void setCategoryState(char categoryState) {
		this.categoryState = categoryState;
	}
	
}
