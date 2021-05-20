package com.group.model;

import java.sql.Connection;
import java.util.*;

import com.group_member.model.Group_MemberVO;

public interface GroupDAO_interface {
	public int insert(GroupVO groupVO);
	public void update(GroupVO groupVO);
	public void delete(Integer group_no);
	public GroupVO findByPrimaryKey(Integer group_no);
	public List<GroupVO> getAll();
	//查詢某揪團的成員(一對多)(回傳 Set)
	public Set<Group_MemberVO> getMembersByGroupno(Integer group_no);
	  
	//萬用複合查詢(傳入參數型態Map)(回傳 List)
	public List<GroupVO> getAll(Map<String, String[]> map);
	public List<GroupVO> getAllByMemno(Integer memberno);
	public void failure(Integer group_no);
	public void gogogo(Integer group_no);
	public String getGroupStatus(Integer group_no);
	public List<GroupVO> getStatusEquals1();
	public void updateStatusFrom_1_to_2(Integer group_no, Connection con);
	public List<GroupVO> getMyGroups(int member_no, int group_status);
		
}
