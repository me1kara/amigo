package com.lec.amigo.vo;

public class TrailVO {

	private int walk_review_no;
	private int route_no;
	private int user_no;
	private int walk_star;
	private String walk_cont;
	private String user_nick;
	
	public int getWalk_review_no() {
		return walk_review_no;
	}
	public void setWalk_review_no(int walk_review_no) {
		this.walk_review_no = walk_review_no;
	}
	public int getRoute_no() {
		return route_no;
	}
	public void setRoute_no(int route_no) {
		this.route_no = route_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getWalk_star() {
		return walk_star;
	}
	public void setWalk_star(int walk_star) {
		this.walk_star = walk_star;
	}
	public String getWalk_cont() {
		return walk_cont;
	}
	public void setWalk_cont(String walk_cont) {
		this.walk_cont = walk_cont;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	@Override
	public String toString() {
		return "TrailVO [walk_review_no=" + walk_review_no + ", route_no=" + route_no + ", user_no=" + user_no
				+ ", walk_star=" + walk_star + ", walk_cont=" + walk_cont + ", user_nick=" + user_nick + "]";
	}
	
}
