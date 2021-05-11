package com.ord_food.model;
import java.util.List;

public class Ord_foodService {
	private Ord_foodDAO_interface dao;
	
	public Ord_foodService() {
		dao = new Ord_foodDAO();
	}
	
	public Ord_foodVO addOrd_food(Integer order_no, Integer food_no, Integer food_count, Integer price) {
		
		Ord_foodVO ord_foodVO = new Ord_foodVO();
		
		ord_foodVO.setOrder_no(order_no);
		ord_foodVO.setFood_no(food_no);
		ord_foodVO.setFood_count(food_count);
		ord_foodVO.setPrice(price);
		dao.insert(ord_foodVO);
		
		return ord_foodVO;
	}
	
	public Ord_foodVO updateOrd_food(Integer order_no, Integer food_no, Integer food_count, Integer price) {
		
		Ord_foodVO ord_foodVO = new Ord_foodVO();
		
		ord_foodVO.setOrder_no(order_no);
		ord_foodVO.setFood_no(food_no);
		ord_foodVO.setFood_count(food_count);
		ord_foodVO.setPrice(price);
		dao.update(ord_foodVO);
		
		return ord_foodVO;
	}
	
	public void deleteOrd_food(Integer order_no, Integer food_no) {
		dao.delete(order_no, food_no);
	}
	
	public Ord_foodVO getOneOrd_food(Integer order_no, Integer food_no) {
		return dao.findByPrimaryKey(order_no, food_no);
	}
	
	public List<Ord_foodVO> getAll(){
		return dao.getAll();
	}	
	public List<Ord_foodVO> getAllFoodByOrderno(Integer order_no){
		return dao.getAllFoodByOrderno(order_no);
	}
}
