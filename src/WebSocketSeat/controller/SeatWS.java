package WebSocketSeat.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;

import javax.websocket.server.ServerEndpoint;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;

import WebSocketSeat.model.SeatState;


@ServerEndpoint("/SeatWS/{showtime_no}")
public class SeatWS {
	//session是websocket的連線
	private static Map<Integer, ArrayList<Session>> sessionsMap = new ConcurrentHashMap<>();
	private static Map<Session, ArrayList<String>> seatMap = new ConcurrentHashMap<>();
	
	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("showtime_no") Integer showtime_no, Session userSession) throws IOException {
		/* save the new user in the map */
		if(sessionsMap.get(showtime_no) == null) {
			ArrayList<Session> list_session = new ArrayList<Session>();
			list_session.add(userSession);
			sessionsMap.put(showtime_no, list_session);
		}else {
			sessionsMap.get(showtime_no).add(userSession);
		}
		
		ArrayList<String> seat_list = new ArrayList<String>();
		
		for(Session session : sessionsMap.get(showtime_no)) {
			if(seatMap.get(session)!=null && seatMap.get(session).size() > 0) {
				for(String seat_id : seatMap.get(session)) {
					seat_list.add(seat_id);
				}
			}
		}
		if(seat_list.size() > 0) {
			SeatState stateMessage = new SeatState("open", seat_list);
			String stateMessageJson = gson.toJson(stateMessage);
			userSession.getAsyncRemote().sendText(stateMessageJson);
		}
	}
		
	@OnMessage
	public void onMessage(Session userSession, String message, @PathParam("showtime_no") Integer showtime_no) {
		System.out.println("onMessage");
		System.out.println(message);
		
		
		
		try {
			JSONObject jsonObj = new JSONObject(message);
			System.out.println(jsonObj);
			if(jsonObj.has("type")) {
				if(((String)jsonObj.get("type")).equals("checkOrder")) {
					for(Session session : sessionsMap.get(showtime_no)) {
						if(session != userSession && userSession != null && userSession.isOpen()) {
							session.getAsyncRemote().sendText(message);
						}
					}
					// [123, 123, 123, 123, 123]
					String seat = (String) jsonObj.get("seat_id");
					int first = seat.indexOf("[") + 1;
					int last = seat.indexOf("]");
					String seat1 = seat.substring(first, last);
					System.out.println("seat1 = " + seat1);
					String seat2[] = seat1.split(",");
					ArrayList<String> list_seat = new ArrayList<String>();
					for(int i = 0; i < seat2.length; i++) {
						list_seat.add(seat2[i].trim());
						System.out.println(seat2[i]);
					}
					seatMap.put(userSession, list_seat);
					return;
				}
			}
			String seat_id = (String) jsonObj.get("seat_id");
			String seat_value = (String) jsonObj.get("seat_value");
			System.out.println(seat_id);
			System.out.println(seat_value);
			if(seatMap.get(userSession) == null) {
				ArrayList<String> list_seat = new ArrayList<String>();
				list_seat.add(seat_id);
				seatMap.put(userSession, list_seat);
			}else if("2".equals(seat_value)){
				seatMap.get(userSession).add(seat_id);
			}else if("0".equals(seat_value)) {
				seatMap.get(userSession).remove(seat_id);
			}
			
			ArrayList<Session> list = sessionsMap.get(showtime_no);
			for(Session session : list) {
				if(session != userSession && userSession != null && userSession.isOpen()) {
					session.getAsyncRemote().sendText(message);
				}
			}
			
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(@PathParam("showtime_no") Integer showtime_no, Session userSession, CloseReason reason) {
		ArrayList<String> list_seat = seatMap.get(userSession);
		System.out.println("list_seat = " + list_seat);
		System.out.println("sessionsMap.get(showtime_no) =  "+ sessionsMap.get(showtime_no).size());
		
		sessionsMap.get(showtime_no).remove(userSession);
		
		for(Session session : sessionsMap.get(showtime_no)) {
			if(list_seat != null) {
				System.out.println("list_seat.size() = " + list_seat.size());
				if(list_seat.size() > 0) {
					SeatState stateMessage = new SeatState("close", list_seat);
					System.out.println("list_seat1 = " + list_seat);
					String stateMessageJson = gson.toJson(stateMessage);
					session.getAsyncRemote().sendText(stateMessageJson);
				}
			}
		}
		System.out.println(userSession.getId() + "斷開連線");
		
	}
}
