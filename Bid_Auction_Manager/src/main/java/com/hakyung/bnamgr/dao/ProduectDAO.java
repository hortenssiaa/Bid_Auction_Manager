package com.hakyung.bnamgr.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hakyung.bnamgr.vo.ProductVO;

@Repository
public class ProduectDAO {
	
	@Autowired
	private SqlSession session;
	
	public int insertProduct(ProductVO product) {
		int cnt = 0;
		try {
			ProductMapper mapper = session.getMapper(ProductMapper.class);
			cnt = mapper.insertProduct(product);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

}
