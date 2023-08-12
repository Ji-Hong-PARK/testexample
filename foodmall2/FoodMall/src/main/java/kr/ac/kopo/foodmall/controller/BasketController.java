package kr.ac.kopo.foodmall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.ac.kopo.foodmall.model.BasketJoin;
import kr.ac.kopo.foodmall.model.Member;
import kr.ac.kopo.foodmall.model.Product;
import kr.ac.kopo.foodmall.service.BasketService;

@Controller
@RequestMapping("/basket")
public class BasketController {
	final String path = "/basket";
	
	@Autowired
	BasketService service;
	
	@RequestMapping({"","/"})
	public String list(@SessionAttribute Member member, Model model) {
		String memberId = member.getMemberId();
		
		List<BasketJoin> list = service.list(memberId);
		
		model.addAttribute("list", list);
		
		return path + "/list";
	}

	//장바구니 추가 ajax
	@PostMapping("/add")
	@ResponseBody
	public String add(@RequestBody int pid, @SessionAttribute Member member, HttpSession session) {
		String memberId = member.getMemberId();
				
		// true=장바구니에 없음, false=장바구니에 이미 담겨있음
		if(service.check(memberId, pid)) {
			//서비스에서 true로 넘어온 경우 / 장바구니에 추가 해야 함
			service.add(memberId, pid);
			int count = service.countBasket(member.getMemberId());
			session.setAttribute("basketCount", count);
			return "success";
		}else {
			//서비스에서 false로 넘어온 경우 / 장바구니에 이미 있음
			return "exist";
		}
	}
	
	
	@RequestMapping("/add/{productId}")
	public String add(@SessionAttribute Member member, @PathVariable int productId, HttpSession session) {
		String memberId = member.getMemberId();
		service.add(memberId, productId);
		
		int count = service.countBasket(member.getMemberId());
		
		session.setAttribute("basketCount", count);
		
		return "redirect:..";
	}
	
	@RequestMapping("/delete/{productId}")
	public String delete(@SessionAttribute Member member, @PathVariable int productId, HttpSession session) {
		String memberId = member.getMemberId(); 
		
		service.delete(memberId, productId);
		
		int count = service.countBasket(member.getMemberId());
		
		session.setAttribute("basketCount", count);
		
		return "redirect:/basket";
	}
		
	@DeleteMapping("/delete")
	@ResponseBody
	public int delete(@RequestBody int pid, @SessionAttribute Member member, HttpSession session) {
		String memberId = member.getMemberId();
		
		service.delete(memberId, pid);
		
		int count = service.countBasket(member.getMemberId());
		session.setAttribute("basketCount", count);
		
		return pid;
	}
	
	@DeleteMapping("/listDelete")
	@ResponseBody
	public String listDelete(@RequestBody int[] pidArray, @SessionAttribute Member member, HttpSession session) {
		String memberId = member.getMemberId();
		service.listDelete(pidArray, memberId);
		int count = service.countBasket(member.getMemberId());
		session.setAttribute("basketCount", count);
		return "success";
	}
	
	// 장바구니에 담긴 상품 갯수 ajax 및 세션 반영
	@PostMapping("/count")
	@ResponseBody
	public int count(@SessionAttribute Member member, HttpSession session) {
		String memberId = member.getMemberId();
		int count = service.countBasket(memberId);
		session.setAttribute("basketCount", count);
		return count;
	}
	
}
