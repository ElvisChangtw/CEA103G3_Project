package com.report_group.model;

import java.util.*;

import com.group_member.model.Group_MemberVO;

public interface Report_GroupDAO_interface {
          public void insert(Report_GroupVO report_groupVO);
          public void update(Report_GroupVO report_groupVO);
          public void delete(Integer report_no);
          public Report_GroupVO findByPrimaryKey(Integer report_no);
          public List<Report_GroupVO> getAll();

          //萬用複合查詢(傳入參數型態Map)(回傳 List)
          
        //查詢某狀態的檢舉(回傳 Set)
	      public Set<Report_GroupVO> getReportsByStatus(String status);
          
          
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
