package com.my.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	
	/**
	 * 총 게시물의 갯수
	 */
	private int totalConunt;
	
	/**
	 * 전체 보여줄 페이지중에 제일 처음인 페이지
	 */
	private int startPage;
	
	/**
	 *  전체 보여줄 페이지중에 가장 마지막인 페이지
	 */
	private int endPage;
	
	/**
	 * startPage(시작 페이지)가 1인경우 이전 버튼을 보여주지 않고 아닌경우에만 보여주기위한 flag 값
	 */
	private boolean prev;
	/**
	 * endPage(마지막 페이지)에서는 다음 버튼을 보이지 않게 하기 위한 flag 값
	 */
	private boolean next;
	
	/**
	 * 해당하는 객체에서 여러가지 정보 (현재 페이지, 페이지당 보여줄 게시물 수, 해당하는 페이지에서 시작하는 게시글 행 번호)등을 알 수있다.
	 */
	private Criteria cri;
	
	
	/**
	 * 보여줄 페이지의 갯수
	 */
	private int displayPageNum = 10;


	public Criteria getCri() {
		return cri;
	}


	public void setCri(Criteria cri) {
		this.cri = cri;
	}


	public int getTotalConunt() {
		return totalConunt;
	}


	public void setTotalConunt(int totalConunt) {
		this.totalConunt = totalConunt;
		calcData();
	}
	
	private void calcData() {		
		endPage = (int) ( Math.ceil( cri.getPage() / (double) displayPageNum ) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
		int tempEndPage = (int) (Math.ceil( totalConunt / (double) cri.getPerPageNum()));
		
		if(endPage>tempEndPage) {
			endPage=tempEndPage;
		}
		prev = startPage == 1 ? false  : true; 
		next = endPage * cri.getPerPageNum() >= totalConunt ? false : true;
	}


	public int getStartPage() {
		return startPage;
	}


	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	public boolean isPrev() {
		return prev;
	}


	public void setPrev(boolean prev) {
		this.prev = prev;
	}


	public boolean isNext() {
		return next;
	}


	public void setNext(boolean next) {
		this.next = next;
	}


	public int getDisplayPageNum() {
		return displayPageNum;
	}


	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	
	public String makeQuery(int page) {
		UriComponents uriComponents =
				UriComponentsBuilder.newInstance()
				.queryParam("page",page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.build();
		return uriComponents.toUriString();
	}
	
	
	
}
