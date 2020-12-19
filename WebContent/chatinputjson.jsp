<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.Util" %>

<% 	//채팅내용을 저장해주는 로직
	String chatno = request.getParameter("chatno"); 
	String message = request.getParameter("message");
	out.print(message);
	//message = Util.toJS(message);
	String sessionid = request.getParameter("sessionid");

	String  DBURL  = "jdbc:mysql://127.0.0.1/project02?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";	
	String  DBID   = "root";
	String  DBPass = "mySQL1234";
	
	Connection        conn;
	PreparedStatement pstmt;
	ResultSet         rs;
	 
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( DBURL, DBID ,DBPass );
		
		//채팅 내용 저장
		String query = "insert into chatcontent(roomid, id, content, time) values(?,?,?,now()) ;";
		
		
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, chatno);
		pstmt.setString(2, sessionid);
		pstmt.setString(3, message);
		
		pstmt.executeUpdate();
		pstmt.close();
		
		// 만약에 어떠한 사용자가 어떠한 채팅방에 대한 글을 썻다면 화면에서 보여지는 채팅방의 순서가
		// 위로 올라가야 하기 때문에 chatperson 테이블에 날짜를 업데이트 해줌.
		query = "update chatperson set lasttime = now() where no = (?) ;";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, chatno);
		
		pstmt.executeUpdate();
		pstmt.close();
		
		conn.close();
	}catch(Exception e) {
		out.print("오류 : " + e);
	}

%>