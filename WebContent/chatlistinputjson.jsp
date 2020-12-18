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
		
		String query = "insert into chatroom values() ;";
		
		
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		pstmt.close();
		
		query = "select roomid from chatroom order by roomid desc limit 1; ";
		
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery(); 
		
		String lastno = "";
		while(rs.next()){
		lastno = rs.getString(1);
		}
		
		rs.close();
		pstmt.close();
		
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