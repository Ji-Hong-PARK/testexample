package kr.ac.kopo.foodmall.dao;

import java.util.List;

import kr.ac.kopo.foodmall.model.OrderDetail;
import kr.ac.kopo.foodmall.model.OrderInfo;
import kr.ac.kopo.foodmall.util.Pager;

public interface OrderDao {

	void addOrderInfo(OrderInfo orderInfo);

	void addOrderDetail(OrderDetail item);

	OrderInfo orderInfoItem(int orderId);

	List<OrderDetail> orderDetailList(int orderId);

	List<OrderInfo> orderInfoList(Pager pager);

	int total(Pager pager);

	void orderInfoUpdate(OrderInfo item);

	List<OrderInfo> userOrderList(String memberId);


}
