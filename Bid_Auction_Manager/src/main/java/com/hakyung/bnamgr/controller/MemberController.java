package com.hakyung.bnamgr.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hakyung.bnamgr.service.MemberService;
import com.hakyung.bnamgr.vo.MemberVO;
import com.hakyung.bnamgr.vo.ProductVO;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@RequestMapping(value = "/member/signinForm" , method = RequestMethod.GET)
	public String signinForm() {
		return "/member/signinForm";
	}

	@ResponseBody
	@RequestMapping(value = "/member/signin" , method = RequestMethod.POST)
	public boolean signin(MemberVO member) {
		return service.signin(member);
	}
	
	@RequestMapping(value = "/member/signupForm" , method = RequestMethod.GET)
	public String signupForm() {
		return "/member/signupForm";
	}

	@RequestMapping(value = "/member/signup" , method = RequestMethod.POST)
	public String signup(MemberVO member) {
		return service.insertMember(member);
	}

	@RequestMapping(value = "/member/myAuctionPage" , method = RequestMethod.GET)
	public String myAuctionPage(Model model) {
		ArrayList<ProductVO> productList = service.selectMyProduct();
		model.addAttribute("productList", productList);
		
		return "/member/myAuctionPage";
	}

	@RequestMapping(value = "/member/logout" , method = RequestMethod.GET)
	public String logout() {
		return service.logout();
	}

}
