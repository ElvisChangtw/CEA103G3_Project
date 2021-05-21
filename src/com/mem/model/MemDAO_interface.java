package com.mem.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.relationship.model.RelationshipVO;

public interface MemDAO_interface {
          public void insert(MemVO memVO);
          public void front_update(MemVO memVO);
          public void back_update(MemVO memVO);
          public void delete(Integer mb_no);
          public MemVO findByPrimaryKey(Integer mb_no);
          public List<MemVO> getAll();
          public MemVO getOnePic(Integer member_no);
          public void updatePic(MemVO membervo);
          public void updatePwd(MemVO membervo);
          public MemVO login_check(String mb_email, String mb_pwd);
          public MemVO account_activate(String mb_email);
		  public MemVO email_check(String mb_email);
          public Set<RelationshipVO> getRelationshipsByMemberno(Integer member_no);
		  public MemVO getPassword(String mb_email);
		  public void updateRandomPws(String mb_email, String mb_pwd);
		  
		  public List<MemVO> getAll(Map<String, String[]> map);
}
