package com.ord_ticket_type.model;

import java.sql.Connection;
import java.util.List;

public interface Ord_ticket_typeDAO_interface {
	public void insert(Ord_ticket_typeVO ord_ticket_typeVO);
	public void update(Ord_ticket_typeVO ord_ticket_typeVO);
	public void delete(Integer ticket_type_no, Integer order_no);
	public Ord_ticket_typeVO findByPrimaryKey(Integer ticket_type_no, Integer order_no);
	public List<Ord_ticket_typeVO> getAll();
	 //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<Theater> getAll(Map<String, String[]> map);
	public void insert2(Ord_ticket_typeVO ord_ticket_typeVO, Connection con);
	public List<Ord_ticket_typeVO> getAllTicketByOrderno(Integer order_no);
}
