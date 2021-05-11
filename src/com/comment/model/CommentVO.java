package com.comment.model;
import java.sql.Timestamp;


public class CommentVO implements java.io.Serializable{
	
	private Integer commentno;
	private Integer memberno;
	private Integer movieno;
	private String content;
	private Timestamp creatdate;
	private Timestamp modifydate;
	private String status;
	
	
	public Integer getCommentno() {
		return commentno;
	}
	public void setCommentno(Integer commentno) {
		this.commentno = commentno;
	}
	public Integer getMemberno() {
		return memberno;
	}
	public void setMemberno(Integer memberno) {
		this.memberno = memberno;
	}
	public Integer getMovieno() {
		return movieno;
	}
	public void setMovieno(Integer movieno) {
		this.movieno = movieno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getCreatdate() {
		return creatdate;
	}
	public void setCreatdate(Timestamp creatdate) {
		this.creatdate = creatdate;
	}
	public Timestamp getModifydate() {
		return modifydate;
	}
	public void setModifydate(Timestamp modifydate) {
		this.modifydate = modifydate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}


}
