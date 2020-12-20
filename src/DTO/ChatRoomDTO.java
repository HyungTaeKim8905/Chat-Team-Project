package DTO;

import java.sql.ResultSet;
import java.util.ArrayList;

import DB.DBManager;
import VO.ChatRoomVO;

public class ChatRoomDTO extends DBManager {

	// 특정한 아이디에 따라서 채팅 내역을 가져오는 함수
	public ArrayList<ChatRoomVO> ChttingListID(int no, String fromID, String toID) {
		ArrayList<ChatRoomVO> list = null;
		String sql = "";
		// 보낸 사람이든간에 받은 사람이든 간에 전부다 가져올수 있도록 함.
		sql += "select * from chatroom where ((fromID = ? and toID = ?) or (fromID = ? and toID = ?)) and no > ? order by date ;";
		try {
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, fromID);
			m_SelectStatment.setString(2, toID);
			m_SelectStatment.setString(3, toID);
			m_SelectStatment.setString(4, fromID);
			m_SelectStatment.setInt(5, no);
			m_ResultSet = m_SelectStatment.executeQuery();
			list = new ArrayList<ChatRoomVO>();
			while (m_ResultSet.next()) {
				ChatRoomVO vo = new ChatRoomVO();
				vo.setNo(m_ResultSet.getInt("no"));
				vo.setFromID(m_ResultSet.getString("fromID"));
				vo.setToID(m_ResultSet.getString("toID"));
				vo.setContent(m_ResultSet.getString("content"));
				int date = Integer.parseInt(m_ResultSet.getString("date").substring(11, 13));
				String time = "오전";
				if (date > 12) {
					time = "오후";
					date -= 12;
				}
				vo.setDate(m_ResultSet.getString("date").substring(0, 11) + " " + time + " " + date + ":"
						+ m_ResultSet.getString("date").substring(14, 16));
				list.add(vo);
			}
			m_ResultSet.close();
			m_SelectStatment.close();
			m_Connection.close(); // db 연결 종료
		} catch (Exception e) {
			System.out.println("ChttingListID() 에러");
			System.out.println("ERROR: " + e.getMessage());
		}
		return list; // 모든 채팅 내역을 리턴함.
	}

	// 대화 내역중에서 최근에 몇개만 뽑아오는 함수
	public ArrayList<ChatRoomVO> ChttingListQuick(String fromID, String toID, int number) {
		ArrayList<ChatRoomVO> list = null;
		String sql = "";
		// 보낸 사람이든간에 받은 사람이든 간에 전부다 가져올수 있도록 함.
		sql += "select * from chatroom where ((fromID = ? and toID = ?) or (fromID = ? and toID = ?)) and no > (select max(no) - ? from chatroom where(fromID = ? and toID = ?) or (fromID = ? and toID = ?)) order by date";
		try {
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, fromID);
			m_SelectStatment.setString(2, toID);
			m_SelectStatment.setString(3, toID);
			m_SelectStatment.setString(4, fromID);
			m_SelectStatment.setInt(5, number);
			m_SelectStatment.setString(6, fromID);
			m_SelectStatment.setString(7, toID);
			m_SelectStatment.setString(8, toID);
			m_SelectStatment.setString(9, fromID);
			m_ResultSet = m_SelectStatment.executeQuery();
			list = new ArrayList<ChatRoomVO>();
			while (m_ResultSet.next()) {
				ChatRoomVO vo = new ChatRoomVO();
				vo.setNo(m_ResultSet.getInt("no"));
				vo.setFromID(m_ResultSet.getString("fromID"));
				vo.setToID(m_ResultSet.getString("toID"));
				vo.setContent(m_ResultSet.getString("content"));
				int date = Integer.parseInt(m_ResultSet.getString("date").substring(11, 13));
				String time = "오전";
				if (date > 12) {
					time = "오후";
					date -= 12;
				}
				vo.setDate(m_ResultSet.getString("date").substring(0, 11) + " " + time + " " + date + ":"
						+ m_ResultSet.getString("date").substring(14, 16));
				list.add(vo);
			}
			m_ResultSet.close();
			m_SelectStatment.close();
			m_Connection.close(); // db 연결 종료
		} catch (Exception e) {
			System.out.println("ChttingListQuick() 에러");
			System.out.println("ERROR: " + e.getMessage());
		}
		return list; // 모든 채팅 내역을 리턴함.
	}

	// 다른 사람한테 메세지를 보내는 전송기능 함수
	public int Submit(String fromID, String toID, String content) {
		String sql = "";
		System.out.println("submit() =>" + fromID);
		System.out.println("submit() =>" + toID);
		System.out.println("submit() =>" + content);
		// 보낸 사람이든간에 받은 사람이든 간에 전부다 가져올수 있도록 함.
		sql += "insert into chatroom values (NULL, ?, ?, ?, NOW())";
		// null값을 넣음으로써 no가 +1 자동으로 증가
		try {
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, fromID);
			m_SelectStatment.setString(2, toID);
			m_SelectStatment.setString(3, content);
			m_SelectStatment.executeUpdate();
			m_SelectStatment.close();
			m_Connection.close(); // db 연결 종료
			return 1;
		} catch (Exception e) {
			System.out.println("submit() 오류");
			System.out.println("ERROR: " + e.getMessage());
		}
		return -1; // DB 에러
	}

	// 파일을 올렸을때 실행되는 함수.
	public int FileSubmit(String sessionID, ArrayList<String> content, String roomid) {
		String sql = "";
		String lastNo = "";
		try {
			DBOpen();
			for (int i = 0; i < content.size(); i++) {
				sql = "insert into chatcontent(roomid, id, content, time, filecheck) values(?,?,?,now(),?)";
				String file = "<a href='file_down.jsp?file_name=" + content.get(i) + "'>" + content.get(i) + "</a>";
				OpenQuery(sql);
				getM_SelectStatment().setString(1, roomid);
				getM_SelectStatment().setString(2, sessionID);
				getM_SelectStatment().setString(3, file);
				getM_SelectStatment().setString(4, "1");
				ExcuteUpdate();
				CloseQuery();
				sql = "select max(chatno) as count from chatcontent where roomid = ?";
				OpenQuery(sql);
				getM_SelectStatment().setString(1, roomid);
				ExecuteQuery();
				while(ResultNext()) {
					lastNo = getM_ResultSet().getString("count");
				}
				CloseResultSet();
				CloseQuery();
				sql = "insert into file (roomid, chatno, fileName, FOriginName, id, time) values (?, ?, ?, ?, ?, NOW())";
				OpenQuery(sql);
				getM_SelectStatment().setString(1, roomid);
				getM_SelectStatment().setString(2, lastNo);
				getM_SelectStatment().setString(3, content.get(i));
				getM_SelectStatment().setString(4, content.get(i));
				getM_SelectStatment().setString(5, sessionID);
				ExcuteUpdate();
				CloseQuery();
			}
			DBClose();
		} catch (Exception e) {
			System.out.println("submit() 오류");
			System.out.println("ERROR: " + e.getMessage());
			return -1;
		}
		return 1; // DB 에러
	}
}
