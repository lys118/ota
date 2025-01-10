package ota.model.dto;

import java.sql.Timestamp;
import java.util.List;

public class NoticeDto {
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private Timestamp noticePostDate;
	private int noticeVisitCount;
	private String noticeImportanceType;
	private String noticeUserId;
	private String noticeUserName;
	private List<NoticeImgDto> noticeImgList;
	
		
	public NoticeDto() {
		super();
	}


	public NoticeDto(int noticeId, String noticeTitle, String noticeContent, Timestamp noticePostDate,
			int noticeVisitCount, String noticeImportanceType, String noticeUserId, String noticeUserName,
			List<NoticeImgDto> noticeImgList) {
		super();
		this.noticeId = noticeId;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticePostDate = noticePostDate;
		this.noticeVisitCount = noticeVisitCount;
		this.noticeImportanceType = noticeImportanceType;
		this.noticeUserId = noticeUserId;
		this.noticeUserName = noticeUserName;
		this.noticeImgList = noticeImgList;
	}


	public int getNoticeId() {
		return noticeId;
	}


	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}


	public String getNoticeTitle() {
		return noticeTitle;
	}


	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}


	public String getNoticeContent() {
		return noticeContent;
	}


	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}


	public Timestamp getNoticePostDate() {
		return noticePostDate;
	}


	public void setNoticePostDate(Timestamp noticePostDate) {
		this.noticePostDate = noticePostDate;
	}


	public int getNoticeVisitCount() {
		return noticeVisitCount;
	}


	public void setNoticeVisitCount(int noticeVisitCount) {
		this.noticeVisitCount = noticeVisitCount;
	}


	public String getNoticeImportanceType() {
		return noticeImportanceType;
	}


	public void setNoticeImportanceType(String noticeImportanceType) {
		this.noticeImportanceType = noticeImportanceType;
	}


	public String getNoticeUserId() {
		return noticeUserId;
	}


	public void setNoticeUserId(String noticeUserId) {
		this.noticeUserId = noticeUserId;
	}


	public String getNoticeUserName() {
		return noticeUserName;
	}


	public void setNoticeUserName(String noticeUserName) {
		this.noticeUserName = noticeUserName;
	}


	public List<NoticeImgDto> getNoticeImgList() {
		return noticeImgList;
	}


	public void setNoticeImgList(List<NoticeImgDto> noticeImgList) {
		this.noticeImgList = noticeImgList;
	}


	@Override
	public String toString() {
		return "NoticeDto [noticeId=" + noticeId + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticePostDate=" + noticePostDate + ", noticeVisitCount=" + noticeVisitCount
				+ ", noticeImportanceType=" + noticeImportanceType + ", noticeUserId=" + noticeUserId
				+ ", noticeUserName=" + noticeUserName + ", noticeImgList=" + noticeImgList + "]";
	}

	
	
	
	

	
	
}
