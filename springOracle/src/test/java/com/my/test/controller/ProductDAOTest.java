package com.my.test.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.my.dao.ProductDAO;
import com.my.dao.ProductDAOOracle;
import com.my.vo.Product;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class ProductDAOTest {

	private static final Logger logger = LoggerFactory.getLogger(ProductDAOTest.class);

	@Inject
	ProductDAO dao;

	@Test
	public void insert() throws Exception {
		Product p = new Product("1", "롱패딩", 240000);
		dao.insert(p);

	}

	@Test
	public void selectAll() throws SQLException, Exception {
		List<Product> list = dao.selectAll();
		for(Product p : list){
					System.out.println(p);
		}
	}
}
