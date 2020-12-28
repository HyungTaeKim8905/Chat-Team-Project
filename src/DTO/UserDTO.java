package DTO;

import java.sql.ResultSet;
import java.util.ArrayList;

import DB.DBManager;
import VO.UserVO;

public class UserDTO extends DBManager {

	// 비밀번호 변경하면 실행되는 메서드
	public int ChangePassWord(String id, String password) {
		try {
			String sql = "update user set password = md5(md5(md5(md5(md5(md5(?)))))) where id = ?";
			DBOpen();
			OpenQuery(sql);
			getM_SelectStatment().setString(1, password);
			getM_SelectStatment().setString(2, id);
			ExcuteUpdate();
			CloseQuery();
			DBClose();
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return -1;
		}
		return 1;
	}

	// 회원가입하면 실행되는 메서드
	public int Join(String id, String password, String nick, String email, String address, String phone) {
		int result = 1;
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
			// 회원가입 성공하면 1 반환
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			result =  0; // 실패하면 0 반환
		}
		return result;
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
			DBOpen();
			if(filename == null || filerealname == null)	{
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
		return vo;
	}

	public ArrayList<UserVO> FriendCheck(String text, String sessionID) {
		// 아이디 프로필 사진, 상태메세지를 가져와 뽀려줘야한다.
		String sql = "";
		ArrayList<UserVO> list = new ArrayList<UserVO>(); 
		// 즉 친구목록에 있는 친구들과 로그인한 사람의 아이디를 뺀 나머지 친구목록을 가져옴
		sql = "select * from user where id not in (select friendid from friend where friendid like '%" + text + "%' and id = '"+sessionID+"') and id != '" + sessionID + "' and id like '%" + text + "%'";
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
		sql = "delete from friend where friendid = ? and id = ?";
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
				/*
				System.out.println("*********************** SearchFriend() 시작***********************");
				System.out.println("닉네임 :::: "+getString("nick"));
				System.out.println("상태메세지 ::::"+getString("statusmessage"));
				System.out.println("사진이름 :::: "+getString("pictureRealName"));
				*/
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
		String sql = "";
		DBOpen();
		try {
			sql = "select md5(md5(md5(md5(md5(md5(?))))))";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, password);
			ExecuteQuery();
			while (ResultNext()) {
				password = getM_ResultSet().getString("md5(md5(md5(md5(md5(md5('" + password + "'))))))");
			}
			// 클라이언트가 입력한 아이디를 가지고 있는 회원의 정보를 조회하는 sql문
			sql = "select * from user where id = ?";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, id);
			ExecuteQuery(); // 결과값 리턴
			if (ResultNext()) { 
				// DB에 저장되어있는 비밀번호
				// getString함수는 해당 순서의 열에있는 데이터를 String형으로 받아온단 뜻이다.
				if (password.equals(getM_ResultSet().getString("password"))) {
					CloseResultSet();
					CloseQuery();
					DBClose();
					return 1; // 예를들어 mResultSet.getString(2)를 하게되면 2번째 열에있는 데이터를 가져오게 된다. 즉 컬럼이 name 과 num만
								// 있다고 가정하면
				} // 로그인 성공 					// ㅣ--------consol------------------ㅣ
				else {						    // ㅣ김형태 111000                     ㅣ
					CloseResultSet(); 		    // ㅣ김형태 111000                     ㅣ
					CloseQuery(); 				// ㅣ--------------------------------ㅣ
					DBClose();
					return 0; // 비밀번호 틀림
				}
			} else {
				CloseResultSet();
				CloseQuery();
				DBClose();
				return -1; // 존재하지 않는 아이디
			}
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return -2; // db 오류
		}
	}

	// 아이디 중복확인 검사
	public boolean CheckID(String id) {
		boolean check = true;
		
		DBOpen();
		
		try {
			String sql = "select * from user where id=?";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, id);
			ExecuteQuery(); 
			if (ResultNext()) {
				check = false;
			}
			CloseResultSet();
			CloseQuery();
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			check = false; // db 오류
		}
		
		DBClose();
		return check;
	}
	
	//회원탈퇴하면 실행되는 메서드
	public int WithDrawal(String sessionID) {
		int    check = 1;
		String sql = "";
		DBOpen();
		
		try	{
			sql = "delete from chatperson where id = ?";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, sessionID);
			ExcuteUpdate();
			CloseQuery();
			
			sql = "delete from friend where (id = ?) and (friendid = id)";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, sessionID);
			ExcuteUpdate();
			CloseQuery();
			
			sql = "delete from user where id = ?";
			OpenQuery(sql);
			getM_SelectStatment().setString(1, sessionID);
			ExcuteUpdate();
			CloseQuery();
		} catch(Exception e) {
			System.out.println("WithDrawal() 오류");
			System.out.println("ERROR : " + e.getMessage());
			check = -1;
		}		
		
		DBClose();
		return check;
	}
}