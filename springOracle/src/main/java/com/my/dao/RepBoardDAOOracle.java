package com.my.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.vo.Criteria;
import com.my.vo.RepBoard;

@Repository
public class RepBoardDAOOracle {

	@Autowired
	private SqlSession session;
	
	/**
	 * 글 번호로 게시글을 검색한다.
	 * @param no
	 * @return
	 * @throws Exception
	 */
	public List<RepBoard> selectByNo(int no) throws Exception {
		return session.selectList("RepBoardMapper.selectByNo", no);
	}
	
	/**
	 * 검색 조건에 해당하는 전체 게시글을 가져온다.
	 * @param cri
	 * @return
	 */
	public List<RepBoard> selectList(Criteria cri) {
		try {
			return session.selectList("RepBoardMapper.selectList", cri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 검색 조건에 해당하는 전체 게시글의 갯수를 구한다.
	 * @param cri
	 * @return
	 * @throws Exception
	 */
	public int countPaging(Criteria cri) throws Exception {
		return session.selectOne("RepBoardMapper.countPaging", cri);
	}
	
	public List<RepBoard> selectPrevNextBoard(int no) throws Exception{
		List<RepBoard> list = new ArrayList<>();
		list.add(selectPrevBoard(no));
		list.add(selectNextBoard(no));
		return list;
	}
	public RepBoard selectPrevBoard(int no) throws Exception{
		return session.selectOne("RepBoardMapper.selectPreBoardByNo",no);
	}
	
	public RepBoard selectNextBoard(int no) throws Exception{
		return session.selectOne("RepBoardMapper.selectNextBoardByNo",no);
	}
	
	
	public boolean chkPassword(int no, String password) throws SQLException, Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("password", password);
		if (session.selectOne("RepBoardMapper.chkpassword", map) != null) {
			return true;
		}
		/*
		 * String selectPasswordSQL =
		 * "SELECT * FROM repboard WHERE no=? AND password=?"; Connection con = null;
		 * PreparedStatement pstmt = null; ResultSet rs = null; try { con =
		 * MyConnection.getConnection(); pstmt =
		 * con.prepareStatement(selectPasswordSQL); pstmt.setInt(1, no);
		 * pstmt.setString(2, password); rs = pstmt.executeQuery(); return rs.next(); }
		 * catch (SQLException e) { e.printStackTrace(); return false; }finally{
		 * MyConnection.close(con, pstmt, rs); }
		 */
		return false;
	}

	public void delete(int no) throws SQLException, Exception {
		session.delete("RepBoardMapper.delete", no);
		/*
		 * Connection con = null; PreparedStatement pstmt = null; String deleteSQL =
		 * "DELETE repboard  WHERE no=?"; try { con = MyConnection.getConnection();
		 * pstmt = con.prepareStatement(deleteSQL); pstmt.setInt(1, no);
		 * pstmt.executeUpdate(); } catch (SQLException e) { e.printStackTrace();
		 * }finally{ MyConnection.close(con, pstmt); }
		 */
	}

	public void insert(RepBoard board) throws Exception {
		session.insert("RepBoardMapper.insert", board);
	}

	public List<RepBoard> selectParentAll() throws SQLException, Exception {
		/*
		 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
		 * String selectALLSQL = "select * from" +"(" +"SELECT rownum, a.*"
		 * +" from repboard a" +" where level=1" +" start with parent_no=0"
		 * +" connect by prior no=parent_no" +" order siblings by no desc" +" )"
		 * +" order by rownum"; ArrayList<RepBoard> list = new ArrayList<>(); try { con
		 * = MyConnection.getConnection(); pstmt = con.prepareStatement(selectALLSQL);
		 * rs = pstmt.executeQuery(); while(rs.next()){ int no = rs.getInt("no"); //글번호
		 * int parentNo = rs.getInt("PARENT_NO"); String subject =
		 * rs.getString("SUBJECT"); String content = rs.getString("CONTENT"); String
		 * password = rs.getString("PASSWORD"); list.add(new RepBoard(no, parentNo,
		 * subject, content, password)); } } catch (SQLException e) {
		 * e.printStackTrace(); }finally{ MyConnection.close(con, pstmt, rs); }
		 */
		return null;
	}

	public List<RepBoard> selectByParentNo(int no) throws SQLException, Exception {
		/*
		 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
		 * String selectByNoSQL ="SELECT level, rownum, a.*" +" from repboard a"
		 * +" where parent_no=0" +" start with no=?" +" connect by prior no=parent_no"
		 * +" order siblings by no desc"; ArrayList<RepBoard> list = new ArrayList<>();
		 * try { con = MyConnection.getConnection(); pstmt =
		 * con.prepareStatement(selectByNoSQL); pstmt.setInt(1, no); rs =
		 * pstmt.executeQuery(); while(rs.next()){//글번호에 해당하는 상세내용 int board_no =
		 * rs.getInt("no"); //글번호 int parentNo = rs.getInt("PARENT_NO"); String subject
		 * = rs.getString("SUBJECT"); String content = rs.getString("CONTENT"); String
		 * password = rs.getString("PASSWORD"); list.add(new RepBoard(board_no,
		 * parentNo, subject, content, password)); } } catch (SQLException e) {
		 * e.printStackTrace(); }finally{ MyConnection.close(con, pstmt, rs); } return
		 * list;
		 */
		return null;
	}


	/*
	 * public List<RepBoard> selectBySubject(String searchSubject,int selectedPage)
	 * throws SQLException , Exception{ Connection con = null; PreparedStatement
	 * pstmt = null; ResultSet rs = null;
	 * 
	 * String selectByNoSQL ="select * from" +" (" +" SELECT rownum as row_num,"
	 * +" level," +" a.*" +" from repboard a"
	 * +" where subject like '%'||?||'%' and level=1" +" and rownum <= ?"
	 * +" start with parent_no=0" +" connect by prior no = parent_no"
	 * +" order siblings by no desc" +" )" +" where row_num >= ?"
	 * +" order by rownum"; ArrayList<RepBoard> list = new ArrayList<>(); try { con
	 * = MyConnection.getConnection(); pstmt = con.prepareStatement(selectByNoSQL);
	 * pstmt.setString(1, searchSubject); pstmt.setInt(2, getEndRow(selectedPage,
	 * postCountPerPage)); pstmt.setInt(3, getStrartRow(selectedPage,
	 * postCountPerPage)); rs = pstmt.executeQuery(); while(rs.next()){//글번호에 해당하는
	 * 상세내용 int board_no = rs.getInt("no"); //글번호 int parentNo =
	 * rs.getInt("PARENT_NO"); String subject = rs.getString("SUBJECT"); String
	 * content = rs.getString("CONTENT"); String password =
	 * rs.getString("PASSWORD"); int level = rs.getInt("level"); list.add(new
	 * RepBoard(board_no, parentNo, subject, content, password,level)); } } catch
	 * (SQLException e) { e.printStackTrace(); }finally{ MyConnection.close(con,
	 * pstmt, rs); } return list; return null; }
	 */

	/*
	 * public void update(int no, String subject, String content, String password)
	 * throws SQLException, Exception { RepBoard rb = new RepBoard(no, 0, subject,
	 * content, password); System.out.println("rb는" + rb); try {
	 * session.update("RepBoardMapper.update", rb); } catch (Exception e) { // TODO:
	 * handle exception } }
	 */
}
