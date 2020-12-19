<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.Util" %>

<% 
	String myid = request.getParameter("myid"); 
	String otherid = request.getParameter("otherid");

	String  DBURL  = "jdbc:mysql://127.0.0.1/project02?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";	
	String  DBID   = "root";
	String  DBPass = "mySQL1234";
	
	Connection        conn;
	PreparedStatement pstmt;
	ResultSet         rs;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( DBURL, DBID ,DBPass );
		
		//채팅방을 만들기 위해 roomid를 +1 해줌.		
		String query = "insert into chatroom values() ;";

		
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		pstmt.close();
		
		//맨 마지막으로 개설한 채팅방이 화면에는 위에 와야하기 때문에 chatroom테이블의 마지막 roomid값을 가져온다.
		// select max(roomid) from chatroom;
		query = "select roomid from chatroom order by roomid desc limit 1;";
		
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery(); 
		
		String lastno = "";		
		
		while(rs.next()){
		lastno = rs.getString(1);	//마지막 채팅방 번호(roomid)를 가져온다. lastno = 4
		}
		
		rs.close();
		pstmt.close();
		
		//채팅방을 만들고 그 채팅방에 초대한 사람과 초대받은 사람 그리고 채팅방 개설 일자를 저장.
		query = "insert into chatperson(no, id, lasttime) values(?,?,now()) ;";
		
		
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, lastno);
		pstmt.setString(2, myid);
		
		pstmt.executeUpdate();
		pstmt.close();
		
		query = "insert into chatperson(no, id, lasttime) values(?,?,now()) ;";
		
		
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, lastno);
		pstmt.setString(2, otherid);
		
		pstmt.executeUpdate();
		pstmt.close();
		
		conn.close();
	}catch(Exception e) {
		out.print("오류 : " + e);
	}

%>