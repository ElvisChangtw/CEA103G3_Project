package com.report_comment.model;

import java.util.*;

public interface ReportCommentDAO_interface {
	
	public void insert(ReportCommentVO reportcommentVO);
    public void update(ReportCommentVO reportcommentVO);
    public void delete(Integer reportno);
    public ReportCommentVO findByPrimaryKey(Integer reportno);
    public List<ReportCommentVO> getAll();

}
