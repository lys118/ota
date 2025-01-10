package ota.service;

import java.util.ArrayList;
import ota.model.dao.UserDAO;
import ota.model.dto.LoginUserDTO;
import ota.model.dto.UserDTO;

public class UserService {
	private UserDAO userDAO = new UserDAO();
	
	public LoginUserDTO login(String user_id, String user_password) {
		return userDAO.login(user_id, user_password);
	}
	
	public boolean join(UserDTO dto) {
		return userDAO.join(dto);
	}

	public boolean checkid(String user_id) {
		return userDAO.checkid(user_id);
	}

	public String findid(String user_name, String user_email) {
		return userDAO.findid(user_name, user_email);
	}

	public boolean changepw(String user_id, String user_password) {
		return userDAO.changepw(user_id, user_password);
	}

	public boolean delete(String user_id) {
		return userDAO.delete(user_id);
	}

	public UserDTO getinfo(String user_id) {
		return userDAO.getinfo(user_id);
	}

	public boolean updateinfo(String user_id, String user_name, String user_email, String user_phone,
			String user_postcode, String user_address, String user_detail_address) {
		return userDAO.updateinfo(user_id, user_name, user_email, user_phone, user_postcode, user_address, user_detail_address);
	}

	public ArrayList<UserDTO> userlist(int startRow, int pageSize) {
		return userDAO.userlist(startRow, pageSize);
	}
	
	public int getusercount() {
		return userDAO.getusercount();
	}

}
