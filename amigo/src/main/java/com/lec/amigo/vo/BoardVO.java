package com.lec.amigo.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {

	private int ubd_no;
	private String ubd_title;
	private Date ubd_date;
	private int ubd_likecnt;
	private String ubd_file;
	private String ubd_cont;
	private int ubd_cnt;
	private String ubd_cate;
	private int user_no;
	private String dog_kind;
	private List<MultipartFile> uploadFile;
	private String user_nick;
	
	public int getUbd_no() {
		return ubd_no;
	}
	public void setUbd_no(int ubd_no) {
		this.ubd_no = ubd_no;
	}
	public String getUbd_title() {
		return ubd_title;
	}
	public void setUbd_title(String ubd_title) {
		this.ubd_title = ubd_title;
	}
	public Date getUbd_date() {
		return ubd_date;
	}
	public void setUbd_date(Date ubd_date) {
		this.ubd_date = ubd_date;
	}
	public int getUbd_likecnt() {
		return ubd_likecnt;
	}
	public void setUbd_likecnt(int ubd_likecnt) {
		this.ubd_likecnt = ubd_likecnt;
	}
	public String getUbd_file() {
		return ubd_file;
	}
	public void setUbd_file(String ubd_file) {
		this.ubd_file = ubd_file;
	}
	public String getUbd_cont() {
		return ubd_cont;
	}
	public void setUbd_cont(String ubd_cont) {
		this.ubd_cont = ubd_cont;
	}
	public int getUbd_cnt() {
		return ubd_cnt;
	}
	public void setUbd_cnt(int ubd_cnt) {
		this.ubd_cnt = ubd_cnt;
	}
	public String getUbd_cate() {
		return ubd_cate;
	}
	public void setUbd_cate(String ubd_cate) {
		this.ubd_cate = ubd_cate;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getDog_kind() {
		return dog_kind;
	}
	public void setDog_kind(String dog_kind) {
		this.dog_kind = dog_kind;
	}
	
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	
	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}
	@Override
	public String toString() {
		return "BoardVO [ubd_no=" + ubd_no + ", ubd_title=" + ubd_title + ", ubd_cont=" + ubd_cont + ", ubd_cate="
				+ ubd_cate + ", user_no=" + user_no + ", dog_kind=" + dog_kind + "]";
	}
	

}
