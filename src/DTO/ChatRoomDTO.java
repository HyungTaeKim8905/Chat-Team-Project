package DTO;

import java.sql.ResultSet;
import java.util.ArrayList;

import DB.DBManager;
import VO.ChatRoomVO;

public class ChatRoomDTO extends DBManager {
	
	//Ư���� ���̵� ���� ä�� ������ �������� �Լ�
	public ArrayList<ChatRoomVO> getChatListByID(String no, String fromID, String toID){
		ArrayList<ChatRoomVO> chatList = null;
		String sql = "";
		//���� ����̵簣�� ���� ����̵� ���� ���δ� �����ü� �ֵ��� ��.
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
				String timeType = "����";
				if(chatTime > 12) {
					timeType = "����";
					chatTime -= 12;
				}
				vo.setDate(m_ResultSet.getString("date").substring(0, 11) + " " + timeType + " " + chatTime + ":" + m_ResultSet.getString("date").substring(14, 16));
				chatList.add(vo);
				m_ResultSet.close();	
				m_SelectStatment.close();
				m_Connection.close(); // db ���� ����
			}
		} catch(Exception e) {
			System.out.println("ERROR: " + e.getMessage());
		}
		return chatList;	//��� ä�� ������ ������.
	}
	
	
	// ��ȭ �����߿��� �ֱٿ� ��� �̾ƿ��� �Լ�
	public ArrayList<ChatRoomVO> getChatByRecent(int number, String fromID, String toID){
		ArrayList<ChatRoomVO> chatList = null;
		String sql = "";
		//���� ����̵簣�� ���� ����̵� ���� ���δ� �����ü� �ֵ��� ��.
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
				String timeType = "����";
				if(chatTime > 12) {
					timeType = "����";
					chatTime -= 12;
				}
				vo.setDate(m_ResultSet.getString("date").substring(0, 11) + " " + timeType + " " + chatTime + ":" + m_ResultSet.getString("date").substring(14, 16));
				chatList.add(vo);
				m_ResultSet.close();	
				m_SelectStatment.close();
				m_Connection.close(); // db ���� ����
			}
		} catch(Exception e) {
			System.out.println("ERROR: " + e.getMessage());
		}
		return chatList;	//��� ä�� ������ ������.
	}
	
	
	// �ٸ� ������� ��� �޼����� ������ ���۱���� �Լ�
	public int submit(String fromID, String toID, String content){
		String sql = "";
		//���� ����̵簣�� ���� ����̵� ���� ���δ� �����ü� �ֵ��� ��.
		sql += "insert into chatroom values(NULL, ?, ?, ?, NOW(), 0)";
		// null���� �������ν� no�� +1 �ڵ����� ����
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
					m_Connection.close(); // db ���� ����
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return -1;	//DB ����
		}
}
