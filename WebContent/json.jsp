<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% String chatno = request.getParameter("chatno"); %>
{
"comment" : 
[
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
		
		String query = "select count(*) from anonymous where roomid="+chatno;
		
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery(); 
		
		if(rs.next()){
		count = Integer.parseInt(rs.getString(1));
		}
		
		query = "select sessionid, content, time from anonymous ";
		pstmt = conn.prepareStatement(query);
		
		rs = pstmt.executeQuery();
		if(rs.next()){
		do {
			String id = rs.getString(1);
			String content = rs.getString(2);
			String time = rs.getString(3);
%>
 	{
	"id" : "<%=id%>", 
	"content" : "<%=content%>",
	"time" : "<%= time %>"
	}
<%	
		if(rs.getRow()<count){
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
]
}