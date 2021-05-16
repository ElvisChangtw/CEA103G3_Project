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
		System.out.println("�ڬO: "+userName);
		System.out.println("�ڪ�session: "+ userSession);
		
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
			
			String receiverText = sendName+"�ܽЧA�����n��";
			String senderText = "�z�w�ܽ�"+receiveName+"�����n��";
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
			Set<Integer> memNOs = sessionsMap.keySet();  //���X�Ҧ��s�u��
			
			for(Group_MemberVO gmVO : list) {
				for(int memNO:memNOs) {
					if(gmVO.getMember_no()==memNO) {
						gmList.add(memNO);
					}
				}
			}
			String receiverText = sender_name+"�w�[�J����:"+group_name;
			String senderText = "�z�w�[�J����:"+group_name;
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

			String senderText = "�z�w���\�w�q�q�v:"+movieName+"�A�Цb�}�t�e�b�p�ɥI�ڡA����!";
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

			String receiverText = sendName+"�w�����z������ܽ�";
			String senderText = "�z�P"+receiveName+"�w�����n��";
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

			String senderText = "�z�w���\�إߴ���:"+receiver;
			Notify senderMsg = new Notify(notify.getType(),sender, receiver, senderText, timeStr);
			String senderMsgJson = gson.toJson(senderMsg);
			System.out.println(senderMsgJson);
			JedisHandleMessage.saveChatMessage(String.valueOf(sender), notify.getType(), senderMsgJson);

			userSession.getAsyncRemote().sendText(senderMsgJson);
			return;
			
		}
		
	}

}
