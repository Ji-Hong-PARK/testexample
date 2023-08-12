package kr.ac.kopo.foodmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.context.annotation.SessionScope;

import kr.ac.kopo.foodmall.model.Member;
import kr.ac.kopo.foodmall.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	final String path = "/member";
	
	@Autowired
	MemberService service;
	
	@ResponseBody
	@RequestMapping("/mileage")
	public int mileage(@SessionAttribute Member member) {
		Member item = service.item(member.getMemberId());
		
		return item.getMemberMileage();
	}
	
	@RequestMapping({"", "/", "list"})
	public String list(Model model) {
		List<Member> list = service.list();
		
		model.addAttribute("list", list);
		
		return path + "/list";
	}
	
	@GetMapping("/add")
	public String add() {
		return path + "/add";
	}
	
	@PostMapping("/add")
	public String add(Member item) {
		service.add(item);
		
		return "redirect:/main";
	}
	
	@GetMapping("/update")
	public String update(String memberId, Model model) {
		Member item = service.item(memberId);
		
		model.addAttribute("item", item);
		
		return path + "/update";
	}
	
	@PostMapping("/update")
	public String update(Member item) {
		service.update(item);
		
		return "redirect:../";
	}

//	
//	@RequestMapping("/delete")
//	public String delete(String memberId) {
//		service.delete(memberId);
//		
//		return "redirect:list";
//	}
//	
}
