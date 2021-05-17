package com.relationship.model;

public class RelationshipVO implements java.io.Serializable{
	private Integer member_no;
	private Integer friend_no;
	private String status;
	private String isblock;
	
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}
	public Integer getFriend_no() {
		return friend_no;
	}
	public void setFriend_no(Integer friend_no) {
		this.friend_no = friend_no;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIsblock() {
		return isblock;
	}
	public void setIsblock(String isblock) {
		this.isblock = isblock;
	}
}
