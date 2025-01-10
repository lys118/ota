package ota.model.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import ota.error.CustomException;
import ota.error.type.NoticeError;
import ota.model.dto.NoticeDto;
import ota.model.dto.NoticeImgDto;
import ota.model.dto.PageDto;

import static ota.common.DBConnection.*;

public class NoticeDao {

	public int getNoticeListCount(Map<String, String> searchMap) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select count(*) from notice " 
				+ " left join user on notice.notice_user_id = user.user_id"
				+ " where notice_importance_type ='일반'";
		if (!searchMap.get("searchWord").equals("")) {
			if (searchMap.get("searchField").equals("title")) {
				query += " and notice_title";
			} else if (searchMap.get("searchField").equals("content")) {
				query += " and notice_content";
			} else {
				query += " and user_name";
			}
			query += " LIKE '%" + searchMap.get("searchWord") + "%'";
		}
		int listCount = 0;
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CustomException(NoticeError.NOTICE_LIST_NOTFOUND_EXCEPTION);
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return listCount;
	}

	public List<NoticeDto> noticeList(PageDto pageDto, Map<String, String> searchMap) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select notice_id, notice_title, notice_content, notice_post_date, notice_visit_count,"
				+ " notice_importance_type,	notice_user_id, user_name, rnum"
				+ " from (select *,row_number() over(partition by notice_importance_type order by notice_id desc) as rnum"
				+ "	from notice"
				+ " left join user on notice.notice_user_id=user.user_id ";
		if (!searchMap.get("searchWord").equals("")) {
			if (searchMap.get("searchField").equals("title")) {
				query += " where notice_importance_type in ('필독', '중요') or "
						+ " (notice_importance_type='일반' and notice_title";
			} else if (searchMap.get("searchField").equals("content")) {
				query += " where notice_importance_type in ('필독', '중요') or "
						+ "(notice_importance_type='일반' and notice_content";
			} else {
				query += " where notice_importance_type in ('필독', '중요') or "
						+ "(notice_importance_type='일반' and user_name";
			}
			query += " LIKE '%" + searchMap.get("searchWord") + "%')";
		}
		query += " order by notice_importance_type desc, rnum asc) as noticeRnum"
				+ " where noticeRnum.notice_importance_type in ('필독', '중요') or "
				+ " (noticeRnum.notice_importance_type='일반' and noticeRnum.rnum between ? and ?)";

		List<NoticeDto> noticeList = new ArrayList<NoticeDto>();
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pageDto.getStartList());
			pstmt.setInt(2, pageDto.getEndList());
			rset = pstmt.executeQuery();

			while (rset.next()) {
				NoticeDto noticeDto = new NoticeDto();
				noticeDto.setNoticeId(rset.getInt(1));
				noticeDto.setNoticeTitle(rset.getString(2));
				noticeDto.setNoticeContent(rset.getString(3));
				noticeDto.setNoticePostDate(rset.getTimestamp(4));
				noticeDto.setNoticeVisitCount(rset.getInt(5));
				noticeDto.setNoticeImportanceType(rset.getString(6));
				noticeDto.setNoticeUserId(rset.getString(7));
				noticeDto.setNoticeUserName(rset.getString(8));

				noticeList.add(noticeDto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw new CustomException(NoticeError.NOTICE_LIST_NOTFOUND_EXCEPTION);
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return noticeList;
	}
	
	public void updateNoticeVisitCount(int noticeId) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		String query = "update notice set notice_visit_count = notice_visit_count + 1 "
				+ " where notice_id = ?";
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, noticeId);
			
			if(pstmt.executeUpdate() != 1) {
				rollback(conn);
				throw new CustomException(NoticeError.NOTICE_LIST_NOTFOUND_EXCEPTION);
			}
			commit(conn);
		} catch (SQLException e) {
			e.printStackTrace();
			rollback(conn);
			throw new CustomException(NoticeError.NOTICE_LIST_NOTFOUND_EXCEPTION);
		} finally {
			close(pstmt);
			close(conn);
		}
	}
	
	public NoticeDto getNoticeView(int noticeId) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		NoticeDto noticeDto = new NoticeDto();
		
		String query = "select notice_id, notice_title, notice_content, notice_post_date,"
				+ " notice_visit_count, notice_importance_type, notice_user_id, user_name"
				+ " from notice"
				+ " left join user on notice.notice_user_id=user.user_id"
				+ " where notice_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, noticeId);
			rset = pstmt.executeQuery();

			if (rset.next()) {//1개만 무조건 조회하는거이므로 있으면.
				noticeDto.setNoticeId(rset.getInt(1));
				noticeDto.setNoticeTitle(rset.getString(2));
				noticeDto.setNoticeContent(rset.getString(3));
				noticeDto.setNoticePostDate(rset.getTimestamp(4));
				noticeDto.setNoticeVisitCount(rset.getInt(5));
				noticeDto.setNoticeImportanceType(rset.getString(6));
				noticeDto.setNoticeUserId(rset.getString(7));
				noticeDto.setNoticeUserName(rset.getString(8));
			}else {//없으면 에러 보여줌
				throw new CustomException(NoticeError.NOTICE_DETAIL_VIEW_EXCEPTION);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw new CustomException(NoticeError.NOTICE_DETAIL_VIEW_EXCEPTION);
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return noticeDto;
	}
	
	public List<NoticeImgDto> selectImgList(int[] deleteIArr) {//서버에서삭제를 위한 이미지정보리스트조회
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<NoticeImgDto> noticeImgList = new ArrayList<NoticeImgDto>();
		
		String query = "select notice_id, notice_img_new_name, notice_img_webdirectory "
				+ " from notice_imgs "
				+ " where notice_id = ? ";
		try {
			pstmt = conn.prepareStatement(query);
			
			for(int noticeId : deleteIArr) {
				pstmt.setInt(1, noticeId);
				rset = pstmt.executeQuery();
				
				while (rset.next()) {
					NoticeImgDto noticeImgDto = new NoticeImgDto();
					noticeImgDto.setNoticeId(rset.getInt(1));
					noticeImgDto.setNoticeImgNewName(rset.getString(2));
					noticeImgDto.setWebDirectory(rset.getString(3));
					noticeImgList.add(noticeImgDto);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw new CustomException(NoticeError.NOTICE_DELETE_EXCEPTION);
		} finally {
			close(rset);
			close(pstmt);
			close(conn);
		}
		return noticeImgList;
	}
	
	public void noticeDelete(int[] deleteIArr) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from notice "
				+ " where notice_id = ?";
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(query);
			
			for(int noticeId : deleteIArr) {
				pstmt.setInt(1, noticeId);
				result = pstmt.executeUpdate();
				if(result == 0) {
					rollback(conn);
					throw new CustomException(NoticeError.NOTICE_DELETE_EXCEPTION);
				}
			}
			commit(conn);
		} catch (SQLException e) {
			e.printStackTrace();
			rollback(conn);
			throw new CustomException(NoticeError.NOTICE_DELETE_EXCEPTION);
		} finally {
			close(pstmt);
			close(conn);
		}
	}

	public void noticeWrite(NoticeDto noticeDto) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "insert into notice (notice_title, notice_content, notice_post_date,"
				+ " notice_visit_count, notice_importance_type,notice_user_id)"
				+ " value (?, ?, now(), 0, ? , 'admin');";
		String query2 = "select max(notice_id)"
				+ " from notice";
		String query3 = "insert into notice_imgs (notice_img_origin_name, notice_img_new_name,"
				+ "	notice_img_webdirectory, notice_id) value(?,?,?,?)";
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, noticeDto.getNoticeTitle()); 
			pstmt.setString(2, noticeDto.getNoticeContent());
			pstmt.setString(3, noticeDto.getNoticeImportanceType());
			
			if(pstmt.executeUpdate() == 0) { //공지사항 넣고
				rollback(conn);
				throw new CustomException(NoticeError.NOTICE_WRITE_EXCEPTION);
			}
			pstmt.clearParameters();
			pstmt = conn.prepareStatement(query2);
			rset = pstmt.executeQuery(); //공지사항 번호조회하고
			
			int maxNum = 0;
			if (rset.next()) {
				maxNum = rset.getInt(1);
			}
			
			if(!noticeDto.getNoticeImgList().isEmpty()) {
				pstmt.clearParameters();
				pstmt = conn.prepareStatement(query3); //이미지가 있으면 넣는다.
				
				for(int i =0; i < noticeDto.getNoticeImgList().size(); i++) {
					pstmt.setString(1, noticeDto.getNoticeImgList().get(i).getNoticeImgOriginName());
					pstmt.setString(2, noticeDto.getNoticeImgList().get(i).getNoticeImgNewName());
					pstmt.setString(3, noticeDto.getNoticeImgList().get(i).getWebDirectory());
					pstmt.setInt(4, maxNum);
					
					pstmt.addBatch();
					pstmt.clearParameters();
				}
				
				int[] resultArr = pstmt.executeBatch();
				for (int result : resultArr) {
					if(result==0) {
						rollback(conn);
						throw new CustomException(NoticeError.NOTICE_WRITE_EXCEPTION);
					}
				}
			}
			
			commit(conn);
		} catch (SQLException e) {
			e.printStackTrace();
			rollback(conn);
			throw new CustomException(NoticeError.NOTICE_WRITE_EXCEPTION);
		} finally {
			close(pstmt);
			close(conn);
		}
	}

	public void deleteImg(NoticeImgDto noticeImgDto) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		String query = "delete from notice_imgs "
				+ " where notice_id = ? and notice_img_new_name = ?";
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, noticeImgDto.getNoticeId());
			pstmt.setString(2, noticeImgDto.getNoticeImgNewName());
			pstmt.executeUpdate();
			
			commit(conn);
		} catch (SQLException e) {
			e.printStackTrace();
			rollback(conn);
			throw new CustomException(NoticeError.NOTICE_IMG_DELETE_EXCEPTION);
		} finally {
			close(pstmt);
			close(conn);
		}
	}

	public void noticeUpdate(NoticeDto noticeDto) {
		//제목,내용은 바로 insert 이미지의경우는 삭제시 db바로적용,
		//만약 2개중 1개삭제후 1개 새로넣으면 삭제는 바로적용되지만
		//1개는 그대로있고 1개는 insert를 해줘야한다.
		//그러므로 조회 newName조회후 비교해서 없으면 insert를 해줘야함.
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		
		String query = "update notice"
				+ " set notice_title = ? , notice_content = ?"
				+ " ,notice_post_date = now(), notice_importance_type = ?"
				+ " where notice_id = ?";
		
		String query2 ="select notice_img_new_name "
				+ " from notice_imgs"
				+ " where notice_id = ?";

		String query3 = "insert into notice_imgs (notice_img_origin_name, notice_img_new_name,"
				+ "	notice_img_webdirectory, notice_id) value(?,?,?,?)";
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(query);
			
			if(noticeDto.getNoticeTitle().length() >=4) {
				if("(수정)".equals(noticeDto.getNoticeTitle().substring(0, 4))){
					pstmt.setString(1, noticeDto.getNoticeTitle()); 
				}else {
					pstmt.setString(1, "(수정)"+noticeDto.getNoticeTitle());
				}
			}else {
				pstmt.setString(1, "(수정)"+noticeDto.getNoticeTitle());
			}
			pstmt.setString(2, noticeDto.getNoticeContent());
			pstmt.setString(3, noticeDto.getNoticeImportanceType());
			pstmt.setInt(4, noticeDto.getNoticeId());
			
			if(pstmt.executeUpdate() != 1) { //1 noticeUpdate
				rollback(conn);
				throw new CustomException(NoticeError.NOTICE_UPDATE_EXCEPTION);
			}
			pstmt.clearParameters(); //update 잘됬으면.
			
			if(!noticeDto.getNoticeImgList().isEmpty()) {//이미지가 있으면 조회비교후 인서트 없으면 종료
				pstmt = conn.prepareStatement(query2);
				pstmt.setInt(1, noticeDto.getNoticeId());
				
				List<NoticeImgDto> noticeImgList = new ArrayList<NoticeImgDto>();
				ResultSet rset = pstmt.executeQuery();
				
				while (rset.next()) { //db조회 완.
					NoticeImgDto noticeImgDto = new NoticeImgDto();
					noticeImgDto.setNoticeImgNewName(rset.getString(1));
					noticeImgList.add(noticeImgDto);
				}
				pstmt.clearParameters();
				//무조건 새로 가져온 list의 크기가 더크다.(삭제시 미리 ajax로 삭제하므로)
				//그러므로 가져온 list의 값이 db조회 한것에 없으면 insert를 해주면된다.
				
				List<NoticeImgDto> newNoticeImgList = noticeDto.getNoticeImgList();
				for(NoticeImgDto newImgDto : newNoticeImgList) {//가져온이미지 for문
					int result = 0; // 결과에 아래 for문에서 중복되면 1로 바꿔줌
					for(NoticeImgDto dbImgDto : noticeImgList) {//db에서 가져온 img for문
						if(newImgDto.getNoticeImgNewName().equals(dbImgDto.getNoticeImgNewName())) {
							result =1;
							break;
						}
					}
					if(result ==0 ) {//1이면 중복된거 0이면 없는거이므로 insert해줌
						pstmt =conn.prepareStatement(query3);
						pstmt.setString(1, newImgDto.getNoticeImgOriginName());
						pstmt.setString(2, newImgDto.getNoticeImgNewName());
						pstmt.setString(3, newImgDto.getWebDirectory());
						pstmt.setInt(4, noticeDto.getNoticeId());
						if(pstmt.executeUpdate() !=1) {
							System.out.println("이미지 insert 실패");
							rollback(conn);
							throw new CustomException(NoticeError.NOTICE_UPDATE_EXCEPTION);
						}
					}
				}//바깥쪽 for문
			}
			
			commit(conn);
		} catch (SQLException e) {
			e.printStackTrace();
			rollback(conn);
			throw new CustomException(NoticeError.NOTICE_UPDATE_EXCEPTION);
		} finally {
			close(pstmt);
			close(conn);
		}
	}
}
