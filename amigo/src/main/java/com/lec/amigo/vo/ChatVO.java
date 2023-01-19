package com.lec.amigo.vo;

import java.util.Date;

public class ChatVO {
	
	private int index;
	private int user_no;
	private String content;
	private Date date;
	private boolean read_is;
	private String file;
	private String emo;
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public boolean isRead_is() {
		return read_is;
	}
	public void setRead_is(boolean read_is) {
		this.read_is = read_is;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getEmo() {
		return emo;
	}
	public void setEmo(String emo) {
		this.emo = emo;
	}
	
	
	
	
	
}
