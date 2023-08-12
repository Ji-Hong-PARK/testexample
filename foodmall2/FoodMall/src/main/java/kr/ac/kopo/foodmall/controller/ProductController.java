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
	
	//��ǰ ����Ʈ (ī�װ���ȣ 0=��ü����Ʈ)
	@RequestMapping("/category/{categoryId}")
	public String list(Model model, Pager pager, @PathVariable int categoryId) {
		String categoryName;
		if(categoryId > 0) {
			categoryName = cateogoryService.item(categoryId).getCategoryName();
		}else {
			categoryName = "��ü��ǰ";
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
	
	//ajax�� ����Ʈ �ҷ�����
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
			// �̹����� ���ε� ���� �ʰ� �߰��ϱ� (���̿�)
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
			// ��ǰ������ ���ε� ���� �ʰ� ������Ʈ�� �õ��ϸ� ���� ���ǹ����� false�� �Ǿ ������Ʈ�� ���� �ʱ� ������ �޼ҵ� �߰�
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

		/* �ֱ� �� ��ǰ(��Ű)
		 * 1. ��Ű�� value������ ����Ʈ�� �ҷ��ͼ� �𵨿� �߰����ش�.
		 * 1-1. value���� ���� ��� �ֱ� �� ��ǰ�� �����ϴ� ������ ����.
		 * 2. ���� ���� �ִ� ��ǰ�� ��Ű�� �߰��Ѵ�.
		 * 2-1. value�� ���� ���� �ִ� ��ǰ�� id�� �̹� ���� ��� �� id�� �����, value�� �� �տ� �ٽ� �߰����ش�.
		 * 3. 4���� �ʰ��� ��� ������ ���� �����.
		 * */			
		if(cookie != null) {
			String[] pidList = cookie.getValue().split(",");
			List<Product> cookieList = service.cookieList(pidList);
			model.addAttribute("viewList", cookieList);
		
			String value;
			
			//��Ű�� ��ǰ���̵� 4�� �̻� �ְ�, ���� �������� ���̵�� ��ġ�� ���� ���� ���
			if(pidList.length >= 4 && cookie.getValue().indexOf(String.valueOf(productId)) < 0 ) {
				value = pidList[1] + "," + pidList[2] + "," + pidList[3] + "," + productId;
			}else {//��ġ�� ���� ���� ���
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
