package com.my.vo;

public class Criteria {
	
	/**
	 * 현재 조회되는 페이지
	 */
	private int page;
	
	/**
	 * 한 페이지당 출력하는 데이터 갯수
	 */
	private int perPageNum;
	
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	/**
	 * 사용자가 해당하는 페이지 하단의 번호를 정하는 메소드
	 * @param page
	 */
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		
		this.page = page;
	}

	/**
	 * 한 페이지에 보여줄 게시글의 수를 정하는 메소드
	 * 한 페이지에 보여줄 게시글 수를 지정하지 않으면 데이터 베이스의 과도한 접근을 허용하므로 제한해야함.
	 * @param perPageNum
	 */
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	/**
	 * 현재의 페이지 번호를 구하는 메소드
	 * @return
	 */
	public int getPage() {
		return page;
	}
	
	
	/**
	 * 페이지당 게시판에 보여줄 갯수를 구하는 메소드이다.
	 * @return
	 */
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	/**
	 * 현재 페이지의 시작하는 게시글의 시작 위치를 구할때 사용하는 메소드
	 * mybatis mapper의 rownum에 쓰이는 수를 구함
	 * @return
	 */
	public int getPageStart() {
		return (this.page-1) * perPageNum;
	}




	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
	
	
}
