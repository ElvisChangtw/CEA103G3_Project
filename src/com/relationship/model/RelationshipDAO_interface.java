package com.relationship.model;

import java.util.*;

public interface RelationshipDAO_interface {
          public void insert(RelationshipVO relationshipVO);
          public void update(RelationshipVO relationshipVO);
          public void delete(Integer member_no, Integer friend_no);
          public RelationshipVO findByPrimaryKey(Integer member_no, Integer friend_no);
          public List<RelationshipVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
          public List<RelationshipVO> getAllFriendno(Integer member_no);

		  public void update_status(Integer member_no, Integer friend_no);
		  public void addOneWay(RelationshipVO relationshipVO);
          public List<RelationshipVO> findByPrimaryKeyByMemno(Integer member_no);
}
