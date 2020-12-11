<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
	<%
		String n = request.getParameter("n");
		String cookie = "";
		String check = request.getHeader("cookie");
		Cookie[] cookies = null;
		if(check != null){	
			cookies = request.getCookies();	// getCookies() 메서드를 사용해서 쿠키 정보를 배열에 저장한다.(HTTP 요청 메세지의 헤더에 포함된 쿠키를 javax.servlet.http.Cookie 배열로 리턴)		
		}
		for(int i = 0; i < cookies.length; i++)	{
			out.println(":::::::::::1  "+cookies[i].getName());
		}
		
		if(n != "1")	{
			if((cookies != null) && (cookies.length > 0))	{	// cookies == null 이면 쿠키가 존재하지 않는다.
				for(int i = 0; i < cookies.length; i++)		{
					if(cookies[i].getName().equals("autologincheckbox"))	{
						session.setAttribute("id", cookies[i].getValue());
						%> <br><br><br><br><br><br><br><br><%
						out.println("::::::::::::2"+cookies[i].getValue());
					}
				}
			}
		}
		
		String id = (String)session.getAttribute("id");
		if(id == null){
			%><h1>로그인 안되어있네 @@@@@@@@@@@@~</h1><%
		}
		
		if(id != null){
			%><h1>로그인 되어있네 ~</h1><br/><br/><br/> <a href="logout.jsp">로그아웃</a><%
		}
%>
			hi!<br>
			<a href="anonymous.jsp">익명 채팅방 바로가기</a><br>
			너의 아이디 : <%= id %>
<!-- <script>alert(document.cookie)</script>  -->