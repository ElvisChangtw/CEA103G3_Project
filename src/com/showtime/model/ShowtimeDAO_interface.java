package com.showtime.model;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public interface ShowtimeDAO_interface {
	public void insert(ShowtimeVO showtimeVO);
	public void insert_showtimes(List<ShowtimeVO> list);
	public void update(ShowtimeVO showtimeVO);
	public void update2(String seat_no, Integer showtime_no, java.sql.Connection con);
	public void delete(Integer showtime_no);
	public ShowtimeVO findByPrimaryKey(Integer showtime_no);
	public List<ShowtimeVO> getAll();
	public List<ShowtimeVO> getAll(Map<String, String[]> map);
	 //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<Theater> getAll(Map<String, String[]> map);
	public List<ShowtimeVO> getAllByMovie_no(Integer movie_no);
	public List<Object[]> getAllByDate();
	public List<Object[]> getByHibernate(String sql);
	
}
