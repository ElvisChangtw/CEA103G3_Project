package com.mem.model;

import java.sql.Date;
import java.util.List;
import java.util.Set;

import com.relationship.model.RelationshipVO;
import java.util.*;


public class MemService {
	
	private MemDAO_interface dao;
	
	public MemService() {
		dao = new MemDAO();
	}
	
	public List<MemVO> getAll(){
		return dao.getAll();
	}
	
	public MemVO getOneMem(Integer member_no) {
		return dao.findByPrimaryKey(member_no);
	}
	
	public MemVO addMem(String mb_name, String mb_email, String mb_pwd, Date mb_bd, byte[] mb_pic,
			 String mb_phone,String mb_city, String mb_address) {
		
		MemVO memVO = new MemVO();
		
		memVO.setMb_name(mb_name);
		memVO.setMb_email(mb_email);
		memVO.setMb_pwd(mb_pwd);
		memVO.setMb_bd(mb_bd);
		memVO.setMb_pic(mb_pic);
		memVO.setMb_phone(mb_phone);
		memVO.setMb_city(mb_city);
		memVO.setMb_address(mb_address);

		dao.insert(memVO);
		
		return memVO;
	}
	
	public MemVO updateMem(Integer member_no, String mb_name, String mb_email, String mb_pwd, Date mb_bd, byte[] mb_pic,
			 String mb_phone,String mb_city, String mb_address, String status, int mb_point, String mb_level, Date crt_dt) {
		
		MemVO memVO = new MemVO();
		
		memVO.setMember_no(member_no);
		memVO.setMb_name(mb_name);
		memVO.setMb_email(mb_email);
		memVO.setMb_pwd(mb_pwd);
		memVO.setMb_bd(mb_bd);
		memVO.setMb_pic(mb_pic);
		memVO.setMb_phone(mb_phone);
		memVO.setMb_city(mb_city);
		memVO.setMb_address(mb_address);
		memVO.setStatus(status);
		memVO.setMb_point(mb_point);
		memVO.setMb_level(mb_level);
		memVO.setCrt_dt(crt_dt);
		
		if(memVO.getMb_pic().length==0) {
			memVO.setMb_pic(dao.getOnePic(member_no).getMb_pic());
		}
		if((memVO.getStatus()!=null)||(memVO.getMb_point()!=null)||(memVO.getMb_level()!=null)||(memVO.getCrt_dt()!=null)){
			dao.back_update(memVO);
		}
		dao.front_update(memVO);
		
		return memVO;
	}
	
	public MemVO forontUpdateMem(Integer member_no, String mb_name, Date mb_bd,
			 String mb_phone,String mb_city, String mb_address) {
		
		MemVO memVO = new MemVO();
		memVO.setMember_no(member_no);
		memVO.setMb_name(mb_name);
		memVO.setMb_bd(mb_bd);
		memVO.setMb_phone(mb_phone);
		memVO.setMb_city(mb_city);
		memVO.setMb_address(mb_address);
		dao.front_update(memVO);
		
		return memVO;

	}
	public void deleteMem(Integer member_no) {
		dao.delete(member_no);
	} 
	
	
	public MemVO getOnePic(Integer member_no) {
		return dao.getOnePic(member_no);
	}
	
	public void updateMemPic(Integer mb_no, byte[] mb_pic) {
		MemVO membervo = new MemVO();
		membervo.setMember_no(mb_no);
		membervo.setMb_pic(mb_pic);
		dao.updatePic(membervo);
	}
	public void updatePwd(Integer mb_no, String mb_pwd) {
		MemVO membervo = new MemVO();
		membervo.setMember_no(mb_no);
		membervo.setMb_pwd(mb_pwd);
		dao.updatePwd(membervo);
	}
	public MemVO loginCheck(String mb_email, String mb_pwd) {
		return dao.login_check(mb_email, mb_pwd);
	}
	public MemVO accountActivate(String mb_email) {
		return dao.account_activate(mb_email);
	}

	public MemVO emailCheck(String mb_email) {
		return dao.email_check(mb_email);
	}
	
	public Set<RelationshipVO> getRelationshipsByMemberno(Integer member_no) {
		return dao.getRelationshipsByMemberno(member_no);
	}
	
	public MemVO getPassword(String mb_email) {
		return dao.getPassword(mb_email);
	}
	public void updateRandomPws(String mb_email, String mb_pwd) {
//		MemVO memVO1 = new MemVO();
//		memVO1.setMb_email(mb_email);
//		memVO1.setMb_pwd(mb_pwd);
		dao.updateRandomPws(mb_email, mb_pwd);
	}
	public List<MemVO> getAll(Map<String, String[]> map) {		
		return dao.getAll(map);
	}
	
	 
	
}