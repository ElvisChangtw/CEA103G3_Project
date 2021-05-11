package com.message.model;

import java.sql.Timestamp;
import java.util.List;

public class MessageService {

	private MessageDAO_interface dao;

	public MessageService() {
		dao = new MessageDAO();
	}

	public MessageVO addMessage(Integer from_member_no, Integer to_member_no, 
			String message_content) {

		MessageVO messageVO = new MessageVO();

		messageVO.setFrom_member_no(from_member_no);
		messageVO.setTo_member_no(to_member_no);
		messageVO.setMessage_content(message_content);
		dao.insert(messageVO);

		return messageVO;
	}

	public MessageVO updateMessage(Integer message_no, Integer from_member_no, Integer to_member_no, 
			String message_content, Timestamp message_time) {

		MessageVO messageVO = new MessageVO();
		messageVO.setMessage_no(message_no);
		messageVO.setFrom_member_no(from_member_no);
		messageVO.setTo_member_no(to_member_no);
		messageVO.setMessage_content(message_content);
		messageVO.setMessage_time(message_time);
		dao.update(messageVO);

		return messageVO;
	}

	public void deleteMessage(Integer message_no) {
		dao.delete(message_no);
	}

	public MessageVO getOneMessage(Integer message_no) {
		return dao.findByPrimaryKey(message_no);
	}

	public List<MessageVO> getAll() {
		return dao.getAll();
	}
}
