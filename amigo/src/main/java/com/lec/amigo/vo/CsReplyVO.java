package com.lec.amigo.vo;

import java.util.Date;

public class CsReplyVO {

	private int hbd_r_no;
	private int hbd_no;
	private String hbd_r_cont;
	private Date hbd_r_regdate;
	private int hbd_r_ref;
	private int hbd_r_lev;
	private int hbd_r_seq;
	private int user_no;
	private String user_nick;
	public int getHbd_r_no() {
		return hbd_r_no;
	}
	public void setHbd_r_no(int hbd_r_no) {
		this.hbd_r_no = hbd_r_no;
	}
	public int getHbd_no() {
		return hbd_no;
	}
	public void setHbd_no(int hbd_no) {
		this.hbd_no = hbd_no;
	}
	public String getHbd_r_cont() {
		return hbd_r_cont;
	}
	public void setHbd_r_cont(String hbd_r_cont) {
		this.hbd_r_cont = hbd_r_cont;
	}
	public Date getHbd_r_regdate() {
		return hbd_r_regdate;
	}
	public void setHbd_r_regdate(Date hbd_r_regdate) {
		this.hbd_r_regdate = hbd_r_regdate;
	}
	public int getHbd_r_ref() {
		return hbd_r_ref;
	}
	public void setHbd_r_ref(int hbd_r_ref) {
		this.hbd_r_ref = hbd_r_ref;
	}
	public int getHbd_r_lev() {
		return hbd_r_lev;
	}
	public void setHbd_r_lev(int hbd_r_lev) {
		this.hbd_r_lev = hbd_r_lev;
	}
	public int getHbd_r_seq() {
		return hbd_r_seq;
	}
	public void setHbd_r_seq(int hbd_r_seq) {
		this.hbd_r_seq = hbd_r_seq;
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
		return "CsReplyVO [hbd_r_no=" + hbd_r_no + ", hbd_no=" + hbd_no + ", hbd_r_cont=" + hbd_r_cont
				+ ", hbd_r_regdate=" + hbd_r_regdate + ", hbd_r_ref=" + hbd_r_ref + ", hbd_r_lev=" + hbd_r_lev
				+ ", hbd_r_seq=" + hbd_r_seq + ", user_no=" + user_no + ", user_nick=" + user_nick + "]";
	}
	
	
	
	
}
