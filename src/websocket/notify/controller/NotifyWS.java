package websocket.notify.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.group.model.GroupService;
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
		
		if("addFriend".equals(notify.getType())){
			
			Session receiverSession = sessionsMap.get(new Integer(receiver));
			
			String sendName = memSvc.getOneMem(sender).getMb_name();
			String receiveName = memSvc.getOneMem(new Integer(receiver)).getMb_name();
			
			String receiverText = sendName+"邀請你成為好友";
			String senderText = "您已邀請"+receiveName+"成為好友";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr);
			String senderMsgJson = gson.toJson(senderMsg);
			Notify receiverMsg = new Notify(notify.getType(),sender, receiver, receiverText, timeStr);
			String receiverMsgJson = gson.toJson(receiverMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);
			JedisHandleMessage.saveChatMessage(String.valueOf(receiver), notify.getType(), receiverMsgJson);
			
			
			if (receiverSession != null && receiverSession.isOpen()) {
			receiverSession.getAsyncRemote().sendText(receiverMsgJson);
			userSession.getAsyncRemote().sendText(senderMsgJson);
			}
			return;
		}
		
		if("addGroup".equals(notify.getType())){

			String group_name = gSvc.getOneGroup(new Integer(receiver)).getGroup_title();
			String sender_name = memSvc.getOneMem(sender).getMb_name();
			
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
			String receiverText = sender_name+"已加入揪團:"+group_name;
			String senderText = "您已加入揪團:"+group_name;
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr);
			String senderMsgJson = gson.toJson(senderMsg);
			Notify receiverMsg = new Notify(notify.getType(),sender, receiver, receiverText, timeStr);
			String receiverMsgJson = gson.toJson(receiverMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);
			JedisHandleMessage.saveChatMessage(String.valueOf(receiver), notify.getType(), receiverMsgJson);
			userSession.getAsyncRemote().sendText(senderMsgJson);
			
			for(int i = 0 ; i<gmList.size();i++) {
				Session receiverSession = sessionsMap.get(gmList.get(i));
				if (receiverSession != null && receiverSession.isOpen()) {
				receiverSession.getAsyncRemote().sendText(receiverMsgJson);
				}
			}
			
			return;
		}
		
		if("buyTicket".equals(notify.getType())){
			
			String movieName = movieSvc.getOneMovie(new Integer(receiver)).getMoviename();

			String senderText = "您已成功預訂電影:"+movieName+"，請在開演前半小時付款，謝謝!";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr);
			String senderMsgJson = gson.toJson(senderMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);


			userSession.getAsyncRemote().sendText(senderMsgJson);
			return;
		}
		if("response".equals(notify.getType())){
			
			Session receiverSession = sessionsMap.get(new Integer(receiver));
			
			String sendName = memSvc.getOneMem(sender).getMb_name();
			String receiveName = memSvc.getOneMem(new Integer(receiver)).getMb_name();

			String receiverText = sendName+"已接受您的交友邀請";
			String senderText = "您與"+receiveName+"已成為好友";
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr);
			String senderMsgJson = gson.toJson(senderMsg);
			Notify receiverMsg = new Notify(notify.getType(),sender, receiver, receiverText, timeStr);
			String receiverMsgJson = gson.toJson(receiverMsg);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);
			JedisHandleMessage.saveChatMessage(String.valueOf(receiver), notify.getType(), receiverMsgJson);

			
			if (receiverSession != null && receiverSession.isOpen()) {
			receiverSession.getAsyncRemote().sendText(receiverMsgJson);
			userSession.getAsyncRemote().sendText(senderMsgJson);
			}
			return;
			
		}
		if("createGroup".equals(notify.getType())){

			String senderText = "您已成功建立揪團:"+receiver;
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr);
			String senderMsgJson = gson.toJson(senderMsg);
			System.out.println(senderMsgJson);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);

			userSession.getAsyncRemote().sendText(senderMsgJson);
			return;
			
		}
		
	}

}
