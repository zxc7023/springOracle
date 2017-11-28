package com.my.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderInfo {
	private int info_no;
	private Date info_date;
	//private String info_id; 
	private Customer info_c;
	private List<OrderLine> lines;
	
	public OrderInfo() {
	}

	public OrderInfo(int info_no, Date info_date, Customer info_c, List<OrderLine> lines) {
		this.info_no = info_no;
		this.info_date = info_date;
		this.info_c = info_c;
		this.lines = lines;
	}


	public Customer getInfo_c() {
		return info_c;
	}


	public void setInfo_c(Customer info_c) {
		this.info_c = info_c;
	}


	public List<OrderLine> getLines() {
		return lines;
	}

	public void setLines(List<OrderLine> lines) {
		this.lines = lines;
	}

	public int getInfo_no() {
		return info_no;
	}

	public void setInfo_no(int info_no) {
		this.info_no = info_no;
	}

	public Date getInfo_date() {
		return info_date;
	}

	public void setInfo_date(Date info_date) {
		this.info_date = info_date;
	}

	@Override
	public String toString() {
		return "OrderInfo [info_no=" + info_no + ", info_date=" + info_date + ", info_c=" + info_c + ", lines=" + lines
				+ "]\n\n";
	}
}
