package com.topic.model;

import java.util.List;
import java.util.Set;

import com.article.model.ArticleVO;

public interface TopicDAO_interface {
    public void insert(TopicVO topicVO);
    public void update(TopicVO topicVO);
    public void delete(Integer topicVO);
    public TopicVO findByPrimaryKey(Integer topicVO);
    public List<TopicVO> getAll();
    
	public Set<ArticleVO> getArticlesByTopicno(Integer topicno);//一對多
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<TopicVO> getAll(Map<String, String[]> map); 

}
