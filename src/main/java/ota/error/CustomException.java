package ota.error;

public class CustomException extends RuntimeException {
	
	private static final long serialVersionUID = 1L;
	private CommonError commonError;
	
	public CustomException(CommonError commonError) {
		    super(commonError.getMessage());
		    this.commonError = commonError;
		  }

	public CommonError getErrorCode() {
		return this.commonError;
	}
}
