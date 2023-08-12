package kr.ac.kopo.foodmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ac.kopo.foodmall.model.Category;
import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.service.CategoryService;
import kr.ac.kopo.foodmall.service.ProductService;
import kr.ac.kopo.foodmall.util.Pager;

@Controller
@RequestMapping("/category")
public class CategoryController {
	final String path = "/category";
	
	@Autowired
	CategoryService service;
	
	@Autowired
	ProductService productService;
	
	// 해당하는 카테고리의 더미 상품 만들기
	@RequestMapping("/dummy")
	public String dummy(int categoryId) {
		productService.dummy(categoryId);
		
		return "redirect:" + categoryId;
	}
	
	// 카테고리들이 나오는 리스트
	@RequestMapping("/list")
	public String list(Model model) {
		List<Category> list = service.list();
		
		model.addAttribute("list", list);
		
		return path + "/list";
	}
	
	@GetMapping("/add")
	public String add() {
		return path + "/add";
	}
	
	@PostMapping("/add")
	public String add(Category item) {
		service.add(item);
		return "redirect:list";
	}
	
	@GetMapping("/update/{categoryId}")
	public String update(@PathVariable int categoryId, Model model) {
		Category item = service.item(categoryId);
		
		model.addAttribute("item", item);
		
		return path + "/update";
	}
	
	@PostMapping("/update/{categoryId}")
	public String update(@PathVariable int categoryId, Category item) {
		service.update(item);
		
		return "redirect:../list";
	}
	
	@RequestMapping("/delete/{categoryId}")
	public String delete(@PathVariable int categoryId) {
		service.delete(categoryId);
		
		return "redirect:../list";
	}
}
