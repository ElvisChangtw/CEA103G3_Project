package com.group.model;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.group_member.model.Group_MemberVO;

public class GroupService {

	private GroupDAO_interface dao;

	public GroupService() {
		dao = new GroupDAO();
	}
	public GroupVO addGroup(Integer showtime_no, 
			Integer member_no, String group_title, Integer required_cnt, String desc, Timestamp deadline_dt) {

		GroupVO groupVO = new GroupVO();

		groupVO.setShowtime_no(showtime_no);
		groupVO.setMember_no(member_no);
		groupVO.setGroup_title(group_title);
		groupVO.setRequired_cnt(required_cnt);
		groupVO.setDesc(desc);
		groupVO.setDeadline_dt(deadline_dt);

		int group_no = dao.insert(groupVO);
		groupVO.setGroup_no(group_no);
		return groupVO;
	}

	public GroupVO updateGroup(Integer group_no, Integer showtime_no, 
			Integer member_no, String group_title, Integer required_cnt,
			String group_status, String desc, Timestamp crt_dt, 
			Timestamp modify_dt, Timestamp deadline_dt) {

		GroupVO groupVO = new GroupVO();
		groupVO.setGroup_no(group_no);
		
		groupVO.setShowtime_no(showtime_no);
		groupVO.setMember_no(member_no);
		groupVO.setGroup_title(group_title);
		groupVO.setRequired_cnt(required_cnt);
		groupVO.setGroup_status(group_status);
		groupVO.setDesc(desc);
		groupVO.setCrt_dt(crt_dt);
		groupVO.setModify_dt(modify_dt);
		groupVO.setDeadline_dt(deadline_dt);
		dao.update(groupVO);
		return groupVO;
	}

	public void deleteGroup(Integer group_no) {
		dao.delete(group_no);
	}

	public GroupVO getOneGroup(Integer group_no) {
		return dao.findByPrimaryKey(group_no);
	}

	public List<GroupVO> getAll() {
		return dao.getAll();
	}
	
	public Set<Group_MemberVO> getMembersByGroupno(Integer group_no) {
		return dao.getMembersByGroupno(group_no);
	}
	
	public List<GroupVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
	public List<GroupVO> getAllGroupByMemno(Integer memberno) {
		return dao.getAllByMemno(memberno);
	}
	public List<GroupVO> getMyGroups(Integer member_no, Integer group_status) {
		return dao.getMyGroups(member_no, group_status);
	}
	public void groupOverDue(Integer group_no) {
		dao.failure(group_no);
	}
	public void gogogo(Integer group_no) {
		dao.gogogo(group_no);
	}
	public String getGroupStatus(Integer group_no) {
		return dao.getGroupStatus(group_no);
	}
	public List<GroupVO> getStatusEquals1(){
		return dao.getStatusEquals1();
	}
	public void updateStatusFrom_1_to_2(Integer group_no, Connection con) {
		dao.updateStatusFrom_1_to_2(group_no, con);
	}
}
