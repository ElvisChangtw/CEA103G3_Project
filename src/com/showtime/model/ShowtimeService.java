package com.showtime.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class ShowtimeService {
	
	private ShowtimeDAO_interface dao;
	
	public ShowtimeService() {
		dao = new ShowtimeDAO();
	}
	
	public ShowtimeVO addShowtime(Integer movie_no, Integer theater_no, String seat_no,
			Timestamp showtime_time) {
		
		ShowtimeVO showtimeVO = new ShowtimeVO();
		
		showtimeVO.setMovie_no(movie_no);
		showtimeVO.setTheater_no(theater_no);
		showtimeVO.setSeat_no(seat_no);
		showtimeVO.setShowtime_time(showtime_time);
		dao.insert(showtimeVO);
		
		return showtimeVO;
	}
	
	public void addShowtimes(List<ShowtimeVO> list) {
		dao.insert_showtimes(list);
	}
	
	public ShowtimeVO updateShowtime(Integer showtime_no, Integer movie_no, Integer theater_no, String seat_no,
			Timestamp showtime_time) {
		ShowtimeVO showtimeVO = new ShowtimeVO();
		
		showtimeVO.setShowtime_no(showtime_no);
		showtimeVO.setMovie_no(movie_no);
		showtimeVO.setTheater_no(theater_no);
		showtimeVO.setSeat_no(seat_no);
		showtimeVO.setShowtime_time(showtime_time);
		dao.update(showtimeVO);
		
		return showtimeVO;
	}
	
	public void deleteShowtime(Integer showtime_no) {
		dao.delete(showtime_no);
	}
	
	public ShowtimeVO getOneShowtime(Integer showtime_no) {
		return dao.findByPrimaryKey(showtime_no);
	}
	
	public List<ShowtimeVO> getAll(){
		return dao.getAll();
	}
	public List<ShowtimeVO> getAll(Map<String, String[]> map){
		return dao.getAll(map);
	}
	
	public List<ShowtimeVO> getAllShowtimeByMovie_no(Integer movie_no) {
		return dao.getAllByMovie_no(movie_no);
	}
	
	public List<Object[]> getAllShowtimeByDate() {
		return dao.getAllByDate();
	}
	public List<Object[]> getByHibernate(String sql) {
		return dao.getByHibernate(sql);
	}
}
