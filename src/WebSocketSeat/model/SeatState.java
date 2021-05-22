package WebSocketSeat.model;

import java.util.ArrayList;

public class SeatState {
	private String type;
	// the user changing the state
	private ArrayList<String> seat_list;
	// total users
	public String getType() {
		return type;
	}
	public SeatState(String type, ArrayList<String> seat_list) {
		super();
		this.type = type;
		this.seat_list = seat_list;
	}
	public void setType(String type) {
		this.type = type;
	}
	public ArrayList<String> getSeat_list() {
		return seat_list;
	}
	public void setSeat_list(ArrayList<String> seat_list) {
		this.seat_list = seat_list;
	}

}
