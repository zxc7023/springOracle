package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.ProductDAO;
import com.my.vo.Product;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	ProductDAO dao;
	
	@Override
	public void enroll(Product product) throws Exception {
		dao.insert(product);
	}

	@Override
	public List<Product> listAll() throws Exception {
		return dao.selectAll();
	}

	@Override
	public List<Product> listName(String word) throws Exception {
		return dao.selectByName(word);
	}

	@Override
	public Product listNo(String no) throws Exception {
		return dao.selectByNo(no);
	}

}
