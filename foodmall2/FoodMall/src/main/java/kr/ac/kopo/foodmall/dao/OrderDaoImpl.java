package kr.ac.kopo.foodmall.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.foodmall.model.OrderDetail;
import kr.ac.kopo.foodmall.model.OrderInfo;
import kr.ac.kopo.foodmall.util.Pager;

@Repository
public class OrderDaoImpl implements OrderDao {

	@Autowired
	SqlSession sql;

	@Override
	public void addOrderInfo(OrderInfo orderInfo) {
		sql.insert("order.addOrderInfo", orderInfo);
	}

	@Override
	public void addOrderDetail(OrderDetail item) {
		sql.insert("order.addOrderDetail", item);
	}

	@Override
	public OrderInfo orderInfoItem(int orderId) {
		return sql.selectOne("order.orderInfoItem", orderId);
	}

	@Override
	public List<OrderDetail> orderDetailList(int orderId) {
		return sql.selectList("order.orderDetailList", orderId);
	}

	@Override
	public List<OrderInfo> orderInfoList(Pager pager) {
		return sql.selectList("order.orderInfoList", pager);
	}

	@Override
	public int total(Pager pager) {

		return sql.selectOne("order.total", pager);
	}

	@Override
	public void orderInfoUpdate(OrderInfo item) {
		sql.update("order.orderInfoUpdate", item);
	}

	@Override
	public List<OrderInfo> userOrderList(String memberId) {
		return sql.selectList("order.userOrderList", memberId);	
	}
	
}
