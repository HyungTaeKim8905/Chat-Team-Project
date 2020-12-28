<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//*************** 쿠키값 가져오기 **********************************************************************************
String sessionID = (String)session.getAttribute("id");
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
  <!-- 채팅방 css -->
  <link rel="stylesheet" type="text/css" href="./css/chatlist.css" />

  <!-- 회원가입 css -->
  <link rel="stylesheet" type="text/css" href="./css/register.css" />
  
  <title>로그인</title>

  <!-- 네비바 -->
  <div class="topnav" id="myTopnav">

    <abbr title="비회원 채팅">
      <a href="anonymous.jsp" >
    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h2.5a2 2 0 0 1 1.6.8L8 14.333 9.9 11.8a2 2 0 0 1 1.6-.8H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
        </svg>
    </a>
    </abbr>

    <abbr title="회원가입" >
      <a href="register.jsp" style="float: right;" >
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-person-plus" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M8 5a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6 5c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10zM13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
        </svg>
      </a>
      </abbr>
  
      <abbr title="로그인" >
      <a href="login.jsp" style="float: right;" class="active">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-lock" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M11.5 8h-7a1 1 0 0 0-1 1v5a1 1 0 0 0 1 1h7a1 1 0 0 0 1-1V9a1 1 0 0 0-1-1zm-7-1a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h7a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-7zm0-3a3.5 3.5 0 1 1 7 0v3h-1V4a2.5 2.5 0 0 0-5 0v3h-1V4z"/>
        </svg>
      </a>
    </abbr>
  </div>
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
      
      <div class="container signin">
        <p> <a href="#">아이디 찾기</a> / <a href="#">비밀번호 찾기</a></p>
      </div>
      <br/>
        <center>아이디가 없으신가요? <a href="register.jsp">회원가입</a></center>
    </form>
</div>

</div>
</body>
</html>