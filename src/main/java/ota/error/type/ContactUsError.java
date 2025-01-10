package ota.error.type;

import ota.error.CommonError;

public enum ContactUsError implements CommonError{
	CONTACTUS_IMG_UPLOAD_EXCEPTION(500,"문의사항 이미지를 업로드 할 수 없습니다."),
	CONTACTUS_WRITE_EXCEPTION(500,"문의사항 업로드를 할 수 없습니다."),
	CONTACTUS_LIST_NOTFOUND_EXCEPTION(500,"문의사항 리스트 조회를 할 수 없습니다."),
	CONTACTUS_DETAIL_VIEW_EXCEPTION(500,"문의사항 상세조회를 할 수 없습니다."),
	CONTACTUS_RESPONSE_WRITE_EXCEPTION(500,"문의사항 답변 작성에 실패하였습니다."),
	CONTACTUS_RESPONSE_SEND_EMAIL_EXCEPTION(500,"문의사항 답변 메일전송에 실패하였습니다.");
	
	private int status;
	private String message;
	
	private ContactUsError(int status, String message) {
		this.status = status;
		this.message = message;
	}
	
	@Override
	public int getStatus() {
		return this.status;
	}
	
	@Override
	public String getMessage() {
		return this.message;
	}
}
