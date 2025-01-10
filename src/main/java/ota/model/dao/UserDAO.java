package ota.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import ota.common.DBConnection;
import ota.model.dto.LoginUserDTO;
import ota.model.dto.UserDTO;

import static ota.common.DBConnection.*;

public class UserDAO {
	
	public boolean join(UserDTO user) {
		
		boolean result = false;

		String sql = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?, ?, sysdate())";
		Connection conn = null;
		PreparedStatement pstmt = null;
		int cnt = 0;

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserPhone());
			pstmt.setString(6, user.getUserPostcode());
			pstmt.setString(7, user.getUserAddress());
			pstmt.setString(8, user.getUserDetailAddress());

			cnt = pstmt.executeUpdate();
			if (cnt != 0) {
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(conn);
		}
		return result;
	}

	public LoginUserDTO login(String user_id, String user_password) {

		String sql = "SELECT user_id,user_name,user_email FROM user WHERE user_id=? AND user_password=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LoginUserDTO loingUserDTO = null;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);
			pstmt.setString(2, user_password);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				loingUserDTO = new LoginUserDTO(rs.getString(1),rs.getString(2),rs.getString(3));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rs);
			close(conn);
		}
		return loingUserDTO;
	}

	public boolean checkid(String user_id) {
		boolean result = false;
		String sql = "SELECT * FROM user WHERE user_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			result = rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return result;
	}
	public String findid(String user_name, String user_email) {
		String user_id = null;
		String sql = "SELECT user_id FROM user WHERE user_name=? AND user_email=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_name);
			pstmt.setString(2, user_email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user_id = rs.getString("user.user_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return user_id;
	}
	
	public boolean changepw(String user_id, String user_password) {
		boolean result = false;
		String sql = "UPDATE user SET user_password = ? WHERE user_id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		int cnt = 0;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_password);
			pstmt.setString(2, user_id);
			cnt = pstmt.executeUpdate();
			if (cnt != 0) {
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(conn);
		}
		return result; 
	}
	
	public boolean delete(String user_id) {
		boolean result = false;
		String sql = "DELETE FROM user WHERE user_id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		int cnt = 0;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_id);
			cnt = pstmt.executeUpdate();
			if (cnt != 0) {
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(conn);
		}
		return result;	
	}
	
	public UserDTO getinfo(String user_id) {
		String sql = "SELECT * FROM user WHERE user_id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserDTO user = null;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				user = new UserDTO();
				user.setUserID(rs.getString("user_id"));
				user.setUserPassword(rs.getString("user_password"));
				user.setUserName(rs.getString("user_name"));
				user.setUserEmail(rs.getString("user_email"));
				user.setUserPhone(rs.getString("user_phone"));
				user.setUserPostcode(rs.getString("user_postcode"));
				user.setUserAddress(rs.getString("user_address"));
				user.setUserDetailAddress(rs.getString("user_detail_address"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return user;
	}
	
	public boolean updateinfo(String user_id, String user_name, String user_email, String user_phone, 
			String user_postcode, String user_address, String user_detail_address) {
		boolean result = false;
		String sql = "UPDATE user SET user_name = ?, user_email = ?, user_phone = ?,"
				+ "user_postcode = ?, user_address = ?, user_detail_address = ? WHERE user_id = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int cnt = 0;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setString(1, user_name);
			pstmt.setString(2, user_email);
			pstmt.setString(3, user_phone);
			pstmt.setString(4, user_postcode);
			pstmt.setString(5, user_address);
			pstmt.setString(6, user_detail_address);
			pstmt.setString(7, user_id);
			cnt = pstmt.executeUpdate();
			
			if (cnt != 0) {
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(conn);
		}
		return result;
	}
	
	public ArrayList<UserDTO> userlist(int startRow, int pageSize) {
		ArrayList<UserDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM user ORDER BY user_join_date DESC LIMIT ? , ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				UserDTO user = new UserDTO();
				String user_id = rs.getString("user_id");
				String user_password = rs.getString("user_password");
				String user_name = rs.getString("user_name");
				String user_email = rs.getString("user_email");
				String user_phone = rs.getString("user_phone");
				String user_postcode = rs.getString("user_postcode");
				String user_address = rs.getString("user_address");
				String user_detail_address = rs.getString("user_detail_address");
				Date user_join_date = rs.getDate("user_join_date");
				user.setUserID(user_id);
				user.setUserPassword(user_password);
				user.setUserName(user_name);
				user.setUserEmail(user_email);
				user.setUserPhone(user_phone);
				user.setUserPostcode(user_postcode);
				user.setUserAddress(user_address);
				user.setUserDetailAddress(user_detail_address);
				user.setUserJoinDate(user_join_date);
				list.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return list;
	}
	
	public int getusercount() {
		int result = 0;
		String sql = "SELECT COUNT(*) FROM user";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return result;
	}
	
}
