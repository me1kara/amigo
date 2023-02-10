package com.lec.amigo.vo;

import java.sql.Date;

public class BookVO {
	private int res_no;
	private int user_no;
	private int sit_no;
	private Date res_regdate;
	private String res_date;
	private int res_time;
	private int dog_no;
	private String res_addr;
	private String res_etc;
	private int res_pay;
	private boolean res_visit_is;
	private boolean res_term_is;

	public int getRes_no() {
		return res_no;
	}

	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getSit_no() {
		return sit_no;
	}

	public void setSit_no(int sit_no) {
		this.sit_no = sit_no;
	}

	public Date getRes_regdate() {
		return res_regdate;
	}

	public void setRes_regdate(Date res_regdate) {
		this.res_regdate = res_regdate;
	}

	public int getRes_time() {
		return res_time;
	}

	public void setRes_time(int res_time) {
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

	public String getRes_etc() {
		return res_etc;
	}

	public void setRes_etc(String res_etc) {
		this.res_etc = res_etc;
	}

	public int getRes_pay() {
		return res_pay;
	}

	public void setRes_pay(int res_pay) {
		this.res_pay = res_pay;
	}

	public boolean isRes_visit_is() {
		return res_visit_is;
	}

	public String getRes_date() {
		return res_date;
	}

	public void setRes_date(String res_date) {
		this.res_date = res_date;
	}

	public void setRes_visit_is(boolean res_visit_is) {
		this.res_visit_is = res_visit_is;
	}

	public boolean isRes_term_is() {
		return res_term_is;
	}

	public void setRes_term_is(boolean res_term_is) {
		this.res_term_is = res_term_is;
	}

	@Override
	public String toString() {
		return "BookVO [res_no=" + res_no + ", user_no=" + user_no + ", sit_no=" + sit_no + ", res_regdate="
				+ res_regdate + ", res_date=" + res_date + ", res_time=" + res_time + ", dog_no=" + dog_no
				+ ", res_addr=" + res_addr + ", res_etc=" + res_etc + ", res_pay=" + res_pay + ", res_visit_is="
				+ res_visit_is + ", res_term_is=" + res_term_is + "]";
	}




}
