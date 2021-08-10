package com.hakyung.bnamgr.dao;

import com.hakyung.bnamgr.vo.MemberVO;

public interface MemberMapper {

	public int insertMember(MemberVO member);
	public MemberVO selectMember(String member_id);
}
