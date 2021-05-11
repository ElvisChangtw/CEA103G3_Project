package com.group.model;

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
		
}
