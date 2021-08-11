package com.hakyung.bnamgr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hakyung.bnamgr.vo.MemberVO;
import com.hakyung.bnamgr.vo.ProductVO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession session;
	
	public int insertMember(MemberVO member) {
		int cnt = 0;
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		try {
			cnt = mapper.insertMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public MemberVO selectMember(String member_id) {
		MemberVO member = null;
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		try {
			member = mapper.selectMember(member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
	public ArrayList<ProductVO> selectMyProduct(String member_id) {
		ArrayList<ProductVO> productList = null;
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		try {
			productList = mapper.selectMyProduct(member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productList;
	}

}
