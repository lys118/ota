package ota.model.dto;

public class NoticeImgDto {
	private int noticeId;
	private int noticeImgId;
	private String noticeImgOriginName;
	private String noticeImgNewName;
	private String webDirectory;
	
	
	public NoticeImgDto() {
	}


	public NoticeImgDto(int noticeId, int noticeImgId, String noticeImgOriginName, String noticeImgNewName,
			String webDirectory) {
		this.noticeId = noticeId;
		this.noticeImgId = noticeImgId;
		this.noticeImgOriginName = noticeImgOriginName;
		this.noticeImgNewName = noticeImgNewName;
		this.webDirectory = webDirectory;
	}


	public int getNoticeId() {
		return noticeId;
	}


	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}


	public int getNoticeImgId() {
		return noticeImgId;
	}


	public void setNoticeImgId(int noticeImgId) {
		this.noticeImgId = noticeImgId;
	}


	public String getNoticeImgOriginName() {
		return noticeImgOriginName;
	}


	public void setNoticeImgOriginName(String noticeImgOriginName) {
		this.noticeImgOriginName = noticeImgOriginName;
	}


	public String getNoticeImgNewName() {
		return noticeImgNewName;
	}


	public void setNoticeImgNewName(String noticeImgNewName) {
		this.noticeImgNewName = noticeImgNewName;
	}


	public String getWebDirectory() {
		return webDirectory;
	}


	public void setWebDirectory(String webDirectory) {
		this.webDirectory = webDirectory;
	}


	@Override
	public String toString() {
		return "NoticeImgDto [noticeId=" + noticeId + ", noticeImgId=" + noticeImgId + ", noticeImgOriginName="
				+ noticeImgOriginName + ", noticeImgNewName=" + noticeImgNewName + ", webDirectory=" + webDirectory
				+ "]";
	}

	
	
	
	
	
}
