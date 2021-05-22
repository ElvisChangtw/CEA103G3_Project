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
	private static Map<Integer, ArrayList<String>> seatMap = new ConcurrentHashMap<>();
	
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
		
		if(seatMap.get(showtime_no) != null) {
			ArrayList<String> seat_list = seatMap.get(showtime_no);
			SeatState stateMessage = new SeatState("open", seat_list);
			String stateMessageJson = gson.toJson(stateMessage);
			userSession.getAsyncRemote().sendText(stateMessageJson);
		}
		
//		for(Session session : sessionsMap.get(showtime_no)) {
//			System.out.println(session.getId());
//		}
//		try {
//			jsonObj.put("seat_list", seat_list);
//			String json_obj = gson.toJson(jsonObj);
//		} catch (JSONException e) {
//			e.printStackTrace();
//		}
	}

	@OnMessage
	public void onMessage(Session userSession, String message, @PathParam("showtime_no") Integer showtime_no) {
		
		ArrayList<Session> list = sessionsMap.get(showtime_no);
		for(Session session : list) {
			if(session != userSession && userSession != null && userSession.isOpen()) {
				session.getAsyncRemote().sendText(message);
			}
		}
		System.out.println(message);
		
		try {
			JSONObject jsonObj = new JSONObject(message);
			String seat_id = (String) jsonObj.get("seat_id");
			String seat_value = (String) jsonObj.get("seat_value");
			System.out.println(seat_id);
			System.out.println(seat_value);
			if(seatMap.get(showtime_no) == null) {
				ArrayList<String> list_seat = new ArrayList<String>();
				list_seat.add(seat_id);
				seatMap.put(showtime_no, list_seat);
			}else if("2".equals(seat_value)){
				seatMap.get(showtime_no).add(seat_id);
			}else if("0".equals(seat_value)) {
				seatMap.get(showtime_no).remove(seat_id);
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
		for(Session session : sessionsMap.get(showtime_no)) {
			if (session.equals(userSession)) {
				sessionsMap.get(showtime_no).remove(userSession);
				break;
			}
		}
		
//		try {
//			JSONObject jsonObj = new JSONObject(message);
//			System.out.println("message");
//			
//			
//		} catch (JSONException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		
	}
}
