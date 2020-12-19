<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="util.Util"%>
<% 
	String id = request.getParameter("id"); //로그인한 사람의 아이디
	
	String chatno = "";
	String otherid = "";
%>
{ "chatlist" : [
<%
	String  DBURL     = "jdbc:mysql://127.0.0.1/project02?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";	
	String  DBID   = "root";
	String  DBPass = "mySQL1234";
	
	Connection        conn;
	PreparedStatement pstmt;
	ResultSet         rs;
	Integer count = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( DBURL, DBID ,DBPass );
		
		//마지막 객체 이전까지만 쉼표 찍을 수 있도록 쿼리 갯수를 구함
		//로그인 한 사람이 속해있는 채팅방의 개수를 구함.
		String query = "select count(*) from chatperson where id='"+id+"'";
		
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			count = Integer.parseInt(rs.getString(1));		//2
		}
		
		//채팅참여 테이블에 있는 id와 현재 접속 id가 같은 채팅방 번호를 불러와서 채팅방 목록으로 뿌려주고
		//채팅방에 접속하면 채팅내용 테이블의 채팅방 번호와 해당 채팅방 번호가 일치하는 채팅방을 불러옴 
		/*
			select no from chatperson where chatperson.id = 'gudxo1226'; -- 로그인한 사람이 속해있는 채팅방의 방 번호를 가져온다. --------> 4, 5가 불러와짐.
			로그인 한 사람이 속해있는 채팅방을 불러와서(4, 5) 그 각각의 채팅방에서 로그인한 사람의 아이디가 아닌 다른 사람의 아이디를 가져와서 그 다른 사람이 속해있는 채팅방 번호와 
			닉네임 그리고 마지막 채팅 날짜를 가져온다.
		*/
		query = "select no, nick, lasttime ";
		query += "from user inner join chatperson ";
		query += "on user.id = chatperson.id ";
		query += "where chatperson.id != '" + id;
		query += "' and no in(select no from chatperson where chatperson.id='"+ id + "') ";
		query += "order by lasttime desc;";
		pstmt = conn.prepareStatement(query);
		
		rs = pstmt.executeQuery();
		if(rs.next()){
		do {
			chatno = rs.getString(1);
			otherid = rs.getString(2);
			
%>
{ "chatno" : "<%=chatno%>", "otherid" : "<%=otherid%>" }
<%		//마지막 객체 이전에는 쉼표를 찍어서 객체 구분
		if(rs.getRow() < count){
%>
,
<%
		}
		}while (rs.next());
		}
		
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		
		}catch(Exception e){
			out.print("에러 : " + e);	
		}
%>
] }
