package com.theater.model;
import java.util.List;

public class TheaterService {
	private TheaterDAO_interface dao;
	
	public TheaterService() {
		dao = new TheaterDAO();
	}
	
	public TheaterVO addTheater(String theater_name, String theater_type,
			String seat_no, String seat_name) {
		
		TheaterVO theaterVO = new TheaterVO();
		
		theaterVO.setTheater_name(theater_name);
		theaterVO.setTheater_type(theater_type);
		theaterVO.setSeat_no(seat_no);
		theaterVO.setSeat_name(seat_name);
		dao.insert(theaterVO);
		
		return theaterVO;
	}
	
	public TheaterVO updateTheater(Integer theater_no, String theater_name, String theater_type,
			String seat_no, String seat_name) {
		
		TheaterVO theaterVO = new TheaterVO();
		
		theaterVO.setTheater_no(theater_no);
		theaterVO.setTheater_name(theater_name);
		theaterVO.setTheater_type(theater_type);
		theaterVO.setSeat_no(seat_no);
		theaterVO.setSeat_name(seat_name);
		dao.update(theaterVO);
		
		return theaterVO;
	}
	
	public void deleteTheater(Integer theater_no) {
		dao.delete(theater_no);
	}
	
	public TheaterVO getOneTheater(Integer theater_no) {
		return dao.findByPrimaryKey(theater_no);
	}
	
	public List<TheaterVO> getAll(){
		return dao.getAll();
	}	
	
//	public TheaterVO getOneSeat_NO(Integer theater_no) {
//		return dao.findSeat_no(theater_no);
//	}
	
	
	
	
	
	
	
	
	
}
