package DTO;

import java.sql.ResultSet;
import java.util.ArrayList;

import DB.DBManager;
import VO.UserVO;

public class UserDTO extends DBManager {

	// ***************************아이디 및 비밀번호 찾기 및 비밀번호 재설정
	// 메서드************************************************************

	// 아이디 찾기 메서드
	public boolean FindID(String phone) {
		try {
			String sql = "select id from user where phone = ?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, phone);
			m_ResultSet = m_SelectStatment.executeQuery();
			return true;
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
	}

	// 비밀번호 찾기 메서드
	public boolean FindPassWord(String id) {
		try {
			String sql = "select password from user where id = ?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id);
			m_ResultSet = m_SelectStatment.executeQuery();
			return true;
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
	}

	// *************************************************************************************************************************************

	// ***************************회원가입
	// 메서드******************************************************************************************************

	public int Join(String id, String password, String nick, String email, String address, String phone) {
		try {
			// 회원가입페이지(join.jsp)에서 파라미터로 전송된 데이터들을 user테이블의 새로운 레코드로 삽입하는 부분이다.
			String sql = "insert into user (id, password, nick, email, address, phone, pictureOriginName, pictureRealName, statusmessage) values (?,md5(md5(md5(md5(md5(md5(?)))))),?,?,?,?,?,?,?)";
			DBOpen();
			OpenQuery(sql);
			getM_SelectStatment().setString(1, id);
			getM_SelectStatment().setString(2, password);
			getM_SelectStatment().setString(3, nick);
			getM_SelectStatment().setString(4, email);
			getM_SelectStatment().setString(5, address);
			getM_SelectStatment().setString(6, phone);
			getM_SelectStatment().setString(7, "./image/man.jpg");
			getM_SelectStatment().setString(8, "./image/man.jpg");
			getM_SelectStatment().setString(9, "");
			// 새로 회원가입하는 사용자들의 프로필 사진과 상태메세지를 각각 기본이미지와 공백으로 저장.
			ExcuteUpdate();
			CloseQuery();
			DBClose();
			return 1; // 회원가입 성공하면 1 반환
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return 0; // 실패하면 0 반환
		}
	}

	// ***********************************************************************************************************************************
	// 마이페이지 수정하면 실행되는 함수.
	public UserVO MyPageModify(String id, String nick, String statusmessage, String filename, String filerealname) {
		UserVO vo = new UserVO();
		String sql = "";
		try {
			// 두개다 널이라면 사용자가 프로필을 설정하지 않고 닉네임이나 상태메세지만 바꿧다면
			// filename과 filerealname이 null값으로 들어오기 때문에 저장되어있는 사진이름을 먼저 가져온다.
			sql = "select pictureOriginName, pictureRealName from user where id = ?";
			if(filename == null || filerealname == null)	{
				DBOpen();
				OpenQuery(sql);
				getM_SelectStatment().setString(1, id);
				ExecuteQuery();
				while(ResultNext())	{
					filename = getM_ResultSet().getString("pictureOriginName");
					filerealname = getM_ResultSet().getString("pictureRealName");
				}
				CloseResultSet();
				CloseQuery();
			}
			
			sql = "update user set nick = ?, statusmessage = ?, pictureOriginName = ?, pictureRealName = ? where id = ?";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, nick);
			getM_SelectStatment().setString(2, statusmessage);
			getM_SelectStatment().setString(3, filename);
			getM_SelectStatment().setString(4, filerealname);
			getM_SelectStatment().setString(5, id);
			ExcuteUpdate();
			CloseQuery();
			
			sql = "select nick, statusmessage, pictureOriginName, pictureRealName from user where id = ?";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, id);
			ExecuteQuery();
			while (ResultNext()) {
				vo.setNick(getM_ResultSet().getString("nick"));
				vo.setStatusmessage(getM_ResultSet().getString("statusmessage"));
				vo.setPictureOriginName(getM_ResultSet().getString("pictureOriginName"));
				vo.setPictureRealName(getM_ResultSet().getString("pictureRealName"));
			}
			CloseResultSet();
			CloseQuery();
			DBClose();
		} catch (Exception e) {
			System.out.println("MyPageModify() 오류");
			System.out.println("ERROR : " + e.getMessage());
		}
		return vo;
	}

