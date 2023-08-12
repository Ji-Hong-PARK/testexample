package kr.ac.kopo.foodmall.model;


public class OrderDetail {
	private int orderId;
	private int productId;
	private int count;
	private int sumPrice;
	private int sumMileage;
	private int categoryId;
	
	// �ֹ����� Ȯ���� ���� �������ǹ����� ������ �Ķ����, �ֹ� ��Ͽ����� ������ �ʴ´�.
	private String image;
	private String productName;
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getSumPrice() {
		return sumPrice;
	}
	public void setSumPrice(int sumPrice) {
		this.sumPrice = sumPrice;
	}
	public int getSumMileage() {
		return sumMileage;
	}
	public void setSumMileage(int sumMileage) {
		this.sumMileage = sumMileage;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}


}
