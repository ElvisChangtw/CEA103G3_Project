package com.food.model;

import java.util.List;

public interface FoodDAO_interface {
	public void insert(FoodVO foodVO);
	public void update(FoodVO foodVO);
	public void delete(Integer food_no);
	public FoodVO findByPrimaryKey(Integer food_no);
	public List<FoodVO> getAll();
	 //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<Theater> getAll(Map<String, String[]> map);
	public void onOrDownFoodStatus(Integer food_no);
}
