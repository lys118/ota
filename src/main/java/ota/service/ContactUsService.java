package ota.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ota.model.dao.ContactUsDao;
import ota.model.dto.ContactUsDto;
import ota.model.dto.PageDto;

public class ContactUsService {
	private ContactUsDao contactUsDao = new ContactUsDao();
	
	public void writeContactUs(ContactUsDto contactUsDto) {
		contactUsDao.writeContactUs(contactUsDto);
	}

	public Map<String,Object> adminList(int currentPage, String responseStatus) {
		int listCount = contactUsDao.getContactUsListCount(responseStatus);
		PageDto pageDto = new PageDto(10,10,listCount,currentPage);
		List<ContactUsDto> contactUsDtoList = contactUsDao.contatUsList(pageDto,responseStatus);
		Map<String,Object> contactUsMap = new HashMap<>();
		
		contactUsMap.put("pageDto", pageDto);
		contactUsMap.put("responseStatus", responseStatus);
		contactUsMap.put("contactUsDtoList", contactUsDtoList);
		
		return contactUsMap;
	}

	public ContactUsDto adminViewAndWrite(int contactUsId) {
		return contactUsDao.adminViewAndWrite(contactUsId);
	}

	public void adminResponse(int contactUsId, String responseText) {
		contactUsDao.adminResponse(contactUsId, responseText);
	}

	
}
