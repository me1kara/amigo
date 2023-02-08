package com.lec.amigo.vo;

import java.util.Date;

public class SitterBoardVO {

	private int sbd_no;
	private String sbd_title;
	private Date sbd_date;
	private String sbd_cont;
	private int sbd_cnt;
	private int user_no;
	private String user_nick;
	private int reply_cnt;
	private String sit_photo;
	
	public int getSbd_no() {
		return sbd_no;
	}
	public void setSbd_no(int sbd_no) {
		this.sbd_no = sbd_no;
	}
	public String getSbd_title() {
		return sbd_title;
	}
	public void setSbd_title(String sbd_title) {
		this.sbd_title = sbd_title;
	}
	public Date getSbd_date() {
		return sbd_date;
	}
	public void setSbd_date(Date sbd_date) {
		this.sbd_date = sbd_date;
	}
	public String getSbd_cont() {
		return sbd_cont;
	}
	public void setSbd_cont(String sbd_cont) {
		this.sbd_cont = sbd_cont;
	}
	public int getSbd_cnt() {
		return sbd_cnt;
	}
	public void setSbd_cnt(int sbd_cnt) {
		this.sbd_cnt = sbd_cnt;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public int getReply_cnt() {
		return reply_cnt;
	}
	public void setReply_cnt(int reply_cnt) {
		this.reply_cnt = reply_cnt;
	}
	
	public String getSit_photo() {
		return sit_photo;
	}
	public void setSit_photo(String sit_photo) {
		this.sit_photo = sit_photo;
	}
	
	@Override
	public String toString() {
		return "SitterBoardVO [sbd_no=" + sbd_no + ", sbd_title=" + sbd_title + ", sbd_date=" + sbd_date + ", sbd_cont="
				+ sbd_cont + ", sbd_cnt=" + sbd_cnt + ", user_no=" + user_no + ", user_nick=" + user_nick
				+ ", reply_cnt=" + reply_cnt + "]";
	}
	
	
}
