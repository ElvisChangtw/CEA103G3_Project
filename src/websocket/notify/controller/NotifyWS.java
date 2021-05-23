package websocket.notify.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


import com.google.gson.Gson;
import com.group.model.GroupService;
import com.group.model.GroupVO;
import com.group_member.model.Group_MemberService;
import com.group_member.model.Group_MemberVO;
import com.mem.model.MemService;
import com.movie.model.MovieService;

import websocket.jedis.JedisHandleMessage;
import websocket.notify.model.Notify;

@ServerEndpoint("/NotifyWS/{userName}")
public class NotifyWS {
	private static Map<Integer, Session> sessionsMap = new ConcurrentHashMap<>();

	Gson gson = new Gson();
	

	@OnOpen
	public void onOpen(@PathParam("userName") int userName, Session userSession) throws IOException {
		sessionsMap.put(userName, userSession);
		System.out.println("我是: "+userName);
		System.out.println("我的session: "+ userSession);
	}
	
	@OnMessage
	public void onMessage(Session userSession, String message) {
		Group_MemberService gmSvc = new Group_MemberService();
		GroupService gSvc = new GroupService();
		MovieService movieSvc = new MovieService();
		MemService memSvc = new MemService();
	
		Notify notify = gson.fromJson(message, Notify.class);
		int sender = notify.getSender();
		String receiver = notify.getReceiver();
		String timeStr = notify.getTime();
		String read = "N";
		
		//送出好友邀請
		if("addFriend".equals(notify.getType())){
			
			Session receiverSession = sessionsMap.get(new Integer(receiver));
			
			String sendName = memSvc.getOneMem(sender).getMb_name();
			String receiveName = memSvc.getOneMem(new Integer(receiver)).getMb_name();
			
			String receiverText = sendName+"邀請你成為好友";
			String senderText = "您已邀請"+receiveName+"成為好友";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);
			Notify receiverMsg = new Notify(notify.getType(),sender, receiver, receiverText, timeStr, read);
			String receiverMsgJson = gson.toJson(receiverMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);
			JedisHandleMessage.saveChatMessage(String.valueOf(receiver), notify.getType(), receiverMsgJson);
			
			
			if (receiverSession != null && receiverSession.isOpen()) {
			receiverSession.getAsyncRemote().sendText(receiverMsgJson);
			userSession.getAsyncRemote().sendText(senderMsgJson);
			}
			return;
		}
		
