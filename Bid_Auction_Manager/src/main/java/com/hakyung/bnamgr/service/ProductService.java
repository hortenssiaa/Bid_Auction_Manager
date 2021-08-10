package com.hakyung.bnamgr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hakyung.bnamgr.dao.ProduectDAO;
import com.hakyung.bnamgr.vo.ProductVO;

@Service
public class ProductService {

	@Autowired
	private ProduectDAO dao;
	
	public String insertProduct(ProductVO product) {
		String path = "";
		int check = dao.insertProduct(product);
		
		if (check > 0) {
			path = "redirect:/member/myAuctionPage";
		} else {
			path = "redirect:writeProductForm";
		}
		return path;
	}
}
