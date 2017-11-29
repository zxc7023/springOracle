package com.my.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.my.vo.OrderInfo;
import com.my.vo.OrderLine;

@Repository
public class OrderDAOOracle {
	
	@Autowired
	private SqlSession session;
	
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=IOException.class)
	public void insert(OrderInfo info) throws Exception{
			insertInfo(info);
			insertLine(info);
	}

	public void insertInfo(OrderInfo info) throws Exception{
			session.insert("OrderMapper.insertInfo",info);
	}

	public void insertLine(OrderInfo info) throws SQLException, IOException {
			List<OrderLine> lines = info.getLines();
			for(OrderLine line : lines){
				session.insert("OrderMapper.insertLine",line);
			}
	}

	/**
	 * 전체 주문목록을 반환한다.
	 * 
	 * @return
	 * @throws SQLException 
	 */
	public List<OrderInfo> selectAll() throws SQLException ,Exception {

		try{
			return session.selectList("OrderMapper.selectAll");
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
		}
		return null;
	}
	
	/**
	 * 주문자ID에 해당하는 해당목록을 반환한다.
	 * 
	 * @param id
	 *            주문자ID
	 * @return
	 * @throws SQLException 
	 */
	public List<OrderInfo> selectById(String id)
	{
		try{
			return session.selectList("OrderMapper.selectById",id);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
		}
		return null;
	}

	/**
	 * 주문번호에 해당하는 주문정보를 반환한다
	 * 
	 * @param info_no
	 * @return
	 */
	public List<OrderInfo> selectByNo(int info_no) {
		try{
			return session.selectList("OrderMapper.selectByNo",info_no);
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
		}
		return null;
	}

	/**
	 * 상품에 해당하는 주문목록을 반환한다.
	 * 
	 * @param prod_no
	 *            상품번호
	 * @return
	 * @throws SQLException 
	 */
	public List<OrderInfo> selectByProdNO(String prod_no) throws SQLException , Exception{
		
		
		try{
			return session.selectList("OrderMapper.selectByProdNo",prod_no);
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
		}
		return null;
		
		
	/*	Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		String selectIdSQL = "select info_no,info_id, c.name 이름, info_date, line_prod_no, p.prod_name 제품명, prod_price, line_quantity"
				+ " from order_info info join order_line line on info.info_no = line.line_info_no" + " join customer c"
				+ " on info.info_id = c.id" + " join product p" + " on p.prod_no = line.line_prod_no"
				+ " where line_prod_no = '"+prod_no+"' order by info_no";

		OrderInfo info;
		List<OrderInfo> infoList = new ArrayList<>();
		List<OrderLine> lines = null;

		int info_no = 0;
		try {
			con = MyConnection.getConnection();
			stmt = con.createStatement();
			stmt.executeQuery(selectIdSQL);
			rs = stmt.getResultSet();
			while (rs.next()) {
				if (info_no != rs.getInt("info_no")) {// 새로운 주문기본정보
					info = new OrderInfo(); // OrderInfo Type의 변수를 만들어준다.
					lines = new ArrayList<>(); // List<OrderInfo> 클래스가 필요로 하는
												// 4가지 필드를
					info.setLines(lines);
					infoList.add(info);

					info_no = rs.getInt("info_no");
					info.setInfo_no(info_no);
					Customer info_c = new Customer(rs.getString("info_id"), null, rs.getString("이름"));
					info.setInfo_c(info_c);
					info.setInfo_date(rs.getDate("info_date"));
				}

				OrderLine line = new OrderLine();
				line.setLine_info_no(info_no);
				Product line_p = new Product();
				line.setLine_p(line_p);

				line_p.setProd_name(rs.getString("제품명"));
				line_p.setProd_no(rs.getString("line_prod_no"));
				line_p.setProd_price(rs.getInt("prod_price"));
				line.setLine_quantity(rs.getInt("line_quantity"));
				lines.add(line);
			}
		} catch (SQLException e) {
			MyConnection.close(con, stmt, rs);
		}
		return infoList;*/
		
	}

	/**
	 * 주문일자에 해당하는 주문목록을 보여준다.
	 * 
	 * @param frDate
	 *            주문시작일자
	 * @param toDate
	 *            주문종료일자
	 * @return
	 * @throws SQLException 
	 */
	public List<OrderInfo> selectByDate(String frDate, String toDate) throws SQLException ,Exception{
		
		try{
			HashMap<String, String> map = new HashMap<>();
			map.put("frDate", frDate);
			map.put("toDate", toDate);
			return session.selectList("OrderMapper.selectByDate",map);
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
		}
		return null;
		/*	Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		String selectIdSQL = "select info_no,info_id, c.name 이름, info_date, line_prod_no, p.prod_name 제품명, prod_price, line_quantity"
				+ " from order_info info join order_line line on info.info_no = line.line_info_no" + " join customer c"
				+ " on info.info_id = c.id" + " join product p" + " on p.prod_no = line.line_prod_no"
				+ " where info_date between to_date('"+frDate+"','yy/mm/dd') and to_date('"+toDate+"','yy/mm/dd')+1 order by info_no";

		OrderInfo info;
		List<OrderInfo> infoList = new ArrayList<>();
		List<OrderLine> lines = null;

		int info_no = 0;
		try {
			con = MyConnection.getConnection();
			stmt = con.createStatement();
			stmt.executeQuery(selectIdSQL);
			rs = stmt.getResultSet();
			while (rs.next()) {
				if (info_no != rs.getInt("info_no")) {// 새로운 주문기본정보
					info = new OrderInfo(); // OrderInfo Type의 변수를 만들어준다.
					lines = new ArrayList<>(); // List<OrderInfo> 클래스가 필요로 하는
												// 4가지 필드를
					info.setLines(lines);
					infoList.add(info);

					info_no = rs.getInt("info_no");
					info.setInfo_no(info_no);
					Customer info_c = new Customer(rs.getString("info_id"), null, rs.getString("이름"));
					info.setInfo_c(info_c);
					info.setInfo_date(rs.getDate("info_date"));
				}

				OrderLine line = new OrderLine();
				line.setLine_info_no(info_no);
				Product line_p = new Product();
				line.setLine_p(line_p);

				line_p.setProd_name(rs.getString("제품명"));
				line_p.setProd_no(rs.getString("line_prod_no"));
				line_p.setProd_price(rs.getInt("prod_price"));
				line.setLine_quantity(rs.getInt("line_quantity"));
				lines.add(line);
			}
		} catch (SQLException e) {
			MyConnection.close(con, stmt, rs);
		}
		return infoList;*/
	}
}
