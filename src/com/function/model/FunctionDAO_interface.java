package com.function.model;

import java.util.List;

public interface FunctionDAO_interface {
	
    public void insert(FunctionVO functionVO);
    public void update(FunctionVO functionVO);
    public void delete(Integer function_no);
    public FunctionVO findByPrimaryKey(Integer function_no);
    public List<FunctionVO> getAll();
  //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<FunctionVO> getAll(Map<String, String[]> map); 

}
