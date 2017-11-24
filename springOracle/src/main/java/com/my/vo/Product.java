package com.my.vo;

public class Product {

	private String prod_no;
	private String prod_name;
	private int prod_price;

	public Product() {
	}

	public Product(String prod_no, String prod_name, int prod_price) {
		this.prod_no = prod_no;
		this.prod_name = prod_name;
		this.prod_price = prod_price;
	}

	public String getProd_no() {
		return prod_no;
	}

	public void setProd_no(String prod_no) {
		this.prod_no = prod_no;
	}

	public String getProd_name() {
		return prod_name;
	}

	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}

	public int getProd_price() {
		return prod_price;
	}

	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((prod_name == null) ? 0 : prod_name.hashCode());
		result = prime * result + ((prod_no == null) ? 0 : prod_no.hashCode());
		result = prime * result + prod_price;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Product other = (Product) obj;
		if (prod_name == null) {
			if (other.prod_name != null)
				return false;
		} else if (!prod_name.equals(other.prod_name))
			return false;
		if (prod_no == null) {
			if (other.prod_no != null)
				return false;
		} else if (!prod_no.equals(other.prod_no))
			return false;
		if (prod_price != other.prod_price)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Product [prod_no=" + prod_no + ", prod_name=" + prod_name + ", prod_price=" + prod_price + "]";
	}

}
