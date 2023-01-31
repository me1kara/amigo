package com.lec.amigo.vo;

import org.springframework.web.multipart.MultipartFile;

public class DogVO {

	
	private int dog_no;
	private int user_no;
	private String dog_name;
	private String dog_gender;
	private String dog_breeds;
	private String dog_birth;
	private double dog_weight;
	private boolean dog_neutered;
	private boolean dog_rabies_vacc;
	private String dog_image_file;
	private String dog_notice;
	private boolean dog_terms;
	private MultipartFile uploadFile;
	public int getDog_no() {
		return dog_no;
	}
	public void setDog_no(int dog_no) {
		this.dog_no = dog_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getDog_name() {
		return dog_name;
	}
	public void setDog_name(String dog_name) {
		this.dog_name = dog_name;
	}
	public String getDog_gender() {
		return dog_gender;
	}
	public void setDog_gender(String dog_gender) {
		this.dog_gender = dog_gender;
	}
	public String getDog_breeds() {
		return dog_breeds;
	}
	public void setDog_breeds(String dog_breeds) {
		this.dog_breeds = dog_breeds;
	}
	public String getDog_birth() {
		return dog_birth;
	}
	public void setDog_birth(String dog_birth) {
		this.dog_birth = dog_birth;
	}
	public double getDog_weight() {
		return dog_weight;
	}
	public void setDog_weight(double dog_weight) {
		this.dog_weight = dog_weight;
	}
	public boolean isDog_neutered() {
		return dog_neutered;
	}
	public void setDog_neutered(boolean dog_neutered) {
		this.dog_neutered = dog_neutered;
	}
	public boolean isDog_rabies_vacc() {
		return dog_rabies_vacc;
	}
	public void setDog_rabies_vacc(boolean dog_rabies_vacc) {
		this.dog_rabies_vacc = dog_rabies_vacc;
	}
	public String getDog_image_file() {
		return dog_image_file;
	}
	public void setDog_image_file(String dog_image_file) {
		this.dog_image_file = dog_image_file;
	}
	public String getDog_notice() {
		return dog_notice;
	}
	public void setDog_notice(String dog_notice) {
		this.dog_notice = dog_notice;
	}
	public boolean isDog_terms() {
		return dog_terms;
	}
	public void setDog_terms(boolean dog_terms) {
		this.dog_terms = dog_terms;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	@Override
	public String toString() {
		return "DogVO [dog_no=" + dog_no + ", user_no=" + user_no + ", dog_name=" + dog_name + ", dog_gender="
				+ dog_gender + ", dog_breeds=" + dog_breeds + ", dog_birth=" + dog_birth + ", dog_weight=" + dog_weight
				+ ", dog_neutered=" + dog_neutered + ", dog_rabies_vacc=" + dog_rabies_vacc + ", dog_image_file="
				+ dog_image_file + ", dog_notice=" + dog_notice + ", dog_terms=" + dog_terms + ", uploadFile="
				+ uploadFile + "]";
	}
	
	
}
