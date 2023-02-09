package com.lec.amigo.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {

	private int rev_no;               // 리뷰번호(시퀀스)
	private int sit_no;               // 대상이 되는 펫시터번호
	private int user_no;              // 식별용 유저번호
	private int star_cnt;             // 별점.  즉 Rating Not null + 디폴트 1
	private String rev_content;       // 내용
	private Date rev_date;            // 작성일자
	private String user_addr;         // 작성자의 주소
	private String user_nick;         // 작성자 닉네임
	private String user_name;         // 대상이 되는 펫시터의 이름
	private String user_photo;        // 작성자의 사진
	
	public int getRev_no() {
		return rev_no;
	}
	public void setRev_no(int rev_no) {
		this.rev_no = rev_no;
	}
	public int getSit_no() {
		return sit_no;
	}
	public void setSit_no(int sit_no) {
		this.sit_no = sit_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getStar_cnt() {
		return star_cnt;
	}
	public void setStar_cnt(int star_cnt) {
		this.star_cnt = star_cnt;
	}
	public String getRev_content() {
		return rev_content;
	}
	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}
	public Date getRev_date() {
		return rev_date;
	}
	public void setRev_date(Date rev_date) {
		this.rev_date = rev_date;
	}
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_photo() {
		return user_photo;
	}
	public void setUser_photo(String user_photo) {
		this.user_photo = user_photo;
	}
	@Override
	public String toString() {
		return "ReviewVO [rev_no=" + rev_no + ", sit_no=" + sit_no + ", user_no=" + user_no + ", star_cnt=" + star_cnt
				+ ", rev_content=" + rev_content + ", rev_date=" + rev_date + ", user_addr=" + user_addr
				+ ", user_nick=" + user_nick + ", user_name=" + user_name + ", user_photo=" + user_photo + "]";
	}

	
}

