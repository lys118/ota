package ota.model.dto;

public class ContactUsImgDto {
	private int contactUsId;
	private String contactUsImgOriginName;
	private String contactUsImgNewName;
	private String webDirectory;
	
		
	public ContactUsImgDto() {
	}
	public ContactUsImgDto(int contactUsId, String contactUsImgOriginName, String contactUsImgNewName,
			String webDirectory) {
		this.contactUsId = contactUsId;
		this.contactUsImgOriginName = contactUsImgOriginName;
		this.contactUsImgNewName = contactUsImgNewName;
		this.webDirectory = webDirectory;
	}
	public int getContactUsId() {
		return contactUsId;
	}
	public void setContactUsId(int contactUsId) {
		this.contactUsId = contactUsId;
	}
	public String getContactUsImgOriginName() {
		return contactUsImgOriginName;
	}
	public void setContactUsImgOriginName(String contactUsImgOriginName) {
		this.contactUsImgOriginName = contactUsImgOriginName;
	}
	public String getContactUsImgNewName() {
		return contactUsImgNewName;
	}
	public void setContactUsImgNewName(String contactUsImgNewName) {
		this.contactUsImgNewName = contactUsImgNewName;
	}
	public String getWebDirectory() {
		return webDirectory;
	}
	public void setWebDirectory(String webDirectory) {
		this.webDirectory = webDirectory;
	}
	@Override
	public String toString() {
		return "ContactUsImgDto [contactUsId=" + contactUsId + ", contactUsImgOriginName=" + contactUsImgOriginName
				+ ", contactUsImgNewName=" + contactUsImgNewName + ", webDirectory=" + webDirectory + "]";
	}
	
	
	
}
