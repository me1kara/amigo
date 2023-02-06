package com.lec.amigo.vo;

import java.util.Date;

public class BookContentVO {
	private int res_no;
	private Date res_date;
	private String res_time;
	private int dog_no;
	private String res_addr;
	
	public int getRes_no() {
		return res_no;
	}
	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}
	public Date getRes_date() {
		return res_date;
	}
	public void setRes_date(Date res_date) {
		this.res_date = res_date;
	}
	public String getRes_time() {
		return res_time;
	}
	public void setRes_time(String res_time) {
		this.res_time = res_time;
	}
	public int getDog_no() {
		return dog_no;
	}
	public void setDog_no(int dog_no) {
		this.dog_no = dog_no;
	}
	public String getRes_addr() {
		return res_addr;
	}
	public void setRes_addr(String res_addr) {
		this.res_addr = res_addr;
	}
	@Override
	public String toString() {
		return "ResContentVO [res_no=" + res_no + ", res_date=" + res_date + ", res_time=" + res_time + ", dog_no="
				+ dog_no + ", res_addr=" + res_addr + "]";
	}
	
	
}
