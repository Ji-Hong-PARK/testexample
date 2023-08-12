package kr.ac.kopo.foodmall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ac.kopo.foodmall.model.Category;
import kr.ac.kopo.foodmall.model.Member;
import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.service.BasketService;
import kr.ac.kopo.foodmall.service.CategoryService;
import kr.ac.kopo.foodmall.service.MemberService;
import kr.ac.kopo.foodmall.service.ProductService;

@Controller
public class RootController {

	@Autowired
	MemberService service;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	BasketService basketService;
		
	@RequestMapping("/admin")
	public String adminPage() {
		
		return "admin";
	}
	
	@RequestMapping({"/", "/main"})
	public String main(Model model) {
		List<Product> productList = productService.mainList();
		
		//List<Category> categoryList = categoryService.list(); 
		
		model.addAttribute("productList", productList);
		//model.addAttribute("categoryList", categoryList);
		
		return "main";
	}
	
	@ResponseBody
	@PostMapping("/ajax/category")
	public List<Category> ajaxCategory(){
		return categoryService.list();
	}
	
	@ResponseBody
	@RequestMapping("/member/checkId")
	public String checkId(String memberId) {
		if(service.checkId(memberId))
			return "OK";
		else
			return "FAIL";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
//	ajax 로그인으로 바꾼 이후 쓰지 않는다.
//	@PostMapping("/login")
//	public String login(Member item, HttpSession session) {
//		Member member = service.item(item.getMemberId());
//		
//		if(member != null) {
//			String id = member.getMemberId();
//			String password = member.getMemberPassword();
//			
//			if(id.equals(item.getMemberId()) && password.equals(item.getMemberPassword()) ) {
//				session.setAttribute("member", member);
//								
//				int count = basketService.countBasket(member.getMemberId());
//				
//				session.setAttribute("basketCount", count);
//				
//				return "redirect:.";
//			}
//			return "redirect:login";
//		}
//		return "redirect:login";
//		
//	}
//	
	
	@PostMapping("/ajax/login")
	@ResponseBody
	public String ajaxLogin(@RequestBody Member item, HttpSession session) {
		Member member = service.item(item.getMemberId());
		
		if(member != null) {
			String id = member.getMemberId();
			String password = member.getMemberPassword();
			
			if(id.equals(item.getMemberId()) && password.equals(item.getMemberPassword()) ) {
				session.setAttribute("member", member);
				
				if(id.equals("admin")) {
					return "admin";
				}
				
				int count = basketService.countBasket(member.getMemberId());
				
				session.setAttribute("basketCount", count);
				
				return "success";
			}
			return "fail";
		}
		return "fail";
	}
	
	@PostMapping("/logout")
	@ResponseBody
	public void logout(HttpSession session) {
		session.invalidate();
	}
	
//	@RequestMapping("/logout")
//	public String logout(HttpSession session) {
//		session.invalidate();
//		
//		return "redirect:.";
//	}
	
}
