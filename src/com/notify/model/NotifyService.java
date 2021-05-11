package com.notify.model;

import java.util.List;


public class NotifyService {
	
	private NotifyDAO_interface dao;
	
	public NotifyService() {
		
		dao = new NotifyDAO();
	}
	
	public List<NotifyVO> getAll(){
		return dao.getAll();
	}

	public NotifyVO updateNotify(String content, Integer notification_no) {
			
		NotifyVO notifyVO = new NotifyVO();
			
		notifyVO.setContent(content);
		notifyVO.setNotification_no(notification_no);
		
		dao.update(notifyVO);
			
		return notifyVO;
	}
	
	public NotifyVO addNotify(Integer member_no, String content) {
		
		NotifyVO notifyVO = new NotifyVO();
		
		notifyVO.setMember_no(member_no);
		notifyVO.setContent(content);
		
		dao.insert(notifyVO);
		
		return notifyVO;
	}
	
	public NotifyVO getOneNotify(Integer notification_no) {
		return dao.findByPrimaryKey(notification_no);
	}
	
	public void deleteNotify(Integer notification_no) {
		dao.delete(notification_no);
	}

}
