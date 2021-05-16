package com.group.model;

import java.util.*;

import com.group_member.model.Group_MemberVO;

public interface GroupDAO_interface {
          public int insert(GroupVO groupVO);
          public void update(GroupVO groupVO);
          public void delete(Integer group_no);
          public GroupVO findByPrimaryKey(Integer group_no);
          public List<GroupVO> getAll();
        //�d�߬Y���Ϊ�����(�@��h)(�^�� Set)
	      public Set<Group_MemberVO> getMembersByGroupno(Integer group_no);
	      
	    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
          public List<GroupVO> getAll(Map<String, String[]> map);
          public List<GroupVO> getAllByMemno(Integer memberno);
          void failure(Integer group_no);
		  void gogogo(Integer group_no);
		  String getGroupStatus(Integer group_no);
		
}
