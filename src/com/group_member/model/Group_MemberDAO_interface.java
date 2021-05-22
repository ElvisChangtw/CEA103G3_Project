package com.group_member.model;

import java.util.*;

public interface Group_MemberDAO_interface {
          public void insert(Group_MemberVO group_memberVO);
          public void update(Group_MemberVO group_memberVO);
          public void delete(Integer group_no, Integer member_no);
          public Group_MemberVO findByPrimaryKey(Integer group_no, Integer member_no);
          public List<Group_MemberVO> findGroupByMember_no(Integer member_no);
          
          public List<Group_MemberVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
          public List<Group_MemberVO> getAll(Map<String, String[]> map);
		  public void kickUnpaidMemberOut(Integer group_no); 
		  
		  public int getGroupCount(Integer group_no);
		  public List<Group_MemberVO> findMembersByGroup_no(Integer group_no);
		  public List<Group_MemberVO> findUnpaidMembersByGroup_no(Integer group_no);
}