	/// 마이페이지 뿌려주는 함수
	public UserVO MyPagePrint(String ID) {
		String sql = "select nick, statusmessage, pictureRealName from user where id = '" + ID + "'";
		UserVO vo = new UserVO();
		try {
			DBOpen();
			OpenQuery(sql);
			ExecuteQuery();
			while (ResultNext()) {
				vo.setNick(getString("nick"));
				vo.setPictureRealName(getString("pictureRealName"));
				vo.setStatusmessage(getString("statusmessage"));
			}
			CloseResultSet();
			CloseQuery();
			DBClose();
		} catch (Exception e) {
			System.out.println("ERROR : " + e.getMessage());
			System.out.println("MyPagePrint() 오류");
		}
		/*
		 * if(statusmessage == null) { statusmessage = ""; } if(img == "null" || img ==
		 * "NULL" || img == null) { //신규 회원가입이라면 기본 사진을 뽀려준다. img = "./image/man.jpg"; }
		 */
		return vo;
	}

	public ArrayList<UserVO> FriendCheck(String text, String sessionID) {
		// 아이디 프로필 사진, 상태메세지를 가져와 뽀려줘야한다.
		String sql = "";
		ArrayList<UserVO> list = new ArrayList<UserVO>(); 
		sql = "select * from user where id not in (select friendid from friend where friendid like '%" + text + "%') and id != '" + sessionID + "' and id like '%" + text + "%'";
		try {
			DBOpen();
			OpenQuery(sql);
			//m_SelectStatment.setString(1, id);
			ExecuteQuery();
			while (ResultNext()) {
				UserVO vo = new UserVO();
				vo.setId(getM_ResultSet().getString("id"));
				vo.setPictureRealName(getM_ResultSet().getString("pictureRealName"));
				vo.setStatusmessage(getM_ResultSet().getString("statusmessage"));
				list.add(vo);
			}
			CloseResultSet();
			CloseQuery();
			DBClose();
			if (list.size() == 0) {
				return null;
			}
		} catch (Exception e) {
			System.out.println("FriendCheck() 오류");
			System.out.println("ERROR : " + e.getMessage());
		}
		return list;
	}
	
