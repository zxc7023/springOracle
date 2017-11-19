package com.my.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Repository;

import com.my.vo.Customer;

@Repository
public class CustomerDAOOracle implements CustomerDAO {

	@Autowired
	private SqlSession session;

	@Override
	public void insert(Customer c) throws Exception {
		// 2. DB와 연결
		try {
			// 3. SQL구문을 송신
			session.insert("CustomerMapper2.insert", c);
			// session.commit();
			/*
			 * } catch (PersistenceException e) { Throwable t = e.getCause(); if
			 * (t instanceof SQLException) { SQLException sqle = (SQLException)
			 * t; int errorCode = sqle.getErrorCode(); if (errorCode == 1) {
			 * throw new Exception("이미 존재하는 아이디입니다."); } }
			 */
			// SpringFrameWork의 exception이 발생함 spring에서는 다양한 에러를 쉽게 파악가능
		} catch (DuplicateKeyException e) {
			throw new Exception("이미 존재하는 아이디입니다.");
		} catch (BadSqlGrammarException e) {
			throw new Exception("SQL구문 오류!");
		} catch (Exception e) {
			throw e;
		}
	}



	@Override
	public Customer selectById(String id) throws Exception {
		// 2. DB와 연결
		try {
			// 3. SQL구문을 송신
			return session.selectOne("CustomerMapper2.selectById", id);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	@Override
	public List<Customer> selectByName(String name) throws Exception {
		// 2. DB와 연결
		try {
			return session.selectList("CustomerMapper2.selcetByName", name);
			// 3. SQL구문을 송신
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	@Override
	public void update(Customer c) throws Exception {
		try {
			session.update("CustomerMapper2.update", c);
		} catch (BadSqlGrammarException e) {
			throw new Exception("SQL구문 오류");
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public int delete(Customer c) throws Exception {

		try {
			return session.delete("CustomerMapper2.delete", c);
		} catch (BadSqlGrammarException e) {
			throw new Exception("SQL구문 오류");
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public void updateList(List<Customer> list) throws Exception {
		for(Customer c : list){
			session.update("CustomerMapper2.updateList",c);
		}
		
	}

	@Override
	public List<Customer> selectByStatus(String status) {
		try {
			System.out.println(status);
			return session.selectList("CustomerMapper2.selectByStatus", status);
			// 3. SQL구문을 송신
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	public int getPageIndexCount(int totalRowCount) throws SQLException , Exception{
		int pageIndexCount = (int)Math.ceil(totalRowCount/5.0);
		return pageIndexCount;
	}
	
	public int getStrartRow(int nowPage, int postCountPerPage){
		int startRow=0;
		startRow=(nowPage-1)*postCountPerPage+1;
		return startRow;
	}
	
	public int getEndRow(int nowPage, int postCountPerPage){
		int endRow=0;
		endRow=nowPage*postCountPerPage;
		return endRow;
	}
	
/*	public List<Customer> selectByPage(int nowPage, String searchItem, String searchValue) throws SQLException{
		HashMap<String, Object> map = new HashMap<>();
		map.put(searchItem, searchValue);
		map.put("startRow", this.getStrartRow(nowPage, 5));
		map.put("endRow", this.getEndRow(nowPage, 5));
		System.out.println("searchItem: " + searchItem+ "searchValue" + searchValue+ "startRow: " + getStrartRow(nowPage, 5) + "endRow :"+ getEndRow(nowPage, 5));
		return session.selectList("CustomerMapper2.selectByPage",map);
	 }
	
	public  List<Customer> selectAll(String searchItem,String searchValue) {
		try{
			HashMap<String, String> map = new HashMap<>();
			map.put(searchItem, searchValue);
			
			return session.selectList("CustomerMapper2.selectAll",map);
		}catch (Exception e) {
			
		}
		return null;
	}*/
	
}
