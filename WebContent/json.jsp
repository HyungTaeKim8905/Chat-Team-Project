<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
		
		String query = "select count(*) from comment";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery(); 
		
		
		
		if(rs.next()){
		count = Integer.parseInt(rs.getString(1));
		}
		
		
		query = "select id, name, content  from comment ";
		pstmt = conn.prepareStatement(query);
		
		rs = pstmt.executeQuery();
		if(rs.next()){
		do {
			int id = rs.getInt(1);
			String name = rs.getString(2);
			String content = rs.getString(3);
%>
 	{
	"id" : <%=id%>, 
	"name" : "<%=name%>",
	"content" : "<%=content%>"
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