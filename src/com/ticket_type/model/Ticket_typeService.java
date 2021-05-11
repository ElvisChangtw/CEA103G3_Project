package com.ticket_type.model;
import java.util.List;

public class Ticket_typeService {
	private Ticket_typeDAO_interface dao;
	
	public Ticket_typeService() {
		dao = new Ticket_typeDAO();
	}
	
	public Ticket_typeVO addTicket_type(String ticket_type, Integer ticket_price, String ticket_desc) {
		
		Ticket_typeVO ticket_typeVO = new Ticket_typeVO();
		
		ticket_typeVO.setTicket_type(ticket_type);
		ticket_typeVO.setTicket_price(ticket_price);
		ticket_typeVO.setTicket_desc(ticket_desc);
		dao.insert(ticket_typeVO);
		
		return ticket_typeVO;
	}
	
	public Ticket_typeVO updateTicket_type(Integer ticket_type_no, String ticket_type, Integer ticket_price, String ticket_desc) {
		
		Ticket_typeVO ticket_typeVO = new Ticket_typeVO();
		
		ticket_typeVO.setTicket_type_no(ticket_type_no);
		ticket_typeVO.setTicket_type(ticket_type);
		ticket_typeVO.setTicket_price(ticket_price);
		ticket_typeVO.setTicket_desc(ticket_desc);
		dao.update(ticket_typeVO);
		
		return ticket_typeVO;
	}
	
	public void deleteTicket_type(Integer ticket_type_no) {
		dao.delete(ticket_type_no);
	}
	
	public Ticket_typeVO getOneTicket_type(Integer ticket_type_no) {
		return dao.findByPrimaryKey(ticket_type_no);
	}
	
	public List<Ticket_typeVO> getAll(){
		return dao.getAll();
	}	
	
}
