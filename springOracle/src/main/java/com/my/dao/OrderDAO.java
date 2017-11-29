package com.my.dao;

public interface OrderDAO {
	
	/**
	 * 주문을 하는 메소드
	 * @return
	 */
	public String addOrder();

	
	/**
	 * 주문한 리스트를 보여주는 메소드
	 * @return
	 */
	public String orderList();
	
}
