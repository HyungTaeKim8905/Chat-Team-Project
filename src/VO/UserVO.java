package VO;

public class UserVO {
	private String id; // 아이디
	private String password; // 비밀번호
	private String nick; // 닉네임
	private String email; // 이메일
	private String address; // 주소
	private String phone; // 폰번호
	private String pictureOriginName; // 사진
	private String pictureRealName; // 사진
	private String statusmessage; // 상태 메세지

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPictureOriginName() {
		return pictureOriginName;
	}

	public void setPictureOriginName(String pictureOriginName) {
		this.pictureOriginName = pictureOriginName;
	}

	public String getPictureRealName() {
		return pictureRealName;
	}

	public void setPictureRealName(String pictureRealName) {
		this.pictureRealName = pictureRealName;
	}

	public String getStatusmessage() {
		return statusmessage;
	}

	public void setStatusmessage(String statusmessage) {
		this.statusmessage = statusmessage;
	}

}