	//친구리스트를 가져오는 함수
	public ArrayList<UserVO> PrintFriend(String sessionID) {
		ArrayList<UserVO> list = new ArrayList<UserVO>();
		String sql = "";
		try	{
			DBOpen();
			//아이디 이미지 상태메세지 가져와서 출력 			//친구추가한 사람의 id가 들어가야한다.			sessionid  
			sql = "select * from user where id = any (select friendid from friend where id = ?)";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, sessionID);
			ExecuteQuery();
			while (ResultNext()) {
				UserVO vo = new UserVO();
				vo.setNick(getM_ResultSet().getString("nick"));
				vo.setId(getM_ResultSet().getString("id"));
				vo.setStatusmessage(getM_ResultSet().getString("statusmessage"));
				vo.setPictureRealName(getM_ResultSet().getString("pictureRealName"));
				System.out.println("시작!!!!!!!!!!!!!!!!!!");
				System.out.println("닉네임 :::: "+getString("nick"));
				System.out.println("상태메세지 ::::"+getString("statusmessage"));
				System.out.println("사진이름 :::: "+getString("pictureRealName"));
				list.add(vo);
			}
			CloseResultSet();
			CloseQuery();
			DBClose();
		} catch(Exception e)	{
			System.out.println("AddFriend() 오류");
			System.out.println("ERROR : " + e.getMessage());
			return null;
		}
		return list;
	}
	
	
	//친구 추가해주는 함수
	public int AddFriend(String AddID, String sessionID)	{
		String sql = "";
		try	{
			DBOpen();
			sql = "insert into friend (id, friendid) values (?, ?)";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, sessionID);
			getM_SelectStatment().setString(2, AddID);
			ExcuteUpdate();
			CloseQuery();
			DBClose();
		} catch(Exception e)	{
			System.out.println("AddFriend() 오류");
			System.out.println("ERROR : " + e.getMessage());
			return -1;
		}
		return 1;		//잘되면 1
	}
	
	//친구 삭제해주는 함수
	public int DeleteFriend(String nick, String sessionID)	{
		String sql = "";
		sql = "delete from friend where friendid = (select id from user where nick = ?) and id = ?";
		try	{  
			DBOpen();
			OpenQuery(sql);
			getM_SelectStatment().setString(1, nick);
			getM_SelectStatment().setString(2, sessionID);//아이디가 아니고 닉네임이 들어간다.
			ExcuteUpdate();
			CloseQuery();
			DBClose();
		} catch(Exception e) {
			System.out.println("DeleteFriend() 오류");
			System.out.println("ERROR : " + e.getMessage());
			return -1;
		}
		return 1;
	}
	
	//친구목록 검색하면 실행되는 함수.
	public ArrayList<UserVO> SearchFriend(String text, String sessionID){
		//친구의 닉네임, 사진, 상태메세지
		String sql = "";
		ArrayList<UserVO> list = new ArrayList<UserVO>(); // sql = "select * from tab col like ?";
														  //pstmt.setString(1, "%"+keyword+"%");						세션아이디				 검색어
		sql = "select nick, pictureRealName, statusmessage from user where id in (select friendid from friend where (id = ?) and (friendid like ?))";
		try	{
			DBOpen();
			OpenQuery(sql);
			getM_SelectStatment().setString(1, sessionID);
			getM_SelectStatment().setString(2, "%" + text + "%");
			ExecuteQuery();
			while (ResultNext()) {
				UserVO vo = new UserVO();
				vo.setNick(getM_ResultSet().getString("nick"));
				vo.setStatusmessage(getM_ResultSet().getString("statusmessage"));
				vo.setPictureRealName(getM_ResultSet().getString("pictureRealName"));
				System.out.println("*********************** SearchFriend() 시작***********************");
				System.out.println("닉네임 :::: "+getString("nick"));
				System.out.println("상태메세지 ::::"+getString("statusmessage"));
				System.out.println("사진이름 :::: "+getString("pictureRealName"));
				list.add(vo);
			}
			CloseResultSet();
			CloseQuery();
			DBClose();
		} catch(Exception e) {
			System.out.println("SearchFriend() 오류");
			System.out.println("ERROR : " + e.getMessage());
			return null;
		}
		return list;
	}
	
	
	// DB에서 가져온 비밀번호와 클라이언트가 입력한 비밀번호를 비교하는 부분(로그인)
	public int LoginCheck(String id, String password) {
		try {
			DBOpen();
			String sql = "";
			sql = "select md5(md5(md5(md5(md5(md5(?))))))";
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, password);
			m_ResultSet = m_SelectStatment.executeQuery(); // 결과값 리턴
			while (ResultNext()) {
				password = m_ResultSet.getString("md5(md5(md5(md5(md5(md5('" + password + "'))))))");
			}
			sql = "select * from user where id = ?";// 클라이언트가 입력한 아이디를 가지고 있는 회원의 정보를 조회하는 sql문
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id);
			m_ResultSet = m_SelectStatment.executeQuery(); // 결과값 리턴
			if (ResultNext()) { // DB에 저장되어있는 비밀번호
				if (password.equals(m_ResultSet.getString("password"))) {// getString함수는 해당 순서의 열에있는 데이터를 String형으로 받아온단
																			// 뜻이다.
					m_ResultSet.close();
					m_SelectStatment.close();
					m_Connection.close();
					return 1; // 예를들어 mResultSet.getString(2)를 하게되면 2번째 열에있는 데이터를 가져오게 된다. 즉 컬럼이 name 과 num만
								// 있다고 가정하면
				} // 로그인 성공 // ㅣ--------consol------------------ㅣ
				else { // ㅣ김형태 111000 ㅣ
					m_ResultSet.close(); // ㅣ김형태 111000 ㅣ
					m_SelectStatment.close(); // ㅣ--------------------------------ㅣ
					m_Connection.close();
					return 0; // 비밀번호 틀림
				}
			} else {
				m_ResultSet.close();
				m_SelectStatment.close();
				m_Connection.close();
				return -1; // 존재하지 않는 아이디
			}
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return -2; // db 오류
		}
	}

	// *************************************************************************************************************************************

	// ****************************************아이디 중복확인 검사
	// 메서드************************************************************************

	public boolean CheckID(String id) {
		try {
			String sql = "select * from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id);
			m_ResultSet = m_SelectStatment.executeQuery(); // 결과값 리턴
			if (ResultNext()) { // id가 있으면 1
				m_ResultSet.close();
				m_SelectStatment.close();
				m_Connection.close();
				return false;
			} else { // id가 없으면 0
				m_ResultSet.close();
				m_SelectStatment.close();
				m_Connection.close();
				return true;
			}

		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false; // db 오류
		}
	}

	// ***************************관리자 페이지에서 클라이언트 목록 보여주는
	// 메서드**************************************************

	public boolean ClientList() {
		try {
			String sql = "select * from user";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_ResultSet = m_SelectStatment.executeQuery(); // 결과값 리턴
			return true;
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false; // db 오류
		}
	}
	// ***********************관리자가 클라이언트 정보 삭제하는
	// 메서드********************************************************************************

	public boolean MemberDelete(String deleteid) {
		try {
			String sql = "delete from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, deleteid);
			m_SelectStatment.executeUpdate(); // 쿼리실행하면 실행 결과를 java.sql.ResultSet형으로 리턴한다.
			// m_SelectStatment 를 닫는다.
			m_SelectStatment.close();
			return true;
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false; // db 오류
		}
	}
	// ********************회원 정보를 보여주는 메서드(관리자만 볼
	// 수있음)****************************************************************************************************

	public boolean MemberInfo(String infoid) {
		try {// user 테이블에서 정보를 확인할 아이디를 가지고 있는 회원 정보를 user 테이블에서 조회*********
			String sql = "select * from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, infoid);
			m_ResultSet = m_SelectStatment.executeQuery();
			return true;
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false; // db 오류
		}
	}
	// *********************************************************************************************************************

	// **********************첨부파일을 다운로드 할 때마다 다운로드 횟수를 증가시켜주는
	// 메서드********************************************

	public void downloadcount(String filedownload) {
		String sql = "update board set downloadcount = downloadcount + 1 where filerealname='" + filedownload + "'";
		try {
			DBOpen();
			ExcuteUpdate(sql);
			DBClose();
		} catch (Exception e) {
			System.out.println("첨부파일 카운트를 증가하는데 있어 오류");
			System.out.println("ERROR:" + e.getMessage());
		}
	}

	// *******************************************************************************************************************

	// *************************************댓글 등록 해주는
	// 메서드*****************************************************************

	public boolean commentok(String no, String id, String note) {
		String sql = "insert into comment (no, id, Reply, Rdate) values ('" + no + "', '" + id + "', '" + note
				+ "', now())";
		try { // 작성자, 내용, 작성일
			DBOpen();
			ExcuteUpdate(sql);
			DBClose();
			return true; // 댓글을 등록하면 true 반환
		} catch (Exception e) {
			System.out.println("ERROR : " + e.getMessage()); // 실패하면 false
			return false;
		}
	}

	// *******************************************************************************************************************

}