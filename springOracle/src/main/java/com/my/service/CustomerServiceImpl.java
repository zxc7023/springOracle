package com.my.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.CustomerDAO;
import com.my.vo.Customer;



@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	CustomerDAO dao;
	
	@Override
	public void regist(Customer customer) throws Exception {
		// TODO Auto-generated method stub
		dao.insert(customer);
	}

	@Override
	public Customer login(String id, String pwd) throws Exception {
		// TODO Auto-generated method stub
		Customer c = dao.selectById(id);
		System.out.println(c);
		if(c==null || !c.getPassword().equals(pwd)||"d".equals(c.getStatus())){
			throw new Exception("로그인 실패");
		}
		return c;
	}

	@Override
	public Customer findById(String id) throws Exception {
		Customer c = dao.selectById(id);
		return c;
	}

	@Override
	public void modify(Customer c) throws Exception {
		dao.update(c);
	}

	@Override
	public void modifyPassword(Customer c) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void modifyPassword(String id, String password) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void remove(Customer c) throws Exception {
		int rowcnt = dao.delete(c);
		if(rowcnt==0){
			throw new Exception("삭제가 되지 않았습니다.");
		}
	}

	@Override
	public void remove(String id, String password) throws Exception {
		// TODO Auto-generated method stub

	}

}
