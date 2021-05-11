package com.notify.model;

import java.util.List;

import com.movieExpect.model.MovieExpectVO;

public interface NotifyDAO_interface {
	
	public void insert(NotifyVO notifyVO);
	
	public void update(NotifyVO notifyVO);
	
	public void delete(Integer notification_no);
	
	public NotifyVO findByPrimaryKey(Integer notification_no);
	
	public List<NotifyVO> getAll();
	
	

}
