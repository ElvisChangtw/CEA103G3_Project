package websocket.notify.model;

public class Notify {
	
	private String type;
	private int sender;
	private String receiver;
	private String message;
	private String time;
	private String read;
	
	

	public Notify() {};
	
	public Notify(String type, int sender, String receiver, String message, String time, String read) {
		super();
		this.type=type;
		this.sender=sender;
		this.receiver=receiver;
		this.message=message;
		this.setTime(time);
		this.read=read;
	}
	
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getSender() {
		return sender;
	}
	public void setSender(int sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getRead() {
		return read;
	}

	public void setRead(String read) {
		this.read = read;
	}
	

}
