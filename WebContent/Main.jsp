<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
		if(id == null){
			%><h1>로그인 안되어있네 @@@@@@@@@@@@~</h1><%
		}
		
		if(id != null){
			%><h1>로그인 되어있네 ~</h1><%
		}
	%>
	hi!
	<a href="anonymous.jsp">익명 채팅방 바로가기</a>
	너의 아이디 : <%= id %>
</body>
</html>