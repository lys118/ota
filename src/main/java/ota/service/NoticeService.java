package ota.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ota.model.dao.NoticeDao;
import ota.model.dto.NoticeDto;
import ota.model.dto.NoticeImgDto;
import ota.model.dto.PageDto;

public class NoticeService {
	private NoticeDao noticeDao = new NoticeDao();
	
	public Map<String,Object> noticeList(int currentPage, Map<String,String> searchMap) {
		int listCount = noticeDao.getNoticeListCount(searchMap);
		PageDto pageDto = new PageDto(10,10,listCount,currentPage);
		
		List<NoticeDto> noticeList = noticeDao.noticeList(pageDto,searchMap);
		Map<String,Object> noticeMap = new HashMap<>();
		noticeMap.put("pageDto", pageDto);
		noticeMap.put("searchMap", searchMap);
		noticeMap.put("noticeList", noticeList);
		return noticeMap;
	}
	
	public NoticeDto getNoticeView(int noticeId) {
		noticeDao.updateNoticeVisitCount(noticeId);
		NoticeDto noticeDto =noticeDao.getNoticeView(noticeId);
		return noticeDto;
	}

	public List<NoticeImgDto> noticeDelete(int[] deleteIArr) {
		List<NoticeImgDto> noticeImgList = noticeDao.selectImgList(deleteIArr);
		noticeDao.noticeDelete(deleteIArr);	//db에서 삭제
		
		return noticeImgList;
	}
	
	public void noticeWrite(NoticeDto noticeDto) {
		noticeDao.noticeWrite(noticeDto);
	}

	public Map<String, Object> noticeUpdateForm(int noticeId) {
		NoticeDto noticeDto = noticeDao.getNoticeView(noticeId);
		
		int[] noticeIdArr = new int[1];//이미지 조회시 매개변수가 배열이라..(전체삭제 때도 사용)
		noticeIdArr[0] = noticeId;
		
		List<NoticeImgDto> noticeImgList = noticeDao.selectImgList(noticeIdArr);
		Map<String,Object> noticeMap = new HashMap<String, Object>();
		noticeMap.put("noticeDto", noticeDto);
		noticeMap.put("noticeImgList", noticeImgList);
		return noticeMap;
	}

	public void deleteImg(NoticeImgDto noticeImgDto) {
		noticeDao.deleteImg(noticeImgDto);
	}

	public void noticeUpdate(NoticeDto noticeDto) {
		noticeDao.noticeUpdate(noticeDto);
	}
}
