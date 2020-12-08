package VO;

public class ChatRoomVO {
	private int no;
	private String fromID;
	private String toID;
	private String content;
	private String date;

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getFromID() {
		return fromID;
	}

	public void setFromID(String fromID) {
		this.fromID = fromID;
	}

	public String getToID() {
		return toID;
	}

	public void setToID(String toID) {
		this.toID = toID;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
