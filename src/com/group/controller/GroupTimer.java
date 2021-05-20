package com.group.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import com.group.model.GroupService;
import com.group.model.GroupVO;
import com.group_member.model.Group_MemberService;

public class GroupTimer extends Timer{
	//instance variables
	private Map<Integer, TimerTask_Dismiss> dismissMap = new HashMap<Integer, TimerTask_Dismiss>();
	private Map<Integer, TimerTask_KickOut> kickOutMap = new HashMap<Integer, TimerTask_KickOut>();
	//新增揪團失敗排程器
	public void addDismissTask(GroupVO groupVO) {
		TimerTask_Dismiss timerTask = new TimerTask_Dismiss(groupVO);
		this.dismissMap.put(timerTask.getGroupVO().getGroup_no(), timerTask);
		System.out.println("加入揪團失敗排程器....");
		System.out.println("揪團編號" + timerTask.getGroupVO().getGroup_no() + "將於Deadline: " + timerTask.getGroupVO().getDeadline_dt() + "截止");
		this.schedule( timerTask  , groupVO.getDeadline_dt()); 
	}
	//取得揪團失敗排程器
	public TimerTask_Dismiss getDismissTask(int group_no) {
		return this.dismissMap.get(group_no);
	}
	//取消揪團失敗排程器
	public void cancelDismissTask(int group_no) {
		
		TimerTask_Dismiss dismissTask =getDismissTask(group_no);
		if (dismissTask != null) {
			dismissTask.cancel();
			this.dismissMap.remove(group_no);
			System.out.println("取消編號:" + group_no +" 的揪團失敗排程器");
		}
		else
			System.out.println("無編號:" + group_no +" 的揪團失敗排程器");
	}
	//新增剔除未付款團員排程器
	public void addKickOutTask(GroupVO groupVO) {
		TimerTask_KickOut timerTask = new TimerTask_KickOut(groupVO);
		this.kickOutMap.put(timerTask.getGroupVO().getGroup_no(), timerTask);
		System.out.println("加入剔除未付款團員排程器...");
		System.out.println("將於Deadline: " + timerTask.getGroupVO().getDeadline_dt() + "清除揪團編號" + timerTask.getGroupVO().getGroup_no() + "之未付款團員");
		this.schedule( timerTask  , groupVO.getDeadline_dt()); 
	}
	//取得剔除未付款團員排程器
	public TimerTask_KickOut getKickTask(int group_no) {
		return this.kickOutMap.get(group_no);
	}
	//取消揪團失敗排程器
		public void cancelKickOutDismissTask(int group_no) {
			System.out.println("取消編號:" + group_no +" 的剔除未付款團員排程器");
			getKickTask(group_no).cancel();
			this.kickOutMap.remove(group_no);
		}

	@Override
	public void cancel() {
		super.cancel();
		System.out.println("排程器已全部取消!");
	}
	
}
//解散揪團排程器Class
class TimerTask_Dismiss extends TimerTask {
	private GroupVO groupVO;
	public GroupVO getGroupVO() {
		return groupVO;
	}
	public void setGroupVO(GroupVO groupVO) {
		this.groupVO = groupVO;
	}
	public TimerTask_Dismiss(GroupVO groupVO) {
		super();
		this.groupVO = groupVO;
	}
	@Override
	public void run() {
		GroupService groupSvc = new GroupService();
		groupSvc.groupOverDue(this.groupVO.getGroup_no());
		System.out.println("揪團編號: " + this.groupVO.getGroup_no() + "超過截止時間, 揪團失敗!!!");
	}
}

//踢掉未付款團員排程器Class
class TimerTask_KickOut extends TimerTask {
	private GroupVO groupVO;
	public GroupVO getGroupVO() {
		return groupVO;
	}
	public void setGroupVO(GroupVO groupVO) {
		this.groupVO = groupVO;
	}
	public TimerTask_KickOut(GroupVO groupVO) {
		super();
		this.groupVO = groupVO;
	}
	@Override
	public void run() {
		Group_MemberService group_memberSvc = new Group_MemberService();
		group_memberSvc.kickUnpaidMemberOut(this.groupVO.getGroup_no());
		System.out.println("揪團編號: " + this.groupVO.getGroup_no() + "之未付款團員已剔除完成!!!");
		System.out.println("揪團編號: " + this.groupVO.getGroup_no() + "狀態更改為正常出團，結束!!!");
	}
}