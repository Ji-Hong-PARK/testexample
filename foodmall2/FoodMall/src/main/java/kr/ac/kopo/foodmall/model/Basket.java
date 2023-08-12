package kr.ac.kopo.foodmall.model;

import java.util.Date;

public class Basket {
	private String memberId;
	private int productId;
	private int count;
	private Date basketDate;
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
	public Date getBasketDate() {
		return basketDate;
	}
	public void setBasketDate(Date basketDate) {
		this.basketDate = basketDate;
	}	

}
