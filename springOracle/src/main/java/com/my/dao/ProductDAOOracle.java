package com.my.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.vo.Customer;
import com.my.vo.Product;


@Repository
public class ProductDAOOracle implements ProductDAO{
	
	@Autowired
	private SqlSession session;
	

	@Override
	public void insert(Product p) throws Exception {
		
		session.insert("ProductMapper.insert",p);
	}

	@Override
	public List<Product> selectAll() throws Exception {
		try {
			List <Product> list = session.selectList("ProductMapper.selectAll");
			return list;
		}catch (Exception e) {
		}
		return null;
	}


	@Override
	public Product selectByNo(String no) throws SQLException, Exception {
		try {
			Product p = session.selectOne("ProductMapper.selectByNo",no);
			return p;
		}catch (Exception e) {
		}
		return null;
	}
	

	@Override
	public List<Product> selectByName(String word) throws SQLException,Exception {
		// 2. DB와 연결
		try {
			List <Product> list = session.selectList("ProductMapper.selectByName",word);
			return list;
			// 3. SQL구문을 송신
		}catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	/*	Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		// 2. DB와 연결
		con =com.my.sql.MyConnection.getConnection();
		
		//3. select문 송신
		//String selectByNameSql="SELECT * from product WHERE prod_name='"+word+"' ";
		String selectByNameSql="Select * from product where prod_name like '%"+word+"%'";
		
		stmt= con.createStatement();
		stmt.executeQuery(selectByNameSql);
		// 4. 송신결과 수신
		rs=stmt.getResultSet();
		ArrayList<Product> list = new ArrayList<>();
		while(rs.next()){
			list.add(new Product(rs.getString("prod_no"), rs.getString("prod_name"), rs.getInt("prod_price")));
		}
		// 5. 연결닫기
		com.my.sql.MyConnection.close(con, stmt, rs);*/
	}
	
	@Override
	public void updateList(List<Product> list) throws Exception {
		for(Product p : list){
			session.update("ProductMapper.updateList",p);
		} 
	}

	@Override
	public void deleteList(String[] list) throws Exception {
		for(String id : list){
			session.update("ProductMapper.deleteList",id);
		}
		
	}
		

}
