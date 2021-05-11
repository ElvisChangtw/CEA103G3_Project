package com.ord_ticket_type.model;
import java.util.List;

public class Ord_ticket_typeService {
	private Ord_ticket_typeDAO_interface dao;
	
	public Ord_ticket_typeService() {
		dao = new Ord_ticket_typeDAO();
	}
	
	public Ord_ticket_typeVO addOrd_ticket_type(Integer ticket_type_no, Integer order_no, Integer ticket_count, Integer price) {
		
		Ord_ticket_typeVO ord_ticket_typeVO = new Ord_ticket_typeVO();
		
		ord_ticket_typeVO.setTicket_type_no(ticket_type_no);
		ord_ticket_typeVO.setOrder_no(order_no);
		ord_ticket_typeVO.setTicket_count(ticket_count);
		ord_ticket_typeVO.setPrice(price);
		dao.insert(ord_ticket_typeVO);
		
		return ord_ticket_typeVO;
	}
	
	public Ord_ticket_typeVO updateOrd_ticket_type(Integer ticket_type_no, Integer order_no, Integer ticket_count, Integer price) {
		
		Ord_ticket_typeVO ord_ticket_typeVO = new Ord_ticket_typeVO();
		
		ord_ticket_typeVO.setTicket_type_no(ticket_type_no);
		ord_ticket_typeVO.setOrder_no(order_no);
		ord_ticket_typeVO.setTicket_count(ticket_count);
		ord_ticket_typeVO.setPrice(price);
		dao.update(ord_ticket_typeVO);
		
		return ord_ticket_typeVO;
	}
	
	public void deleteOrd_ticket_type(Integer ticket_type_no, Integer order_no) {
		dao.delete(ticket_type_no, order_no);
	}
	
	public Ord_ticket_typeVO getOneOrd_ticket_type(Integer ticket_type_no, Integer order_no) {
		return dao.findByPrimaryKey(ticket_type_no, order_no);
	}
	
	public List<Ord_ticket_typeVO> getAll(){
		return dao.getAll();
	}	
	public List<Ord_ticket_typeVO> getAllTicketByOrderno(Integer order_no){
		return dao.getAllTicketByOrderno(order_no);
	}
}
