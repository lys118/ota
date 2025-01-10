package ota.model.dto;

import java.sql.Date;

public class UserDTO {
	private String userID;
	private String userPassword;
	private String userName;
	private String userEmail;
	private String userPhone;
	private String userPostcode;
	private String userAddress;
	private String userDetailAddress;
	private Date userJoinDate;
	
	public UserDTO() {
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserPostcode() {
		return userPostcode;
	}

	public void setUserPostcode(String userPostcode) {
		this.userPostcode = userPostcode;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public String getUserDetailAddress() {
		return userDetailAddress;
	}

	public void setUserDetailAddress(String userDetailAddress) {
		this.userDetailAddress = userDetailAddress;
	}

	public Date getUserJoinDate() {
		return userJoinDate;
	}

	public void setUserJoinDate(Date userJoinDate) {
		this.userJoinDate = userJoinDate;
	}

	@Override
	public String toString() {
		return "UserDTO [userID=" + userID + ", userPassword=" + userPassword + ", userName=" + userName
				+ ", userEmail=" + userEmail + ", userPhone=" + userPhone + ", userPostcode=" + userPostcode
				+ ", userAddress=" + userAddress + ", userDetailAddress=" + userDetailAddress + ", userJoinDate="
				+ userJoinDate + "]";
	}

}
