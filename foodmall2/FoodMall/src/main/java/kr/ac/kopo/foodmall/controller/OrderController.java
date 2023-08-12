package kr.ac.kopo.foodmall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.ac.kopo.foodmall.model.Member;
import kr.ac.kopo.foodmall.model.OrderDetail;
import kr.ac.kopo.foodmall.model.OrderInfo;
import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.service.OrderService;
import kr.ac.kopo.foodmall.service.ProductService;

@Controller
public class OrderController {
	final String path = "/order";
	
	@Autowired
	OrderService service;
	
	@Autowired
	ProductService productService;
	
	@GetMapping("/order/list")
	public String userOrderList(@SessionAttribute Member member, Model model){
		List<OrderInfo> list = service.userOrderList(member.getMemberId());
		
		model.addAttribute("list", list);
		
		return path + "/list";
	}
	
	@ResponseBody
	@PostMapping("/order/confirm")
	public String confirm(@RequestBody Product[] list, HttpSession session) {
		List<Product> orderList = new ArrayList<Product>();
		
		for(Product i : list) {
			orderList.add(i);
		}
		session.setAttribute("orderList", orderList);
		
		return "success";
	}
	
	@GetMapping("/order/decide")
	public String decide(Model model, @SessionAttribute List<Product> orderList) {
		model.addAttribute("orderList", orderList);
		
		return path + "/decide";
	}
	
	@ResponseBody
	@PostMapping("/order/addOrderInfo")
	public OrderInfo addOrderInfo(@RequestBody OrderInfo orderInfo) {
		service.addOrderInfo(orderInfo);
		
		return orderInfo;
	}
	
	@ResponseBody
	@PostMapping("/order/addOrderDetail")
	public List<OrderDetail> addOrderDetail(@RequestBody OrderDetail[] list, @SessionAttribute Member member){
		List<OrderDetail> orderDetailList = new ArrayList<OrderDetail>();
		String memberId = member.getMemberId();
		
		for(OrderDetail i : list) {
			orderDetailList.add(i);
		}
		
		service.addOrderDetail(orderDetailList, memberId);
				
		return orderDetailList;
	}
	
	@GetMapping("/order/complete")
	public String complete(int orderId, Model model) {
		model.addAttribute("orderId", orderId);
		
		return path + "/complete";
	}
	
	@GetMapping("/order/viewDetail")
	public String viewDetail(int orderId, Model model) {
		OrderInfo order = service.orderInfoItem(orderId);
		List<OrderDetail> list = service.orderDetailList(orderId);
		
		model.addAttribute("order", order);
		model.addAttribute("list", list);
		
		return path + "/viewDetail";
	}
	
}
