package com.my.dao;

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
			session.insert("CustomerMapper.insert", c);
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
		try {
			return session.selectOne("CustomerMapper.selectById", id);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	@Override
	public List<Customer> selectByName(String name) throws Exception {
		// 2. DB와 연결
		try {
			return session.selectList("CustomerMapper.selcetByName", name);
			// 3. SQL구문을 송신
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	@Override
	public void update(Customer c) throws Exception {
		try {
			session.update("CustomerMapper.update", c);
		} catch (BadSqlGrammarException e) {
			throw new Exception("SQL구문 오류");
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public int delete(Customer c) throws Exception {

		try {
			return session.delete("CustomerMapper.delete", c);
		} catch (BadSqlGrammarException e) {
			throw new Exception("SQL구문 오류");
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public void updateList(List<Customer> list) throws Exception {
		for (Customer c : list) {
			session.update("CustomerMapper.updateList", c);
		}

	}
}
