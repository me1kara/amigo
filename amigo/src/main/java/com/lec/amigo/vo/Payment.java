package com.lec.amigo.vo;

public class Payment {
	private String imp_uid;
	private String merchant_uid;
	private int pay;
	private int user_no;
	private int res_no;
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public int getPay() {
		return pay;
	}
	public void setPay(int pay) {
		this.pay = pay;
	}
	public int getUser_no() {
		return user_no;
	}
	@Override
	public String toString() {
		return "Payment [imp_uid=" + imp_uid + ", merchant_uid=" + merchant_uid + ", pay=" + pay + ", user_no="
				+ user_no + ", res_no=" + res_no + "]";
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getRes_no() {
		return res_no;
	}
	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}
	
	
	
}
