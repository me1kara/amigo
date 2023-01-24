package com.lec.amigo.vo;

import java.util.Date;

public class ChatVO {
	
	private int chat_no;
	private int index;
	private String user_nick;
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

	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
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
	public int getChat_no() {
		return chat_no;
	}
	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}
	
	@Override
	public String toString() {
		return "ChatVO [index=" + index + ", user_nick=" + user_nick + ", content=" + content + ", date=" + date
				+ ", read_is=" + read_is + ", file=" + file + ", emo=" + emo + "]";
	}
	
	

	
	
	
	
	
	
	
}
