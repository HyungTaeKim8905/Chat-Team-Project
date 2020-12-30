<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./exclude/topnav.jsp" %>
<%
//*************** 쿠키값 가져오기 **********************************************************************************
if(sessionID != null){
	%> <script>alert("잘못된 접근입니다."); location.href="Main.jsp"; </script> <%
}
String cookie = "";
String check = request.getHeader("cookie"); 
// out.println("getHeader : " + check);
Cookie[] cookies = null;
if(check != null){	
	cookies = request.getCookies();	// getCookies() 메서드를 사용해서 쿠키 정보를 배열에 저장한다.(HTTP 요청 메세지의 헤더에 포함된 쿠키를 javax.servlet.http.Cookie 배열로 리턴)		
}

if((cookies != null) && (cookies.length > 0))	{	// cookies == null 이면 쿠키가 존재하지 않는다.
	for(int i = 0; i < cookies.length; i++)		{
		if(cookies[i].getName().equals("id"))	{	// getName()메서드를 이용하여 쿠키 이름을 가져와 id와 비교 일치한다면
			cookie = cookies[i].getValue();			// getValue()메서드를 이용하여 쿠키 값을 cookie에 저장.
			//session.setAttribute("id", cookies[i].getValue());
		}
	}
}
/*
이와 같이 톰켓은 사용자가 로그인을 하지 않아도 최초 접속 시 JSESSIONID 쿠키 값을 브라우저에 내려주는 것을 알 수 있다.
그럼 왜 쿠키 값을 내려주는 걸까? HTTP 프로토콜은 stateless의 특징을 가지고 있기 때문에 사용자와 서버는 단 한번의 
요청과 응답으로 연결이 끊어진다. 그렇기 때문에 서버에서는 사용자의 로그인 인증 여부를 확인할 수 있도록 key 값 
처럼 사용할 수 있는 JSESSIONID 값을 클라이언트로 내려줌으로써 이를 이용하여 로그인 처리를 할 수 있는 것이다.
*/
//************************************************************************************************************
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- 네비바 css -->
  <link rel="stylesheet" type="text/css" href="./css/nav.css" />

  <!-- 회원가입 css -->
  <link rel="stylesheet" type="text/css" href="./css/register.css" />
  
  <title>로그인</title>

</head>
<body>
  <div class="container">
  <!-- 왼쪽 공백 -->
  <div class="leftem" style="width:25%; height: 94%; float: left; background-color: white;">
  </div>
  <!-- 로그인창 -->
  <div class="centerlo" style="width:50%; height: 100%; float: left; ">
    <form action="login" method="post">
      <div class="container">
        <h1>로그인</h1>
        <hr>
        <label for="id"><b>아이디</b></label>
        <input type="text" placeholder="이메일을 입력해주세요" value="<%= cookie %>" name="id" id="id" required>
    
        <label for="password"><b>비밀번호</b></label>
        <input type="password" placeholder="비밀번호를 입력해주세요" name="password" id="password" required>
        <hr>

        <input type="checkbox" name="rememberid">아이디 저장
        <input type="checkbox" name="rememberlogin">자동 로그인

        <button type="submit" class="registerbtn">로그인</button>
      </div>
      
      <div class="container signin" style="height:50px;">
        <p> <a href="#">아이디 찾기</a> / <a href="#">비밀번호 찾기</a></p>
      </div>
      <br/>
        <center>아이디가 없으신가요? <a href="register.jsp">회원가입</a></center>
    </form>
</div>

</div>
</body>
</html>