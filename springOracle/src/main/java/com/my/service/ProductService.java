package com.my.service;

import java.util.List;

import com.my.vo.Product;

public interface ProductService {
	
	/**
	 * 상품을 등록한다.
	 * @param product
	 * @throws Exception
	 */
	public void enroll(Product product) throws Exception;
	
	
	/**
	 * 상품전체 목록을 가져온다.
	 * @return Product 타입의 컬렉션 List
	 * @throws Exception
	 */
	public List<Product> listAll() throws Exception;
	
	
	/**
	 * 상품 목록 중에 Name 일치하는 목록만 가져온다.
	 * @return Product 타입의 컬렉션 List
	 * @throws Exception
	 */
	public List<Product> listName(String word) throws Exception;
	
	
	/**
	 * 상품 목록중 no가 일치하는 한개의 목록만 가져온다
	 * @param no 상품번호
	 * @return Product 타입
	 * @throws Exception
	 */
	public Product listNo(String no) throws Exception;
	
}
