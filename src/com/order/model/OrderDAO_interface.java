package com.order.model;

import java.util.List;

import com.ord_food.model.Ord_foodVO;
import com.ord_ticket_type.model.Ord_ticket_typeVO;

public interface OrderDAO_interface {
	public void insert(OrderVO orderVO);
	public void update(OrderVO orderVO);
	public void delete(Integer order_no);
	public OrderVO findByPrimaryKey(Integer order_no);
	public List<OrderVO> getAll();
	 //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<Theater> getAll(Map<String, String[]> map);
	public void insert2(OrderVO orderVO, List<Ord_foodVO> ordFood_list, 
			List<Ord_ticket_typeVO> ordTicket_list, String seat_no);
	
	public List<OrderVO> getAllByMemno(Integer memberno);
	public void deleteByMem(OrderVO orderVO);
}
