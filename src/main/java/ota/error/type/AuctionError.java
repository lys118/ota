package ota.error.type;

import ota.error.CommonError;

public enum AuctionError implements CommonError{
	AUCTION_IMG_UPLOAD_EXCEPTION(500, "이미지 업로드 중 오류가 발생했습니다."),
    INVALID_DATE_FORMAT(500, "날짜 형식이 올바르지 않습니다."), // 새로 추가한 에러 타입
    DIRECTORY_CREATION_FAILED(500, "디렉토리 생성에 실패했습니다."),
    FILE_UPLOAD_FAILED(500, "파일 업로드에 실패했습니다."),
    FILE_UPLOAD_EXCEPTION(500, "파일 업로드 중 예외가 발생했습니다."),
    USER_ID_MISSING(500, "사용자 아이디를 찾을 수 없습니다."),
    UNKNOWN_ERROR(500, "알 수 없는 오류가 발생했습니다.");

	private int status;
	private String message;

	private AuctionError(int status, String message) {
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
