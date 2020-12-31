<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.Util" %>
<% 
	String chatno = request.getParameter("chatno");
	String id = "";
	String content = "";
	String time = "";
	String filecheck = "";
%>
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
		
		//마지막 객체 이전에만 쉼표 찍을 수 있도록 쿼리 갯수를 구함  
		String query = "select count(*) from chatcontent where roomid='"+chatno+ "'";
		
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery(); 
		
		if(rs.next()){
		count = Integer.parseInt(rs.getString(1));
		}
		
		// n번 채팅방에 있는 채팅 목록 가져옴
		query = "select id, content, time, filecheck from chatcontent where roomid='"+chatno+ "'";
		pstmt = conn.prepareStatement(query);
		
		rs = pstmt.executeQuery();
		if(rs.next()){
		do {
			id = rs.getString(1);
			content = rs.getString(2);
			time = rs.getString(3);
			filecheck = rs.getString(4);
			
			if(!(filecheck.equals("1"))){
				content = Util.toJS(content);
			}else if(filecheck.equals("1")){
				content = Util.toFileJS(content);
			}

%>
 	{
	"id" : "<%=id%>", 
	"content" : "<%= content %>",
	"time" : "<%= time %>"
	}
<%	//마지막 객체 이전에는 쉼표를 찍어서 객체 구분
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