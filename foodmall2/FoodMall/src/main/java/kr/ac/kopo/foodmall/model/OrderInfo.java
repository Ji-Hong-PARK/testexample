package kr.ac.kopo.foodmall.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class OrderInfo {
	private int orderId;
	private String memberId;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date orderDate;
	
	private String destination;
	private String pay;
	private int sumPriceLast;
	private int sumMileageLast;
	private int state;
	private int useMileage;
	
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public int getSumPriceLast() {
		return sumPriceLast;
	}
	public void setSumPriceLast(int sumPriceLast) {
		this.sumPriceLast = sumPriceLast;
	}
	public int getSumMileageLast() {
		return sumMileageLast;
	}
	public void setSumMileageLast(int sumMileageLast) {
		this.sumMileageLast = sumMileageLast;
	}
	public int getUseMileage() {
		return useMileage;
	}
	public void setUseMileage(int useMileage) {
		this.useMileage = useMileage;
	}


	
}
