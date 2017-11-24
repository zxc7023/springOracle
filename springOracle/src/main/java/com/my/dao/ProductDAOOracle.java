package com.my.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.vo.Product;

@Repository
public class ProductDAOOracle implements ProductDAO {

	@Autowired
	private SqlSession session;

	@Override
	public void insert(Product p) throws Exception {

		session.insert("ProductMapper.insert", p);
	}

	@Override
	public List<Product> selectAll() throws Exception {
		try {
			List<Product> list = session.selectList("ProductMapper.selectAll");
			return list;
		} catch (Exception e) {
		}
		return null;
	}

	@Override
	public Product selectByNo(String no) throws SQLException, Exception {
		try {
			Product p = session.selectOne("ProductMapper.selectByNo", no);
			return p;
		} catch (Exception e) {
		}
		return null;
	}

	@Override
	public List<Product> selectByName(String word) throws SQLException, Exception {
		try {
			List<Product> list = session.selectList("ProductMapper.selectByName", word);
			return list;
		} catch (Exception e) {
		}
		return null;
	}

	@Override
	public void updateList(List<Product> list) throws Exception {
		for (Product p : list) {
			session.update("ProductMapper.updateList", p);
		}
	}

	@Override
	public void deleteList(String[] list) throws Exception {
		for (String id : list) {
			session.update("ProductMapper.deleteList", id);
		}

	}

}
