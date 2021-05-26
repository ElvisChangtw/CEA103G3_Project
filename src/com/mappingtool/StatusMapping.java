package com.mappingtool;

public class StatusMapping {
	
	public StatusMapping() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public String dboGroup_GroupStatus(String group_status){
	        String resultString;
	        if("0".equals(group_status))
	        	resultString = "揪團中";
	        else if ("1".equals(group_status))
	        	resultString = "確定出團!等待團員付款中";
	        else if("2".equals(group_status))
	        	resultString = "正常出團，結束";
	        else if("3".equals(group_status))
	        	resultString = "條件失敗，結束";
	        else
	        	resultString = "未知的揪團狀態";
		return resultString;
	}
	
	public String dboGroup_Member_Pay_Status(String pay_status){
        String resultString;
        if("0".equals(pay_status))
        	resultString = "未付款";
        else if ("1".equals(pay_status))
        	resultString = "已付款";
        else
        	resultString = "未知的付款狀態";
	return resultString;
	}
	
	
	public String dboGroup_Member_Status(String status){
        String resultString;
        if("0".equals(status))
        	resultString = "退出";
        else if ("1".equals(status))
        	resultString = "已加入";
        else
        	resultString = "未知的團員狀態";
	return resultString;
	}
	
	
	public String dboReport_Group_Status(String status){
        String resultString;
        if("0".equals(status))
        	resultString = "未處理";
        else if ("1".equals(status))
        	resultString = "已處理";
        else if ("2".equals(status))
        	resultString = "處理未通過";
        else
        	resultString = "未知的檢舉狀態";
	return resultString;
	}
	
	
	public String dboRelationship_Status(String status){
        String resultString;
        if("0".equals(status))
        	resultString = "下線";
        else if ("1".equals(status))
        	resultString = "上線";
        else if ("2".equals(status))
        	resultString = "送出請求尚未被同意";
        else
        	resultString = "未知的好友狀態";
	return resultString;
	}
	
	
	public String dboRelationship_IsBlock(String isBlock){
        String resultString;
        if("0".equals(isBlock))
        	resultString = "未封鎖";
        else if ("1".equals(isBlock))
        	resultString = "已封鎖";
        else
        	resultString = "未知的封鎖狀態";
	return resultString;
	}
	public String dboOrderStatus(String orderStatus){
		String resultString;
		if("0".equals(orderStatus))
			resultString = "未付款";
		else if ("1".equals(orderStatus))
			resultString = "已取消";
		else if ("2".equals(orderStatus))
			resultString = "未取票";
		else 
			resultString = "已取票";
		return resultString;
	}
	public String dboOrderType(String orderType){
		String resultString;
		if("0".equals(orderType))
			resultString = "信用卡";
		else if ("1".equals(orderType))
			resultString = "現金";
		else
			resultString = "現場付款";
		return resultString;
	}
}
