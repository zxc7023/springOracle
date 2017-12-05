package com.my.vo;

import java.util.Date;

/**
 * @author Junki
 *
 */
/**
 * @author Junki
 *
 */
public class RepBoard {
	private int no;
	private int parent_no;
	private String subject;
	private String content;
	private String password;
	private int level;
	private Date registerDate;
	private int viewCount;

	public RepBoard() {

	}

	public RepBoard(int no, int parent_no, String subject, String content, String password, int level,
			Date registerDate, int viewCount) {
		this.no = no;
		this.parent_no = parent_no;
		this.subject = subject;
		this.content = content;
		this.password = password;
		this.level = level;
		this.registerDate = registerDate;
		this.viewCount = viewCount;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getParent_no() {
		return parent_no;
	}

	public void setParent_no(int parent_no) {
		this.parent_no = parent_no;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@Override
	public String toString() {
		return "RepBoard [no=" + no + ", parent_no=" + parent_no + ", subject=" + subject + ", content=" + content
				+ ", password=" + password + ", level=" + level + ", registerDate=" + registerDate + ", viewCount="
				+ viewCount + "]";
	}

}
