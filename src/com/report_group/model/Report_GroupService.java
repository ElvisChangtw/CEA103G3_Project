package com.report_group.model;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import com.group_member.model.Group_MemberVO;

public class Report_GroupService {

	private Report_GroupDAO_interface dao;

	public Report_GroupService() {
		dao = new Report_GroupDAO();
	}
	
	public Report_GroupVO addReport_Group(Integer group_no,
			String content, Integer member_no) {
		
		Report_GroupVO report_groupVO = new Report_GroupVO();
		report_groupVO.setGroup_no(group_no);
		report_groupVO.setContent(content);
		report_groupVO.setMember_no(member_no);
		dao.insert(report_groupVO);
		return report_groupVO;
	}
	
	public Report_GroupVO updateReport_Group(Integer report_no, 
			String status, String desc) {
		Report_GroupVO report_groupVO = new Report_GroupVO();
		report_groupVO.setReport_no(report_no);
		report_groupVO.setStatus(status);
		report_groupVO.setDesc(desc);
		dao.update(report_groupVO);
		report_groupVO = getOneReport_Group(report_no);
		return report_groupVO;
	}

	public void deleteReport_Group(Integer report_no) {
		dao.delete(report_no);
	}
	
	public Report_GroupVO getOneReport_Group(Integer report_no) {
		return dao.findByPrimaryKey(report_no);
	}
	
	public List<Report_GroupVO> getAll() {
		return dao.getAll();
	}
	
	public Set<Report_GroupVO> getReportsByStatus(String status) {
		return dao.getReportsByStatus(status);
	}
}
