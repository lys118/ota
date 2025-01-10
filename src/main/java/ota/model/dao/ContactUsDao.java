package ota.model.dao;

import ota.model.dto.ContactUsDto;
import ota.model.dto.ContactUsImgDto;
import ota.model.dto.NoticeDto;
import ota.model.dto.NoticeImgDto;
import ota.model.dto.PageDto;

import static ota.common.DBConnection.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ota.error.CustomException;
import ota.error.type.ContactUsError;
import ota.error.type.NoticeError;
public class ContactUsDao {

	public void writeContactUs(ContactUsDto contactUsDto) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "insert into contactus(contactus_user_type,contactus_user_id,contactus_user_name"
				+ ", contactus_user_email,contactus_type,contactus_title,contactus_content "
				+ ", contactus_post_date,contactus_response_status)"
				+ " value (?,?,?,?,?,?,?,now(),?)";
		
		String query2 ="select max(contactus_id)"
				+ " from contactus";

		String query3 = "insert into contactus_imgs(contactus_img_origin_name,contactus_img_new_name"
				+ ",contactus_img_webdirectory, contactus_id)"
				+ " value(?,?,?,?)";

		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(query); //1.문의사항 입력
			
			pstmt.setString(1, contactUsDto.getContactUsUserType()); 
			pstmt.setString(2, contactUsDto.getContactUsUserId());
			pstmt.setString(3, contactUsDto.getContactUsUserName());
			pstmt.setString(4, contactUsDto.getContactUsUserEmail());
			pstmt.setString(5, contactUsDto.getContactUsType());
			pstmt.setString(6, contactUsDto.getContactUsTitle());
			pstmt.setString(7, contactUsDto.getContactUsContent());
			pstmt.setBoolean(8, false);
			
