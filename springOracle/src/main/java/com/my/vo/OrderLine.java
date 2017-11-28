package com.my.vo;

public class OrderLine {
	private int line_info_no;
	private Product line_p;
	private int line_quantity;
	
	public OrderLine() {
	}
	public OrderLine(int line_info_no, Product line_p, int line_quantity) {

		this.line_info_no = line_info_no;
		this.line_p = line_p;
		this.line_quantity = line_quantity;
	}
	
	public int getLine_info_no() {
		return line_info_no;
	}
	public void setLine_info_no(int line_info_no) {
		this.line_info_no = line_info_no;
	}
	public int getLine_quantity() {
		return line_quantity;
	}
	public void setLine_quantity(int line_quantity) {
		this.line_quantity = line_quantity;
	}
	public Product getLine_p() {
		return line_p;
	}
	public void setLine_p(Product line_p) {
		this.line_p = line_p;
	}
	@Override
	public String toString() {
		return "OrderLine [line_info_no=" + line_info_no + ", line_p=" + line_p + ", line_quantity=" + line_quantity
				+ "]\n";
	}


	
}
