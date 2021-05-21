package com.group_member.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class Group_MemberService {

	private Group_MemberDAO_interface dao;

	public Group_MemberService() {
		dao = new Group_MemberDAO(); 
		}

			
	public Group_MemberVO addGroup_Member(Integer group_no, Integer member_no) {

		Group_MemberVO group_memberVO = new Group_MemberVO();
		group_memberVO = new Group_MemberVO();
		group_memberVO.setGroup_no(group_no);
		group_memberVO.setMember_no(member_no);
		dao.insert(group_memberVO);
		return group_memberVO;
	}

	public Group_MemberVO updateGroup_Member(Integer group_no, Integer member_no, 
			String pay_status,  String status, Timestamp crt_dt) {

		Group_MemberVO group_memberVO = new Group_MemberVO();
		group_memberVO.setGroup_no(group_no);
		group_memberVO.setMember_no(member_no);
		group_memberVO.setPay_status(pay_status);
		group_memberVO.setCrt_dt(crt_dt);
		group_memberVO.setStatus(status);
		dao.update(group_memberVO);
		return group_memberVO;
	}

	public void deleteGroup_Member(Integer group_no, Integer member_no) {
		dao.delete(group_no,  member_no);
	}

	public Group_MemberVO getOneGroup_Member(Integer group_no, Integer member_no) {
		return dao.findByPrimaryKey(group_no,  member_no);
	}

	public List<Group_MemberVO> getAll() {
		return dao.getAll();
	}
	
	public List<Group_MemberVO> getGroups(Integer member_no) {
		return dao.findGroupByMember_no(member_no);
	}
	
	
	public List<Group_MemberVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
	public Group_MemberVO leaveGroupByMem(String status, Integer group_no, Integer member_no, String pay_status) {
		Group_MemberVO group_memberVO = new Group_MemberVO();
		group_memberVO.setGroup_no(group_no);
		group_memberVO.setMember_no(member_no);
		group_memberVO.setStatus(status);
		group_memberVO.setPay_status(pay_status);
		dao.update(group_memberVO);
		return group_memberVO;
	}
	public void kickUnpaidMemberOut(Integer group_no) {
		dao.kickUnpaidMemberOut(group_no);
	}
	public int getGroupCount(Integer group_no) {
		return dao.getGroupCount(group_no);
	}
	public List<Group_MemberVO> getMembers(Integer group_no){
		return dao.findMembersByGroup_no(group_no);
	}
	public List<Group_MemberVO> getKickOutUnpaidMembers(Integer group_no){
		return dao.findUnpaidMembersByGroup_no(group_no);
	}
}
		
