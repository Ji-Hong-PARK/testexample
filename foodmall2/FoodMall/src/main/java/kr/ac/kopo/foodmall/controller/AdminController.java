package kr.ac.kopo.foodmall.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.kopo.foodmall.model.Category;
import kr.ac.kopo.foodmall.model.OrderDetail;
import kr.ac.kopo.foodmall.model.OrderInfo;
import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.service.CategoryService;
import kr.ac.kopo.foodmall.service.OrderService;
import kr.ac.kopo.foodmall.service.ProductService;
import kr.ac.kopo.foodmall.util.Pager;
import kr.ac.kopo.foodmall.util.Uploader;

@RestController
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	OrderService orderService;
	
	@PutMapping("/order/update")
	public String orderInfoUpdate(@RequestBody OrderInfo item) {
		orderService.orderInfoUpdate(item);
		
		return "ok";
	}
	
	@PostMapping("/order/Detail")
	public List<OrderDetail> orderDetalList(@RequestBody int orderId){
		List<OrderDetail> list = orderService.orderDetailList(orderId);
		
		return list;
	}
	
	@PostMapping("/order")
	public HashMap<String, Object> orderInfoList(@RequestBody Pager pager){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("order", orderService.orderInfoList(pager));
		map.put("pager", pager);
		
		return map;
	}
	
	@PostMapping("/product/update")
	public Product update(Product item) {
		if(Uploader.upload(item.getUploadFile()) ) {
			item.setImage(item.getUploadFile().getOriginalFilename());
			//productService.update(item);
		}/* else {
			productService.noUploadUpdate(item);
		}*/
		productService.update(item);
		
		return item;
	}
	
	@PostMapping("/product/add")
	public Product add(Product item) {
		String filename = item.getUploadFile().getOriginalFilename();
		
		if(Uploader.upload(item.getUploadFile()) ) {
			item.setImage(filename);			
		}else {
			item.setImage("null");
		}
		
		productService.add(item);
		
		return item;
	}
	
	@PostMapping("/product")
	public HashMap<String, Object> productList(@RequestBody Pager pager){		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("productList", productService.list(pager));
		map.put("pager", pager);
		
		return map;
	}
	
	@PostMapping("/category")
	public List<Category> categoryList(){
		return categoryService.list();
	}
	
	@PostMapping("/categoryAdd")
	public Category categoryAdd(@RequestBody Category item) {
		categoryService.add(item);
		return item;
	}
	
	@PutMapping("/categoryUpdate")
	public Category categoryUpdate(@RequestBody Category item) {
		categoryService.update(item);
		
		return item;
	}
	
	
}
