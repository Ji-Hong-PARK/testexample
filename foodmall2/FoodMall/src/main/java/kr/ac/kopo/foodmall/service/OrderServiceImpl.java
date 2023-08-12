package kr.ac.kopo.foodmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.kopo.foodmall.dao.BasketDao;
import kr.ac.kopo.foodmall.dao.MemberDao;
import kr.ac.kopo.foodmall.dao.OrderDao;
import kr.ac.kopo.foodmall.dao.ProductDao;
import kr.ac.kopo.foodmall.model.OrderDetail;
import kr.ac.kopo.foodmall.model.OrderInfo;
import kr.ac.kopo.foodmall.util.Pager;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDao dao;
	
	@Autowired
	BasketDao basketDao;
	
	@Autowired
	ProductDao productDao;
	
	@Autowired
	MemberDao memberDao;

	@Override
	public void addOrderInfo(OrderInfo orderInfo) {
		dao.addOrderInfo(orderInfo);
		memberDao.updateMileage(orderInfo.getMemberId(), orderInfo.getUseMileage());
	}

	@Override
	@Transactional
	public void addOrderDetail(List<OrderDetail> orderDetailList, String memberId) {
		for(OrderDetail item : orderDetailList) {
			int productId = item.getProductId();
			int orderCount = item.getCount();
			// orderDetail �߰�
			dao.addOrderDetail(item);
			// ��ٱ����� �ش� ��ǰ ����
			basketDao.delete(memberId, productId);
			// ��ǰ�� ��� �ݿ� �� �Ǹŷ� �ݿ� (���� ���� �Ǹŷ��� ���Ѵ�)
			productDao.updateSales(productId, orderCount);
		}
	}

	@Override
	public OrderInfo orderInfoItem(int orderId) {
		return dao.orderInfoItem(orderId);
	}

	@Override
	public List<OrderDetail> orderDetailList(int orderId) {
		return dao.orderDetailList(orderId);
	}

	@Override
	public List<OrderInfo> orderInfoList(Pager pager) {
		int total = dao.total(pager);
		
		pager.setTotal((float)total);
		
		return dao.orderInfoList(pager);
	}

	@Override
	public void orderInfoUpdate(OrderInfo item) {
		dao.orderInfoUpdate(item);
	}

	@Override
	public List<OrderInfo> userOrderList(String memberId) {
		return dao.userOrderList(memberId);
	}


}