		//團員加入揪團(receiver:group_no)
		if("addGroup".equals(notify.getType())){

			String group_name = gSvc.getOneGroup(new Integer(receiver)).getGroup_title();
			String sender_name = memSvc.getOneMem(sender).getMb_name();
			
			List<Group_MemberVO> list = gmSvc.getMembers(new Integer(receiver));
			List<Integer> gmList = new ArrayList<Integer>();
			Set<Integer> memNOs = sessionsMap.keySet();  //取出團內所有成員
			
			for(Group_MemberVO gmVO : list) {
				for(int memNO:memNOs) {
					if(gmVO.getMember_no()==memNO) {
						gmList.add(memNO);
					}
				}
			}
			String receiverText = sender_name+"已加入揪團:"+group_name;
			String senderText = "您已加入揪團:"+group_name;
			
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);
			Notify receiverMsg = new Notify(notify.getType(),sender, receiver, receiverText, timeStr, read);
			String receiverMsgJson = gson.toJson(receiverMsg);
			//新成員收到加入揪團訊息並存在redis
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);
			//其餘團員被通知有新團員加入並存在redis
			for(Integer memno:gmList) {
				JedisHandleMessage.saveChatMessage(String.valueOf(memno), notify.getType(), receiverMsgJson);
			}
			
			userSession.getAsyncRemote().sendText(senderMsgJson);
			for(int i = 0 ; i<gmList.size();i++) {
				Session receiverSession = sessionsMap.get(gmList.get(i));
				if (receiverSession != null && receiverSession.isOpen()) {
				receiverSession.getAsyncRemote().sendText(receiverMsgJson);
				}
			}
			
			return;
		}
		
		//點擊確認預定電影票(還未付款)
		if("buyTicket".equals(notify.getType())){
			
			String movieName = movieSvc.getOneMovie(new Integer(receiver)).getMoviename();

			String senderText = "您已成功預訂電影:"+movieName+"，請在開演前半小時付款，謝謝!";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);


			userSession.getAsyncRemote().sendText(senderMsgJson);
			return;
		}
		
		//收到交友邀請點選確認
		if("response".equals(notify.getType())){
			
			Session receiverSession = sessionsMap.get(new Integer(receiver));
			
			String sendName = memSvc.getOneMem(sender).getMb_name();
			String receiveName = memSvc.getOneMem(new Integer(receiver)).getMb_name();

			String receiverText = sendName+"已接受您的交友邀請";
			String senderText = "您與"+receiveName+"已成為好友";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);
			Notify receiverMsg = new Notify(notify.getType(),sender, receiver, receiverText, timeStr, read);
			String receiverMsgJson = gson.toJson(receiverMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);
			JedisHandleMessage.saveChatMessage(String.valueOf(receiver), notify.getType(), receiverMsgJson);

			
			if (receiverSession != null && receiverSession.isOpen()) {
			receiverSession.getAsyncRemote().sendText(receiverMsgJson);
			userSession.getAsyncRemote().sendText(senderMsgJson);
			}
			return;
			
		}
		
		//團主新增揪團
		if("createGroup".equals(notify.getType())){

			String senderText = "您已成功建立揪團:"+receiver;
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);

			userSession.getAsyncRemote().sendText(senderMsgJson);
			return;
			
		}
		
		//到deadline團主未點擊出團出現解散揪團通知
		if("dismissGroup".equals(notify.getType())){
			String group_name = gSvc.getOneGroup(new Integer(receiver)).getGroup_title();
			//將有些時間是timestamp格式把秒跟毫秒去掉
//			SimpleDateFormat dateformatAll= new SimpleDateFormat("yyyy-MM-dd HH:mm");
//			String timeStrr = dateformatAll.format(timeStr);
			
			List<Group_MemberVO> list = gmSvc.getMembers(new Integer(receiver));
			List<Integer> gmList = new ArrayList<Integer>();
			Set<Integer> memNOs = sessionsMap.keySet();  //取出所有連線者
			
			for(Group_MemberVO gmVO : list) {
				for(int memNO:memNOs) {
					if(gmVO.getMember_no()==memNO) {
						gmList.add(memNO);
					}
				}
			}
			String senderText = "揪團:"+group_name+"因未在截止日前出團已被取消";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);

			for(Integer memno : gmList) {
				JedisHandleMessage.saveChatMessage(String.valueOf(memno), notify.getType(), senderMsgJson);
			}
			
			//所有團員皆會收到解散揪團通知
			for(Integer memno:gmList) {
				for(Integer userName: sessionsMap.keySet()) {
					if(memno==userName) {
						Session sendSession = sessionsMap.get(userName);
						if (sendSession != null && sendSession.isOpen()) {
								sendSession.getAsyncRemote().sendText(senderMsgJson);
						}
					}
					
				} 
				
			}
			return;
			
		}
		
		//團主出團通知
		if("goGroup".equals(notify.getType())){
			String group_name = gSvc.getOneGroup(new Integer(receiver)).getGroup_title();
			List<Group_MemberVO> list = gmSvc.getMembers(new Integer(receiver));
			List<Integer> gmList = new ArrayList<Integer>();
			Set<Integer> memNOs = sessionsMap.keySet();  //取出所有連線者
			
			for(Group_MemberVO gmVO : list) {
				for(int memNO:memNOs) {
					if(gmVO.getMember_no()==memNO) {
						gmList.add(memNO);
					}
				}
			}
			String senderText = "揪團:"+group_name+"已出團，請在場次開演前一小時付款，謝謝!";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);

			for(Integer memno : gmList) {
				JedisHandleMessage.saveChatMessage(String.valueOf(memno), notify.getType(), senderMsgJson);
			}
			
			//所有團員皆會收到解散揪團通知
			for(Integer memno:gmList) {
				for(Integer userName: sessionsMap.keySet()) {
					if(memno==userName) {
						Session sendSession = sessionsMap.get(userName);
						if (sendSession != null && sendSession.isOpen()) {
								sendSession.getAsyncRemote().sendText(senderMsgJson);
						}
					}
					
				} 
				
			}
			return;
			
		}
		
		//團主更改揪團條件，所有團員被踢出
		if("kickoffGroup".equals(notify.getType())){
			String group_name = gSvc.getOneGroup(new Integer(receiver)).getGroup_title();
			List<Group_MemberVO> list = gmSvc.getMembers(new Integer(receiver));
			List<Integer> gmList = new ArrayList<Integer>();
			Set<Integer> memNOs = sessionsMap.keySet();  //取出所有連線者
			
			for(Group_MemberVO gmVO : list) {
				for(int memNO:memNOs) {
					if(gmVO.getMember_no()==memNO) {
						gmList.add(memNO);
					}
				}
			}
			String senderText = "揪團:"+group_name+"條件已被修改，請重新加入揪團，謝謝!";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);
			
			for(Integer memno : gmList) {
				JedisHandleMessage.saveChatMessage(String.valueOf(memno), notify.getType(), senderMsgJson);
			}
			
			//所有團員皆會收到解散揪團通知
			for(Integer memno:gmList) {
				for(Integer userName: sessionsMap.keySet()) {
					if(memno==userName) {
						Session sendSession = sessionsMap.get(userName);
						if (sendSession != null && sendSession.isOpen()) {
							sendSession.getAsyncRemote().sendText(senderMsgJson);
						}
					}
					
				} 
				
			}
			return;
			
		}
		
		//到開演前一小時未付款，將未付款團員剔除
		if("kickUnpaid".equals(notify.getType())){
			String group_name = gSvc.getOneGroup(new Integer(receiver)).getGroup_title();
			
			//將有些時間是timestamp格式把秒跟毫秒去掉
//			SimpleDateFormat dateformatAll= new SimpleDateFormat("yyyy-MM-dd HH:mm");
//			String timeStrr = dateformatAll.format(timeStr);
			List<Group_MemberVO> list = gmSvc.getKickOutUnpaidMembers(new Integer(receiver));
			int kick_cnt = list.size();
			List<Integer> gmList = new ArrayList<Integer>();
			Set<Integer> memNOs = sessionsMap.keySet();  //取出所有連線者
			
			for(Group_MemberVO gmVO : list) {
				for(int memNO:memNOs) {
					if(gmVO.getMember_no()==memNO) {
						gmList.add(memNO);
					}
				}
			}
			//團主收到的通知
			String senderText = "您的揪團:"+group_name+"有"+kick_cnt+"位團員，因在開演前未付款已被踢除";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);
			
			//被剔除團員收到的通知
			String receiverText = "您未在電影開演前一小時付款，已被踢除揪團:"+group_name;
			Notify receiverMsg = new Notify(notify.getType(),sender, receiver, receiverText, timeStr, read);
			String receiverMsgJson = gson.toJson(receiverMsg);
			
			//團主存的redis
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);
			
			//被剔除團員存的redis
			for(Integer memno : gmList) {
				JedisHandleMessage.saveChatMessage(String.valueOf(memno), notify.getType(), receiverMsgJson);
			}
			
			//傳送團主通知
			Session masterSession = sessionsMap.get(sender);
			masterSession.getAsyncRemote().sendText(senderMsgJson);
			
			//所有未付款團員皆會收到剔除揪團通知
			for(Integer memno:gmList) {
				for(Integer userName: sessionsMap.keySet()) {
					if(memno==userName) {
						Session sendSession = sessionsMap.get(userName);
						if (sendSession != null && sendSession.isOpen()) {
							sendSession.getAsyncRemote().sendText(receiverMsgJson);
						}
					}
					
				} 
				
			}
			return;
			
		}
		
		if("reminder".equals(notify.getType())){
			
			Session receiverSession = sessionsMap.get(new Integer(receiver));
			
			String sendName = memSvc.getOneMem(sender).getMb_name();
			String receiveName = memSvc.getOneMem(new Integer(receiver)).getMb_name();
			
			String receiverText = "提醒您，請在電影開演前一小時付款，謝謝";
			String senderText = "已送出您的付款提醒給"+receiveName;
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);
			Notify receiverMsg = new Notify(notify.getType(),sender, receiver, receiverText, timeStr, read);
			String receiverMsgJson = gson.toJson(receiverMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);
			JedisHandleMessage.saveChatMessage(String.valueOf(receiver), notify.getType(), receiverMsgJson);
			
			
			if (receiverSession != null && receiverSession.isOpen()) {
			receiverSession.getAsyncRemote().sendText(receiverMsgJson);
			userSession.getAsyncRemote().sendText(senderMsgJson);
			}
			return;
		}
		
		//團主主動解散揪團通知
		if("activeDismissGroup".equals(notify.getType())){
			String masterName = memSvc.getOneMem(gSvc.getOneGroup(new Integer(receiver)).getMember_no()).getMb_name();
			String group_name = gSvc.getOneGroup(new Integer(receiver)).getGroup_title();
			List<Group_MemberVO> list = gmSvc.getMembers(new Integer(receiver));
			List<Integer> gmList = new ArrayList<Integer>();
			Set<Integer> memNOs = sessionsMap.keySet();  //取出所有連線者
			
			for(Group_MemberVO gmVO : list) {
				for(int memNO:memNOs) {
					if(gmVO.getMember_no()==memNO) {
						gmList.add(memNO);
					}
				}
			}
			String senderText = "團主:"+masterName+"已解散揪團:"+group_name;
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr, read);
			String senderMsgJson = gson.toJson(senderMsg);

			for(Integer memno : gmList) {
				JedisHandleMessage.saveChatMessage(String.valueOf(memno), notify.getType(), senderMsgJson);
			}
			
			//所有團員皆會收到解散揪團通知
			for(Integer memno:gmList) {
				for(Integer userName: sessionsMap.keySet()) {
					if(memno==userName) {
						Session sendSession = sessionsMap.get(userName);
						if (sendSession != null && sendSession.isOpen()) {
								sendSession.getAsyncRemote().sendText(senderMsgJson);
						}
					}
					
				} 
				
			}
			return;
			
		}
		
		
		
	}
	
	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		Set<Integer> userNames = sessionsMap.keySet();
		for (int userName : userNames) {
			if (sessionsMap.get(userName).equals(userSession)) {
				sessionsMap.remove(userName);
				break;
			}
		}

		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
				reason.getCloseCode().getCode(), userNames);
		System.out.println(text);
	}


}