			if(pstmt.executeUpdate() != 1) { //입력이 잘안됫다면(결과가 1이아니라면)
				rollback(conn);//롤백한다
				throw new CustomException(ContactUsError.CONTACTUS_WRITE_EXCEPTION);
			}
			pstmt.clearParameters();//잘됫다면 파라미터를 지워준다.
			if(!contactUsDto.getContactUsImgList().isEmpty()) {//만약 이미지가 있다면
				pstmt = conn.prepareStatement(query2); //2.입력한 문의사항의 번호찾기.(이미지 넣을 포린키찾기)
				rset = pstmt.executeQuery();
				
				int contactUsId = 0;
				if(rset.next()) {
					contactUsId = rset.getInt(1); //번호 찾기 완료
				}
				
				pstmt.clearParameters();//파라미터 초기화
				pstmt = conn.prepareStatement(query3);//찾은번호로 이미지 입력하기
				
				for(ContactUsImgDto contactUsImgDto : contactUsDto.getContactUsImgList()) {
					pstmt.setString(1, contactUsImgDto.getContactUsImgOriginName());
					pstmt.setString(2, contactUsImgDto.getContactUsImgNewName());
					pstmt.setString(3, contactUsImgDto.getWebDirectory());
					pstmt.setInt(4, contactUsId);
					
					pstmt.addBatch(); //저장하고
					pstmt.clearParameters();//초기화
				}
				
				int[] resultArr = pstmt.executeBatch();//모아둔 batch 실행 반환은 배열로
				for (int result : resultArr) {
					if(result==0) { //실패했으면
						rollback(conn); //롤백
						throw new CustomException(ContactUsError.CONTACTUS_IMG_UPLOAD_EXCEPTION);
					}
				}
			}
			commit(conn);
		} catch (SQLException e) {
			e.printStackTrace();
			rollback(conn);
			throw new CustomException(ContactUsError.CONTACTUS_WRITE_EXCEPTION);
		} finally {
			close(pstmt);
			close(conn);
		}
	}

	public int getContactUsListCount(String responseStatus) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select count(*) from contactus ";

		int listCount = 0;
		try {
			if("allComplete".equals(responseStatus)) {
				pstmt = conn.prepareStatement(query);
			}else {
				query += " where contactus_response_status =?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, responseStatus);
			}
			
			rset = pstmt.executeQuery();
			if (rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CustomException(ContactUsError.CONTACTUS_LIST_NOTFOUND_EXCEPTION);
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return listCount;
	}

	public List<ContactUsDto> contatUsList(PageDto pageDto, String responseStatus) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select contactus_id, contactus_user_type, contactus_user_name,contactus_title,"
				+ "	contactus_post_date, contactus_response_status"
				+ " from contactus ";

		List<ContactUsDto> contactUsDtoList = new ArrayList<ContactUsDto>();
		try {
			if("allComplete".equals(responseStatus)) {
				query += "order by contactus_id desc "
						+ "limit ?, ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, pageDto.getStartList()-1);//리미트로 조회시 0부터시작
				pstmt.setInt(2, pageDto.getListSize()); //0부터 몇개조회할지.
			}else {
				query += " where contactus_response_status =?"
						 +" order by contactus_id desc "
						+ " limit ?, ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, responseStatus);
				pstmt.setInt(2, pageDto.getStartList()-1);//리미트로 조회시 0부터시작
				pstmt.setInt(3, pageDto.getListSize());
			}
			
			rset = pstmt.executeQuery();

			while (rset.next()) {
				ContactUsDto contactUsDto = new ContactUsDto();
				contactUsDto.setContactUsId(rset.getInt(1));
				contactUsDto.setContactUsUserType(rset.getString(2));
				contactUsDto.setContactUsUserName(rset.getString(3));
				contactUsDto.setContactUsTitle(rset.getString(4));
				contactUsDto.setContactUsPostDate(rset.getTimestamp(5));
				contactUsDto.setContactUsResponseStatus(rset.getBoolean(6));
				
				contactUsDtoList.add(contactUsDto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw new CustomException(ContactUsError.CONTACTUS_LIST_NOTFOUND_EXCEPTION);
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return contactUsDtoList;
	}

	public ContactUsDto adminViewAndWrite(int contactUsId) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ContactUsDto contactUsDto = new ContactUsDto();
		
		String query1 = "select contactus_id, contactus_user_type, contactus_user_id, contactus_user_name, "
				+ " contactus_user_email, contactus_type, contactus_title, contactus_content,"
				+ "	contactus_post_date, contactus_admin_response, contactus_response_status"
				+ " from contactus"
				+ " where contactus_id = ?";
		
		String query2 = "select contactus_img_origin_name, contactus_img_new_name,"
				+ " contactus_img_webdirectory"
				+ " from contactus_imgs "
				+ " where contactus_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query1);
			pstmt.setInt(1, contactUsId);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				contactUsDto.setContactUsId(rset.getInt(1));
				contactUsDto.setContactUsUserType(rset.getString(2));
				contactUsDto.setContactUsUserId(rset.getString(3));
				contactUsDto.setContactUsUserName(rset.getString(4));
				contactUsDto.setContactUsUserEmail(rset.getString(5));
				contactUsDto.setContactUsType(rset.getString(6));
				contactUsDto.setContactUsTitle(rset.getString(7));
				contactUsDto.setContactUsContent(rset.getString(8));
				contactUsDto.setContactUsPostDate(rset.getTimestamp(9));
				contactUsDto.setContactUsAdminResponse(rset.getString(10));
				contactUsDto.setContactUsResponseStatus(rset.getBoolean(11));
			}
			
			pstmt.clearParameters();
			pstmt = conn.prepareStatement(query2);
			pstmt.setInt(1, contactUsId);
			rset = pstmt.executeQuery();
			
			List<ContactUsImgDto> contactUsImgDtoList = new ArrayList<>();
			while(rset.next()) {
				ContactUsImgDto contactUsImgDto = new ContactUsImgDto();
				contactUsImgDto.setContactUsImgOriginName(rset.getString(1));
				contactUsImgDto.setContactUsImgNewName(rset.getString(2));
				contactUsImgDto.setWebDirectory(rset.getString(3));
				
				contactUsImgDtoList.add(contactUsImgDto);
			}
			
			contactUsDto.setContactUsImgList(contactUsImgDtoList);

		} catch (SQLException e) {
			e.printStackTrace();
			throw new CustomException(ContactUsError.CONTACTUS_DETAIL_VIEW_EXCEPTION);
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return contactUsDto;
	}

	public void adminResponse(int contactUsId, String responseText) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		
		String query = "update contactus set contactus_admin_response = ?"
				+ ", contactus_response_status = '1'"
				+ " where contactus_id = ?";
		
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, responseText);
			pstmt.setInt(2, contactUsId);
			
			if(pstmt.executeUpdate() != 1) {
				rollback(conn);
				throw new CustomException(ContactUsError.CONTACTUS_RESPONSE_WRITE_EXCEPTION);
			}
			
			commit(conn);
		} catch (SQLException e) {
			e.printStackTrace();
			rollback(conn);
			throw new CustomException(ContactUsError.CONTACTUS_RESPONSE_WRITE_EXCEPTION);
		} finally {
			close(pstmt);
			close(conn);
		}
	}

}
