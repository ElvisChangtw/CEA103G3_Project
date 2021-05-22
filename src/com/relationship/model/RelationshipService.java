package com.relationship.model;

import java.util.List;
import java.util.Map;

import com.article.model.ArticleVO;

public class RelationshipService {

	private RelationshipDAO_interface dao;

	public RelationshipService() {
		dao = new RelationshipDAO(); 
		}

	public RelationshipVO add(Integer member_no, 
			Integer friend_no) {

		RelationshipVO relationshipVO = new RelationshipVO();

		relationshipVO = new RelationshipVO();
		relationshipVO.setMember_no(member_no);
		relationshipVO.setFriend_no(friend_no);

		dao.insert(relationshipVO);
		return relationshipVO;
	}

	public RelationshipVO updateRelationship(Integer member_no, 
			Integer friend_no, String status, String isblock) {

		RelationshipVO realtionshipVO = new RelationshipVO();
		realtionshipVO.setMember_no(member_no);
		realtionshipVO.setFriend_no(friend_no);
		realtionshipVO.setStatus(status);
		realtionshipVO.setIsblock(isblock);
		return realtionshipVO;
	}

	public void deleteRelationship(Integer member_no, Integer friend_no) {
		dao.delete(member_no,  friend_no);
	}

	public RelationshipVO getOneRelationship(Integer member_no, Integer friend_no) {
		return dao.findByPrimaryKey(member_no,  friend_no);
	}

	public List<RelationshipVO> getAll() {
		return dao.getAll();
	}
	public List<RelationshipVO> getAllFriendno(Integer member_no) {
		return dao.getAllFriendno(member_no);
	}

	public void acceptInvitation(Integer member_no, Integer friend_no) {
		dao.update_status(member_no, friend_no);
	}
	
	public RelationshipVO addOneWay(Integer member_no, 
			Integer friend_no) {

		RelationshipVO relationshipVO = new RelationshipVO();
		relationshipVO = new RelationshipVO();
		relationshipVO.setMember_no(member_no);
		relationshipVO.setFriend_no(friend_no);
		dao.addOneWay(relationshipVO);
		return relationshipVO;
	}
	public List<RelationshipVO> getOneRelationshipByMemno(Integer member_no) {
		return dao.findByPrimaryKeyByMemno(member_no);
	}
}
		
