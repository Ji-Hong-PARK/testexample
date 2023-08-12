package kr.ac.kopo.foodmall.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.ac.kopo.foodmall.model.Member;
import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.service.CategoryService;
import kr.ac.kopo.foodmall.service.ProductService;
import kr.ac.kopo.foodmall.util.Pager;
import kr.ac.kopo.foodmall.util.Uploader;

@Controller
public class ProductController {
	final String path = "/product";
	
	@Autowired
	ProductService service;
	
	@Autowired
	CategoryService cateogoryService;
	
	//상품 리스트 (카테고리번호 0=전체리스트)
	@RequestMapping("/category/{categoryId}")
	public String list(Model model, Pager pager, @PathVariable int categoryId) {
		String categoryName;
		if(categoryId > 0) {
			categoryName = cateogoryService.item(categoryId).getCategoryName();
		}else {
			categoryName = "전체상품";
		}
		
		if(categoryId > 0) {
			pager.setCategoryId(categoryId);
		}
		List<Product> list = service.list(pager);
		
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("productList", list);
		model.addAttribute("pager", pager);
		
		return path + "/list";
	}
	
//	@RequestMapping("")
//	public String list(int categoryId, Model model) {
//		model.addAttribute("categoryId", categoryId);
//		
//		return path + "/list";
//	}
	
	//ajax로 리스트 불러오기
//	@PostMapping("/product/ajax")
//	@ResponseBody
//	public HashMap<String, Object> list(@RequestBody Pager pager) {
//		HashMap<String, Object> map = new HashMap<String, Object>();
//
//		List<Product> list = service.list(pager);
//		
//		map.put("productList", list);
//		map.put("pager", pager);
//		
//		return map;
//	}

	
	@GetMapping("/product/add")
	public String add() {
		return path + "/add";
	}
	
	@PostMapping("/add")
	public String add(Product item) {
		if(Uploader.upload(item.getUploadFile()) ) {
			item.setImage(item.getUploadFile().getOriginalFilename() );
			service.add(item);
		}/*else {
			// 이미지를 업로드 하지 않고 추가하기 (더미용)
			item.setImage("null");
			service.add(item);
		}*/
			
		
		
		return "redirect:list";
	}
	
	@GetMapping("/product/update/{productId}")
	public String update(@PathVariable int productId, Model model) {
		Product item = service.item(productId);
		
		model.addAttribute("item", item);
		
		return path + "/update";
	}
	
	@PostMapping("/product/update/{productId}")
	public String update(Product item) {
		if(Uploader.upload(item.getUploadFile()) ) {
			item.setImage(item.getUploadFile().getOriginalFilename());
			
			service.update(item);
		}else
			// 상품사진을 업로드 하지 않고 업데이트를 시도하면 위의 조건문에서 false가 되어서 업데이트가 되지 않기 때문에 메소드 추가
			service.noUploadUpdate(item);
		
		return "redirect:../list";
	}
	
	@RequestMapping("/product/delete/{productId}")
	public String delete(@PathVariable int productId) {
		service.delete(productId);
		
		return "redirect:../list";
	}
	
	@GetMapping("/product/view/{productId}")
	public String view(@PathVariable int productId, Model model, @SessionAttribute(required = false) Member member, 
			HttpServletResponse res, HttpServletRequest req, @CookieValue(name="viewItems", required = false) Cookie cookie) {
		
		Product item = service.item(productId);
		model.addAttribute("item", item);

		/* 최근 본 상품(쿠키)
		 * 1. 쿠키의 value값으로 리스트를 불러와서 모델에 추가해준다.
		 * 1-1. value값이 없을 경우 최근 본 상품이 없습니다 문구를 띄운다.
		 * 2. 현재 보고 있는 상품을 쿠키에 추가한다.
		 * 2-1. value에 현재 보고 있는 상품의 id가 이미 있을 경우 그 id를 지우고, value의 맨 앞에 다시 추가해준다.
		 * 3. 4개를 초과할 경우 마지막 값을 지운다.
		 * */			
		if(cookie != null) {
			String[] pidList = cookie.getValue().split(",");
			List<Product> cookieList = service.cookieList(pidList);
			model.addAttribute("viewList", cookieList);
		
			String value;
			
			//쿠키에 상품아이디가 4개 이상 있고, 현재 페이지의 아이디와 겹치는 값이 없을 경우
			if(pidList.length >= 4 && cookie.getValue().indexOf(String.valueOf(productId)) < 0 ) {
				value = pidList[1] + "," + pidList[2] + "," + pidList[3] + "," + productId;
			}else {//겹치는 값이 있을 경우
				value = cookie.getValue().replace(String.valueOf(productId), "");
				value = value + "," + productId;
				value = value.replace(",,", ",");

			}
			
			Cookie newCookie = new Cookie("viewItems", value);
			newCookie.setPath("/");
			newCookie.setMaxAge(60);
			res.addCookie(newCookie);
			
		}else {
			model.addAttribute("viewList", "no-cookie");
			
			Cookie newCookie = new Cookie("viewItems", String.valueOf(productId));
			newCookie.setPath("/");
			newCookie.setMaxAge(60);
			res.addCookie(newCookie);
		}
		
		return path + "/view";
	}
	
}
