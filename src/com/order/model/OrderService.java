package com.order.model;

import java.sql.Timestamp;
import java.util.List;

import com.ord_food.model.Ord_foodVO;
import com.ord_ticket_type.model.Ord_ticket_typeVO;

public class OrderService {
	
	private OrderDAO_interface dao;
	
	public OrderService() {
		dao = new OrderDAO();
	}
	
	public OrderVO addOrder(Integer member_no, Integer showtime_no,Timestamp crt_dt, 
			String order_status, String order_type, String payment_type,  Integer total_price, String seat_name) {
		
		OrderVO orderVO = new OrderVO();
		
		orderVO.setMember_no(member_no);
		orderVO.setShowtime_no(showtime_no);
		orderVO.setCrt_dt(crt_dt);
		orderVO.setOrder_status(order_status);
		orderVO.setOrder_type(order_type);
		orderVO.setPayment_type(payment_type);
		orderVO.setTotal_price(total_price);
		orderVO.setSeat_name(seat_name);
		dao.insert(orderVO);
		
		return orderVO;
	}
	public OrderVO addOrder2(Integer member_no, Integer showtime_no,Timestamp crt_dt, 
			String order_status, String order_type, String payment_type,  Integer total_price, String seat_name,
			List<Ord_foodVO> ordFood_list, List<Ord_ticket_typeVO> ordTicket_list, String seat_no) {
		
		OrderVO orderVO = new OrderVO();
		
		orderVO.setMember_no(member_no);
		orderVO.setShowtime_no(showtime_no);
		orderVO.setCrt_dt(crt_dt);
		orderVO.setOrder_status(order_status);
		orderVO.setOrder_type(order_type);
		orderVO.setPayment_type(payment_type);
		orderVO.setTotal_price(total_price);
		orderVO.setSeat_name(seat_name);
		dao.insert2(orderVO, ordFood_list, ordTicket_list, seat_no);
		
		return orderVO;
	}
	
	public OrderVO updateOrder(Integer order_no, Integer member_no, Integer showtime_no,Timestamp crt_dt, 
			String order_status, String order_type, String payment_type,  Integer total_price, String seat_name) {
		OrderVO orderVO = new OrderVO();
		
		orderVO.setOrder_no(order_no);
		orderVO.setMember_no(member_no);
		orderVO.setShowtime_no(showtime_no);
		orderVO.setCrt_dt(crt_dt);
		orderVO.setOrder_status(order_status);
		orderVO.setOrder_type(order_type);
		orderVO.setPayment_type(payment_type);
		orderVO.setTotal_price(total_price);
		orderVO.setSeat_name(seat_name);
		dao.update(orderVO);
		
		return orderVO;
	}
	
	public void deleteOrder(Integer order_no) {
		dao.delete(order_no);
	}
	
	public OrderVO getOneOrder(Integer order_no) {
		return dao.findByPrimaryKey(order_no);
	}
	
	public List<OrderVO> getAll(){
		return dao.getAll();
	}
	public List<OrderVO> getAllOrderByMemno(Integer memberno) {
		return dao.getAllByMemno(memberno);
	}
	public OrderVO deleteOrderByMem(String order_status, Integer order_no) {
		OrderVO orderVO = new OrderVO();
		orderVO.setOrder_status(order_status);
		orderVO.setOrder_no(order_no);
		
		
		dao.deleteByMem(orderVO);
		return orderVO;
	}
	
}
