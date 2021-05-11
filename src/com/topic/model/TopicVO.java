package com.topic.model;

import java.io.Serializable;

public class TopicVO implements Serializable{
	private Integer topicno;
	private String topic;
	public Integer getTopicno() {
		return topicno;
	}
	public void setTopicno(Integer topicno) {
		this.topicno = topicno;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
}
