package kr.ac.kopo.foodmall.service;

import java.util.List;

import kr.ac.kopo.foodmall.model.OrderDetail;
import kr.ac.kopo.foodmall.model.OrderInfo;
import kr.ac.kopo.foodmall.util.Pager;

public interface OrderService {

	void addOrderInfo(OrderInfo orderInfo);

	void addOrderDetail(List<OrderDetail> orderDetailList, String memberId);

	OrderInfo orderInfoItem(int orderId);

	List<OrderDetail> orderDetailList(int orderId);

	List<OrderInfo> orderInfoList(Pager pager);

	void orderInfoUpdate(OrderInfo item);

	List<OrderInfo> userOrderList(String memberId);

}
