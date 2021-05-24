package com.food.model;
import java.util.List;

public class FoodService {
	private FoodDAO_interface dao;
	
	public FoodService() {
		dao = new FoodDAO();
	}
	
	public FoodVO addFood(String food_name, String food_type, Integer food_price, byte[] food_pic, String food_status) {
		
		FoodVO foodVO = new FoodVO();
		
		foodVO.setFood_name(food_name);
		foodVO.setFood_type(food_type);
		foodVO.setFood_price(food_price);
		foodVO.setFood_pic(food_pic);
		foodVO.setFood_status(food_status);
		dao.insert(foodVO);
		
		return foodVO;
	}
	
	public FoodVO updateFood(Integer food_no, String food_name, String food_type, Integer food_price, byte[] food_pic, String food_status) {
		
		FoodVO foodVO = new FoodVO();
		

		foodVO.setFood_name(food_name);
		foodVO.setFood_type(food_type);
		foodVO.setFood_price(food_price);
		foodVO.setFood_pic(food_pic);
		foodVO.setFood_status(food_status);
		foodVO.setFood_no(food_no);
		dao.update(foodVO);
		
		return foodVO;
	}
	
	public void deleteFood(Integer food_no) {
		dao.delete(food_no);
	}
	
	public FoodVO getOneFood(Integer food_no) {
		return dao.findByPrimaryKey(food_no);
	}
	
	public List<FoodVO> getAll(){
		return dao.getAll();
	}	
	
	public void onOrDownFoodStatus(Integer food_no) {
		dao.onOrDownFoodStatus(food_no);
	}
	
}
