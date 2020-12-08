package DTO;

import java.sql.ResultSet;
import java.util.ArrayList;

import DB.DBManager;
import VO.ChatRoomVO;

public class ChatRoomDTO extends DBManager {
	
	//특정한 아이디에 따라서 채팅 내역을 가져오는 함수
	public ArrayList<ChatRoomVO> getChatListByID(String no, String fromID, String toID){
		ArrayList<ChatRoomVO> chatList = null;
		String sql = "";
		//보낸 사람이든간에 받은 사람이든 간에 전부다 가져올수 있도록 함.
		sql += "select * from chatroom where ((fromID = ? and toID = ?) or (fromID = ? and toID = ?)) and no > ? order by date";
		try	{
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, fromID);
			m_SelectStatment.setString(2, toID);
			m_SelectStatment.setString(3, toID);
			m_SelectStatment.setString(4, fromID);
			m_SelectStatment.setInt(5, Integer.parseInt(no));
			m_ResultSet = m_SelectStatment.executeQuery();
			chatList = new ArrayList<ChatRoomVO>();
			while(m_ResultSet.next())	{
				ChatRoomVO vo = new ChatRoomVO();
				vo.setNo(m_ResultSet.getInt("no"));
				vo.setFromID(m_ResultSet.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;").replaceAll("\n", "<br>"));
				vo.setToID(m_ResultSet.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;").replaceAll("\n", "<br>"));
				vo.setContent(m_ResultSet.getString("content").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(m_ResultSet.getString("date").substring(11, 13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				vo.setDate(m_ResultSet.getString("date").substring(0, 11) + " " + timeType + " " + chatTime + ":" + m_ResultSet.getString("date").substring(14, 16));
				chatList.add(vo);
				m_ResultSet.close();	
				m_SelectStatment.close();
				m_Connection.close(); // db 연결 종료
			}
		} catch(Exception e) {
			System.out.println("ERROR: " + e.getMessage());
		}
		return chatList;	//모든 채팅 내역을 리턴함.
	}
	
	
	// 대화 내역중에서 최근에 몇개만 뽑아오는 함수
	public ArrayList<ChatRoomVO> getChatByRecent(int number, String fromID, String toID){
		ArrayList<ChatRoomVO> chatList = null;
		String sql = "";
		//보낸 사람이든간에 받은 사람이든 간에 전부다 가져올수 있도록 함.
		sql += "select * from chatroom where ((fromID = ? and toID = ?) or (fromID = ? and toID = ?)) and no > (select max(no) - ? from chatroom where(fromID = ? and toID = ?) or (fromID = ? and toID = ?)) order by date";
		try	{
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
			chatList = new ArrayList<ChatRoomVO>();
			while(m_ResultSet.next())	{
				ChatRoomVO vo = new ChatRoomVO();
				vo.setNo(m_ResultSet.getInt("no"));
				vo.setFromID(m_ResultSet.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;").replaceAll("\n", "<br>"));
				vo.setToID(m_ResultSet.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;").replaceAll("\n", "<br>"));
				vo.setContent(m_ResultSet.getString("content").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(m_ResultSet.getString("date").substring(11, 13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				vo.setDate(m_ResultSet.getString("date").substring(0, 11) + " " + timeType + " " + chatTime + ":" + m_ResultSet.getString("date").substring(14, 16));
				chatList.add(vo);
				m_ResultSet.close();	
				m_SelectStatment.close();
				m_Connection.close(); // db 연결 종료
			}
		} catch(Exception e) {
			System.out.println("ERROR: " + e.getMessage());
		}
		return chatList;	//모든 채팅 내역을 리턴함.
	}
	
	
	// 다른 사람한테 어떠한 메세지를 보내는 전송기능인 함수
	public int submit(String fromID, String toID, String content){
		String sql = "";
		//보낸 사람이든간에 받은 사람이든 간에 전부다 가져올수 있도록 함.
		sql += "insert into chatroom values(NULL, ?, ?, ?, NOW(), 0)";
		// null값을 넣음으로써 no가 +1 자동으로 증가
		try	{
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, fromID);
			m_SelectStatment.setString(2, toID);
			m_SelectStatment.setString(3, content);
			return m_SelectStatment.executeUpdate();
			} catch(Exception e) {
				System.out.println("ERROR: " + e.getMessage());
			} finally	{
				try	{
					m_ResultSet.close();	
					m_SelectStatment.close();
					m_Connection.close(); // db 연결 종료
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return -1;	//DB 에러
		}
}
