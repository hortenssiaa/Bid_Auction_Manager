package com.hakyung.bnamgr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hakyung.bnamgr.service.ProductService;
import com.hakyung.bnamgr.vo.ProductVO;

@Controller
public class ProductController {

	@Autowired
	private ProductService service;
	
	@RequestMapping(value = "/auction/insertProductForm" , method = RequestMethod.GET)
	public String productForm() {
		return "/product/writeProductForm";
	}

	@RequestMapping(value = "/product/insertProduct" , method = RequestMethod.POST)
	public String insertProduct(ProductVO product) {
		return service.insertProduct(product);
	}

	@RequestMapping(value = "/auction/getMPtest" , method = RequestMethod.GET)
	public String marketPriceTest() {
		return "/auction/marketPriceTest";
	}
}
