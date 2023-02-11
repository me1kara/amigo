package com.lec.amigo.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class CsBoardVO {

	private int hbd_no;
	private String hbd_title;
	private Date hbd_date;
	private String hbd_cont;
	private int hbd_cnt;
	private int user_no;
	private String user_nick;
	private int reply_cnt;
	private String user_photo;
	private List<MultipartFile> uploadFile;
	private String hbd_file;
	public int getHbd_no() {
		return hbd_no;
	}
	public void setHbd_no(int hbd_no) {
		this.hbd_no = hbd_no;
	}
	public String getHbd_title() {
		return hbd_title;
	}
	public void setHbd_title(String hbd_title) {
		this.hbd_title = hbd_title;
	}
	public Date getHbd_date() {
		return hbd_date;
	}
	public void setHbd_date(Date hbd_date) {
		this.hbd_date = hbd_date;
	}
	public String getHbd_cont() {
		return hbd_cont;
	}
	public void setHbd_cont(String hbd_cont) {
		this.hbd_cont = hbd_cont;
	}
	public int getHbd_cnt() {
		return hbd_cnt;
	}
	public void setHbd_cnt(int hbd_cnt) {
		this.hbd_cnt = hbd_cnt;
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
	public String getUser_photo() {
		return user_photo;
	}
	public void setUser_photo(String user_photo) {
		this.user_photo = user_photo;
	}
	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getHbd_file() {
		return hbd_file;
	}
	public void setHbd_file(String hbd_file) {
		this.hbd_file = hbd_file;
	}
	@Override
	public String toString() {
		return "CsBoardVO [hbd_no=" + hbd_no + ", hbd_title=" + hbd_title + ", hbd_date=" + hbd_date + ", hbd_cont="
				+ hbd_cont + ", hbd_cnt=" + hbd_cnt + ", user_no=" + user_no + ", user_nick=" + user_nick
				+ ", reply_cnt=" + reply_cnt + ", user_photo=" + user_photo + ", uploadFile=" + uploadFile
				+ ", hbd_file=" + hbd_file + "]";
	}
	
	
	
	
	
}
