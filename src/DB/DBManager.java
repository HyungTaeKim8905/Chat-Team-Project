package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/*
insert, update, delete 쿼리를 날릴 때는 executeUpdate() 함수를 사용한다.왜냐하면 결과 값이 없기 때문에.
select 쿼리를 날릴 때는	executeQuery() 함수를 사용한다.왜냐하면 결과 값을 받아와야 하기 때문에.
*/
public class DBManager {		//타임을 인식하지 못하기 때문에 serverTimezone=UTC 써준다.
	protected String m_DBMS = "jdbc:mysql://127.0.0.1/project02?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	protected String m_UserID = "root";
	protected String m_UserPass = "mySQL1234";
	// Statement 객체는 SQL문을 데이터베이스로 전송하는데 사용한다.
	protected Connection m_Connection;
	protected PreparedStatement m_SelectStatment; // Statement로 부터 상속받음  동적인 쿼리에 사용되며 하나의 객체로 여러번의 쿼리를 실행할 수 있다.
	protected ResultSet m_ResultSet;
	
	public PreparedStatement ps() {
		return m_SelectStatment;
	}

	public String getVersion() {
		return "Java Beans Board v1.0";
	}

	// MySQL 연결을 위한 라이브러리를 로딩한다.
	protected boolean LoadDriver() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // com.mysql.cj.jdbc 의 클래스에 있는 Driver클래스를 쓰겠다는 뜻
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// MySQL에 접속한다.
	public boolean DBOpen() {
		if (LoadDriver() == false) {
			return false;
		}
		try {
			this.m_Connection = DriverManager.getConnection(m_DBMS, m_UserID, m_UserPass);
		} // DriverManager.getConnection() 메소드를 호출하여 데이터베이스에 연결하고 Connection 객체를 반환
		catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// MySQL 접속을 종료한다.
	public void DBClose() {
		try {
			
			this.m_Connection.close(); // db 연결 종료
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage()); // 오류 발생시 캐치문
			return;
		}
	}
	
	// Query를 수행한다.			
	public boolean OpenQuery(String pSQL) {
		try {
			//select(조회)문을 전송할  사용하는 메서드로, ResultSet 객체를 반환한다.
			//이 때, ResultSet이란 select를 실행하여 테이블로부터 얻은 결과를 저장하고있는 저장소라고 생각
			this.m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			
			//m_ResultSet = m_SelectStatment.executeQuery();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	public boolean ExecuteQuery()	{
		try	{
			
			this.m_ResultSet = this.m_SelectStatment.executeQuery();
			System.out.println("실행");
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			System.out.println("resultset이 널이다.");
			return false;
		}
		return true;
	}
	

	// Insert, Delete, Update 처리용 함수
	public boolean ExcuteUpdate(String pSQL) // 불린 타입의 값을 반환
	{
		try {
			this.m_SelectStatment.executeUpdate(); // 쿼리실행하면 실행 결과를 java.sql.ResultSet형으로 리턴한다
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	// Result를 닫는다.
	public boolean CloseResultSet()	{
		try {
			// 검색된 결과를 닫는다.
			this.m_ResultSet.close();

		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	// Query를 종료한다.
	public void CloseQuery() {
		try {
			
			// stmt 를 닫는다.
			this.m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return;
		}
	}

	// 다음 레코드로 이동한다. 다음 줄로 넘어가는 메소드
	public boolean ResultNext() {// 결과값(DB에 저장되어있는 데이터의 총 개수)을 얻어옴
		try {
			return m_ResultSet.next();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
	}

	// 레코드의 값을 얻는다.
	public String getString(String pName) {
		try {
			return this.m_ResultSet.getString(pName);
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return null;
		}
	}

	// 레코드의 값을 얻는다.
	public int getInt(String pName) {
		try {
			return Integer.parseInt(this.m_ResultSet.getString(pName));
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return 0;
		}
	}
}