package com.my.dao;
import java.util.List;

import com.my.vo.Customer;
public interface CustomerDAO{
	/**
	 * 저장하려는 객체의 id가 저장소에 이미 존재하는 경우
	 * "이미 존재하는 아이디입니다"msg를  갖는 예외가 발생함
	 * @param c
	 */
	public void insert(Customer c) throws Exception;	
	/**
	 * 전체 고객을 반환한다.
	 * @return
	 */
/*	public List<Customer> selectAll(String searchItem,String SearchValue) throws Exception;
	
	*//**
	 * 아이디에 해당하는 고객을 반환한다
	 * @param id 아이디
	 * @return 저장소의 고객객체를 반환한다.
	 *        고객을 찾지 못하면 null을 반환한다.
	 */
	public Customer selectById(String id) throws Exception;
	/**
	 * 이름에 해당하는 고객을 반환한다
	 * @param name 이름
	 * @return
	 */
	public List<Customer> selectByName(String name) throws Exception;
	
	
	public void update(Customer c) throws Exception;
	
	public int delete(Customer c) throws Exception;
	
	/**
	 * 고객 객체타입의 List를 받아 업데이트 한다.
	 * @param list
	 */
	public void updateList(List<Customer> list) throws Exception;
	public List<Customer> selectByStatus(String searchValue);


}

