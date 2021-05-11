package com.topic.model;

import java.util.List;
import java.util.Set;

import com.article.model.ArticleVO;

public class TopicService {

	private TopicDAO_interface dao;

	public TopicService() {
		dao = new TopicDAO();
	}

	public TopicVO addTopic(String topic) {

		TopicVO topicVO = new TopicVO();

		topicVO.setTopic(topic);

		dao.insert(topicVO);

		return topicVO;
	}
	
	public TopicVO updateTopic(Integer topicno,String topic) {

		TopicVO topicVO = new TopicVO();

		topicVO.setTopicno(topicno);
		topicVO.setTopic(topic);
	
		dao.update(topicVO);

		return topicVO;
	}
	

	public void deleteTopic(Integer topicno) {
		dao.delete(topicno);
	}

	public TopicVO getOneTopic(Integer topicno) {
		return dao.findByPrimaryKey(topicno);
	}

	public List<TopicVO> getAll() {
		return dao.getAll();
	}

	public Set<ArticleVO> getArticlesByTopicno(Integer topicno){ 	
		return dao.getArticlesByTopicno(topicno);
	}
}
