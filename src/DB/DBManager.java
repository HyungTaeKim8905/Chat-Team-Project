package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/*
insert, update, delete ������ ���� ���� executeUpdate() �Լ��� ����Ѵ�.�ֳ��ϸ� ��� ���� ���� ������.
select ������ ���� ����	executeQuery() �Լ��� ����Ѵ�.�ֳ��ϸ� ��� ���� �޾ƿ;� �ϱ� ������.
*/
public class DBManager {		//Ÿ���� �ν����� ���ϱ� ������ serverTimezone=UTC ���ش�.
	protected String m_DBMS = "jdbc:mysql://127.0.0.1/project02?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	protected String m_UserID = "root";
	protected String m_UserPass = "mySQL1234";
	// Statement ��ü�� SQL���� �����ͺ��̽��� �����ϴµ� ����Ѵ�.
	protected Connection m_Connection;
	protected PreparedStatement m_SelectStatment; // Statement�� ���� ��ӹ���  ������ ������ ���Ǹ� �ϳ��� ��ü�� �������� ������ ������ �� �ִ�.
	protected ResultSet m_ResultSet;
	
	public PreparedStatement getPreparedStatement()	{
		return m_SelectStatment;
	}
	
	public String getVersion() {
		return "Java Beans Board v1.0";
	}

	public void setUserID(String id) {
		m_UserID = id;
	}

	public void setPassword(String pw) {
		m_UserPass = pw;
	}

	// MySQL ������ ���� ���̺귯���� �ε��Ѵ�.
	protected boolean LoadDriver() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // com.mysql.cj.jdbc �� Ŭ������ �ִ� DriverŬ������ ���ڴٴ� ��
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// MySQL�� �����Ѵ�.
	public boolean DBOpen() {
		if (LoadDriver() == false) {
			return false;
		}
		try {
			m_Connection = DriverManager.getConnection(m_DBMS, m_UserID, m_UserPass);
		} // DriverManager.getConnection() �޼ҵ带 ȣ���Ͽ� �����ͺ��̽��� �����ϰ� Connection ��ü�� ��ȯ
		catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// MySQL ������ �����Ѵ�.
	public void DBClose() {
		try {
			m_Connection.close(); // db ���� ����
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage()); // ���� �߻��� ĳġ��
			return;
		}
	}
	
	// Query�� �����Ѵ�.			
	public boolean OpenQuery(String pSQL) {
		try {
			//select(��ȸ)���� ������ �� ����ϴ� �޼����, ResultSet ��ü�� ��ȯ�Ѵ�.
			//�� ��, ResultSet�̶� select�� �����Ͽ� ���̺�κ��� ���� ����� �����ϰ��ִ� ����Ҷ�� ����
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			
			m_ResultSet = m_SelectStatment.executeQuery();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// Query�� �����Ѵ�.
	public void CloseQuery() {
		try {
			// �˻��� ����� �ݴ´�.
			m_ResultSet.close();

			// stmt �� �ݴ´�.
			m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return;
		}
	}

	// ���� ���ڵ�� �̵��Ѵ�. ���� �ٷ� �Ѿ�� �޼ҵ�
	public boolean ResultNext() {// �����(DB�� ����Ǿ��ִ� �������� �� ����)�� ����
		try {
			return m_ResultSet.next();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
	}

	// ���ڵ��� ���� ��´�.
	public String getString(String pName) {
		try {
			return m_ResultSet.getString(pName);
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return null;
		}
	}

	// ���ڵ��� ���� ��´�.
	public int getInt(String pName) {
		try {
			return Integer.parseInt(m_ResultSet.getString(pName));
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return 0;
		}
	}

	// Insert, Delete, Update ó���� �Լ�
	public boolean Excute(String pSQL) // �Ҹ� Ÿ���� ���� ��ȯ
	{
		try { //// Ŀ���̵���� //���������� ���
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.executeUpdate(); // ���������ϸ� ���� ����� java.sql.ResultSet������ �����Ѵ�.
			// m_SelectStatment �� �ݴ´�.
			m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	public boolean Excutee(String pSQL) // �Ҹ� Ÿ���� ���� ��ȯ
	{
		try { //// Ŀ���̵���� //���������� ���
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.executeUpdate(); // ���������ϸ� ���� ����� java.sql.ResultSet������ �����Ѵ�.
			// m_SelectStatment �� �ݴ´�.
			//m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
}
