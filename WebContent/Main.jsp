<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String id = (String)session.getAttribute("id");
	if(id == null){
		%><h1>로그인을 하셔야합니다.</h1><%
	}
	
	if(id != null){
		%><h1>로그인상태입니다. </h1><br/><br/><br/> <a href="logout.jsp">로그아웃</a><%
	}
%>
<br>
<a href="anonymous.jsp">익명 채팅방 바로가기</a><br>
너의 아이디 : <%= id %>