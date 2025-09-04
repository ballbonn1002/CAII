package com.cubesofttech.model;

import java.io.Serializable;
import java.sql.Time;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user_rpw")
public class UserRpw implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name="user_rpw_id")
	private int user_rpw_id;
	@Column(name="user_id")
	private String user_id;
	@Column(name="user_key")
	private String user_key;
	@Column(name="expired")
	private Timestamp expried;
	public int getUserRpwId() {
		return user_rpw_id;
	}
	public void setUserRpwId(int user_rpw_id) {
		this.user_rpw_id = user_rpw_id;
	}
	public String getUserId() {
		return user_id;
	}
	public void setUserId(String user_id) {
		this.user_id = user_id;
	}
	public String getUserKey() {
		return user_key;
	}
	public void setUserKey(String user_key) {
		this.user_key = user_key;
	}
	public Timestamp getExpried() {
		return expried;
	}
	public void setExpried(Timestamp expried) {
		this.expried = expried;
	}
	
	
}
