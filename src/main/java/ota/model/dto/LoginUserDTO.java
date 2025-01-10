package ota.model.dto;

public class LoginUserDTO {
	private String userID;
	private String userName;
	private String userEmail;
	
	public LoginUserDTO() {
	}

	public LoginUserDTO(String userID, String userName, String userEmail) {
		this.userID = userID;
		this.userName = userName;
		this.userEmail = userEmail;
	}

	public String getUserID() {
		return userID;
	}

	public String getUserName() {
		return userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	@Override
	public String toString() {
		return "LoginUserDTO [userID=" + userID + ", userName=" + userName + ", userEmail=" + userEmail + "]";
	}
	
	

	
	
}
