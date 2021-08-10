package com.hakyung.bnamgr.service;

import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hakyung.bnamgr.dao.MemberDAO;
import com.hakyung.bnamgr.vo.MemberVO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private HttpSession session;
	
	public String insertMember(MemberVO member) {
		String path = "";
		int check = dao.insertMember(member);
		
		if (check > 0) {
			path = "redirect:/";
		} else {
			path = "redirect:signinForm";
		}
		return path;
	}
	
	public boolean signin(MemberVO member) {
		boolean check = false;
		MemberVO selectedMember = dao.selectMember(member.getMember_id());
		if (selectedMember != null) {
			if (member.getMember_pw().equals(selectedMember.getMember_pw())) {
				session.setAttribute("loginID", selectedMember.getMember_id());
				session.setAttribute("loginNM", selectedMember.getMember_nm());
				check = true;
			}
		} 
		return check;
		
	}
}
