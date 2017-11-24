package com.my.dao;

import java.sql.SQLException;
import java.util.List;

import com.my.vo.Product;

public interface ProductDAO {
	
	/**
	 * 상품을 추가하는 메소드.
	 * 일반 사용자는 넣을 수 없고, 관리자 모드나 test 소스를 통해서 넣을 수 있다.
	 * @param p Product 클래스 타입의 변수
	 * @throws Exception
	 */
	public void insert(Product p) throws Exception;
	
	
	public List<Product> selectAll() throws Exception;
	
	/**
	 * 상품번호로 검색
	 * @throws Exception 
	 */
	public Product selectByNo(String no) throws SQLException, Exception;
	
	/**
	 * 단어를 포함하고 있는 아이템을 모두검색해서 받아옴 
	 * 실제 상품명이 : a1, a2, b1, ba 
	 * e.g) selectByName("a")
	 * -->a1,a2,ba
	 * return List
	 * @throws Exception 
	 */
	public List<Product> selectByName(String word) throws Exception;


	public void updateList(List<Product> list) throws Exception;
	
	public void deleteList(String[] list) throws Exception;

}
