package com.my.vo;

public class Customer extends Person {
	private String id;
	private transient String password;
	private String status;
	
	public Customer() {
	}
	
	
	public Customer(String id, String password,String name, String status) {
		this.id = id;
		this.password = password;
		super.setName(name);
		this.status = status;
	}


	public Customer(String id, String password, String name) {
		this.id = id;
		this.password = password;
		super.setName(name);
	}
	

	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "id="+id+"&password="+password+"&name="+getName()+"&status="+getStatus();
	}
	

	
}
