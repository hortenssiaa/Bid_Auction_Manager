package com.hakyung.bnamgr.dao;

import java.util.ArrayList;

import com.hakyung.bnamgr.vo.MemberVO;
import com.hakyung.bnamgr.vo.ProductVO;

public interface MemberMapper {

	public int insertMember(MemberVO member);
	public MemberVO selectMember(String member_id);
	public ArrayList<ProductVO> selectMyProduct(String member_id);
}
