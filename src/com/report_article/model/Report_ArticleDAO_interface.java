package com.report_article.model;

import java.util.List;

public interface Report_ArticleDAO_interface {
    public void insert(Report_ArticleVO report_articleVO);
    public void update(Report_ArticleVO report_articleVO);
    public void delete(Integer report_articleVO);
    public Report_ArticleVO findByPrimaryKey(Integer reportno);
    public List<Report_ArticleVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<Report_articleVO> getAll(Map<String, String[]> map); 
}
