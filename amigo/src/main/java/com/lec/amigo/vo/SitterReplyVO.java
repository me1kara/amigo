package com.lec.amigo.vo;

import java.util.Date;

public class SitterReplyVO {

	private int sbd_r_no;
	private int sbd_no;
	private String sbd_r_cont;
	private Date sbd_r_regdate;
	private int sbd_r_ref;
	private int sbd_r_lev;
	private int sbd_r_seq;
	private int user_no;
	private String user_nick;
	
	public int getSbd_r_no() {
		return sbd_r_no;
	}
	public void setSbd_r_no(int sbd_r_no) {
		this.sbd_r_no = sbd_r_no;
	}
	public int getSbd_no() {
		return sbd_no;
	}
	public void setSbd_no(int sbd_no) {
		this.sbd_no = sbd_no;
	}
	public String getSbd_r_cont() {
		return sbd_r_cont;
	}
	public void setSbd_r_cont(String sbd_r_cont) {
		this.sbd_r_cont = sbd_r_cont;
	}
	public Date getSbd_r_regdate() {
		return sbd_r_regdate;
	}
	public void setSbd_r_regdate(Date sbd_r_regdate) {
		this.sbd_r_regdate = sbd_r_regdate;
	}
	public int getSbd_r_ref() {
		return sbd_r_ref;
	}
	public void setSbd_r_ref(int sbd_r_ref) {
		this.sbd_r_ref = sbd_r_ref;
	}
	public int getSbd_r_lev() {
		return sbd_r_lev;
	}
	public void setSbd_r_lev(int sbd_r_lev) {
		this.sbd_r_lev = sbd_r_lev;
	}
	public int getSbd_r_seq() {
		return sbd_r_seq;
	}
	public void setSbd_r_seq(int sbd_r_seq) {
		this.sbd_r_seq = sbd_r_seq;
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
	
	@Override
	public String toString() {
		return "SitterReplyVO [sbd_r_no=" + sbd_r_no + ", sbd_no=" + sbd_no + ", sbd_r_cont=" + sbd_r_cont
				+ ", sbd_r_regdate=" + sbd_r_regdate + ", sbd_r_ref=" + sbd_r_ref + ", sbd_r_lev=" + sbd_r_lev
				+ ", sbd_r_seq=" + sbd_r_seq + ", user_no=" + user_no + "]";
	}
	
	
	 
}
