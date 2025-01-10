package ota.error.type;


import ota.error.CommonError;
public enum NoticeError implements CommonError{
	NOTICE_LIST_NOTFOUND_EXCEPTION(500,"공지사항 목록을 찾을 수 없습니다."),
	NOTICE_UPDATE_VISIT_COUNT_EXCEPTION(500,"공지사항 조회수 증가에 실패했습니다."),
	NOTICE_DETAIL_VIEW_EXCEPTION(500,"공지사항 상세조회를 할 수 없습니다."),
	NOTICE_DELETE_EXCEPTION(500,"공지사항 삭제에 실패했습니다."),
	NOTICE_IMG_UPLOAD_EXCEPTION(500,"이미지 업로드에 실패했습니다."),
	NOTICE_IMG_DELETE_EXCEPTION(500,"이미지 삭제에 실패했습니다."),
	NOTICE_WRITE_EXCEPTION(500,"공지사항 작성에 실패했습니다."),
	NOTICE_UPDATE_EXCEPTION(500,"공지사항 수정에 실패했습니다.");
	
	private int status;
	private String message;
	
	private NoticeError(int status, String message) {
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
