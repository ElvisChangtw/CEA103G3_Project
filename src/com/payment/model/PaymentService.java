package com.payment.model;

import java.util.List;

import com.articleCollection.model.ArticleCollectionVO;

public class PaymentService {
	private PaymentDAO_interface dao;
	
	public PaymentService() {
		
		dao = new PaymentDAO();
	}
	
	public PaymentVO addCard(Integer member_no, String card_no, String card_name, String exp_mon, String exp_year, String csc) {
		
		PaymentVO paymentVO = new PaymentVO();
		
		paymentVO.setMember_no(member_no);
		paymentVO.setCard_no(card_no);
		paymentVO.setCard_name(card_name);
		paymentVO.setExp_mon(exp_mon);
		paymentVO.setExp_year(exp_year);
		paymentVO.setCsc(csc);
		
		int pay_no= new Integer(dao.insert(paymentVO));
		paymentVO.setPay_no(pay_no); 
		return paymentVO;
	}
	
	public boolean deleteCard(Integer pay_no) {
		return dao.delete(pay_no);
	}
	
	public List<PaymentVO> getAllCard(Integer mb_no) {
		return dao.getOneAll(mb_no);
	}
		
}
