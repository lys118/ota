package ota.model.dto;

import java.sql.Timestamp;
import java.util.List;

public class ContactUsDto {
	private int contactUsId;
	private String contactUsUserType;
	private String contactUsUserId;
	private String contactUsUserName;
	private String contactUsUserEmail;
	private String contactUsType;
	private String contactUsTitle;
	private String contactUsContent;
	private Timestamp contactUsPostDate;
	private String contactUsAdminResponse;
	private boolean contactUsResponseStatus;
	private List<ContactUsImgDto> contactUsImgList;
	
	public ContactUsDto() {
	}

	public ContactUsDto(int contactUsId, String contactUsUserType, String contactUsUserId, String contactUsUserName,
			String contactUsUserEmail, String contactUsType, String contactUsTitle, String contactUsContent,
			Timestamp contactUsPostDate, String contactUsAdminResponse, boolean contactUsResponseStatus,
			List<ContactUsImgDto> contactUsImgList) {
		super();
		this.contactUsId = contactUsId;
		this.contactUsUserType = contactUsUserType;
		this.contactUsUserId = contactUsUserId;
		this.contactUsUserName = contactUsUserName;
		this.contactUsUserEmail = contactUsUserEmail;
		this.contactUsType = contactUsType;
		this.contactUsTitle = contactUsTitle;
		this.contactUsContent = contactUsContent;
		this.contactUsPostDate = contactUsPostDate;
		this.contactUsAdminResponse = contactUsAdminResponse;
		this.contactUsResponseStatus = contactUsResponseStatus;
		this.contactUsImgList = contactUsImgList;
	}

	public int getContactUsId() {
		return contactUsId;
	}

	public void setContactUsId(int contactUsId) {
		this.contactUsId = contactUsId;
	}

	public String getContactUsUserType() {
		return contactUsUserType;
	}

	public void setContactUsUserType(String contactUsUserType) {
		this.contactUsUserType = contactUsUserType;
	}

	public String getContactUsUserId() {
		return contactUsUserId;
	}

	public void setContactUsUserId(String contactUsUserId) {
		this.contactUsUserId = contactUsUserId;
	}

	public String getContactUsUserName() {
		return contactUsUserName;
	}

	public void setContactUsUserName(String contactUsUserName) {
		this.contactUsUserName = contactUsUserName;
	}

	public String getContactUsUserEmail() {
		return contactUsUserEmail;
	}

	public void setContactUsUserEmail(String contactUsUserEmail) {
		this.contactUsUserEmail = contactUsUserEmail;
	}

	public String getContactUsType() {
		return contactUsType;
	}

	public void setContactUsType(String contactUsType) {
		this.contactUsType = contactUsType;
	}

	public String getContactUsTitle() {
		return contactUsTitle;
	}

	public void setContactUsTitle(String contactUsTitle) {
		this.contactUsTitle = contactUsTitle;
	}

	public String getContactUsContent() {
		return contactUsContent;
	}

	public void setContactUsContent(String contactUsContent) {
		this.contactUsContent = contactUsContent;
	}

	public Timestamp getContactUsPostDate() {
		return contactUsPostDate;
	}

	public void setContactUsPostDate(Timestamp contactUsPostDate) {
		this.contactUsPostDate = contactUsPostDate;
	}

	public String getContactUsAdminResponse() {
		return contactUsAdminResponse;
	}

	public void setContactUsAdminResponse(String contactUsAdminResponse) {
		this.contactUsAdminResponse = contactUsAdminResponse;
	}

	public boolean isContactUsResponseStatus() {
		return contactUsResponseStatus;
	}

	public void setContactUsResponseStatus(boolean contactUsResponseStatus) {
		this.contactUsResponseStatus = contactUsResponseStatus;
	}

	public List<ContactUsImgDto> getContactUsImgList() {
		return contactUsImgList;
	}

	public void setContactUsImgList(List<ContactUsImgDto> contactUsImgList) {
		this.contactUsImgList = contactUsImgList;
	}

	@Override
	public String toString() {
		return "ContactUsDto [contactUsId=" + contactUsId + ", contactUsUserType=" + contactUsUserType
				+ ", contactUsUserId=" + contactUsUserId + ", contactUsUserName=" + contactUsUserName
				+ ", contactUsUserEmail=" + contactUsUserEmail + ", contactUsType=" + contactUsType
				+ ", contactUsTitle=" + contactUsTitle + ", contactUsContent=" + contactUsContent
				+ ", contactUsPostDate=" + contactUsPostDate + ", contactUsAdminResponse=" + contactUsAdminResponse
				+ ", contactUsResponseStatus=" + contactUsResponseStatus + ", contactUsImgList=" + contactUsImgList
				+ "]";
	}

	
	
	
}
