<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*"%>
<%
	String sessionID = (String)session.getAttribute("id");
	if(sessionID == null)	{
		%><script> alert("권한이 없습니다."); location.href="Main.jsp"; </script><%	
	}
	DBManager dbm = new DBManager();
	String sql = "select nick, statusmessage, pictureOriginName, pictureRealName from user where id = '" + sessionID + "'";
	String nick = "";
	String img = "";
	String statusmessage = "";
	try	{
		dbm.DBOpen();
		dbm.OpenQuery(sql);
		while(dbm.ResultNext())	{
			nick = dbm.getString("nick");
			img = dbm.getString("pictureRealName");
			statusmessage = dbm.getString("statusmessage");
		}
		dbm.CloseQuery();
		dbm.DBClose();
	} catch(Exception e)	{
		System.out.println("ERRO : " + e.getMessage());
	}
	if(statusmessage == null)	{
		statusmessage = "";
	}
	if(img == "null" || img == "NULL" || img == null)	{
		//신규 회원가입이라면 기본 사진을 뽀려준다.
		img = "./image/man.jpg";
	}
%>
<!DOCTPYE html lang="ko">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- 네비바 css -->
		<link rel="stylesheet" type="text/css" href="./css/nav.css" />
		<!-- 마이페이지 css -->
		<link rel="stylesheet" type="text/css" href="./css/mypage.css" />
		<!-- 마이페이지 js -->
		<script src="./js/mypage.js"></script>
		<!-- jQuery -->
		<script src="./js/jquery-3.5.1.min.js"></script>
		<title>마이 페이지</title>
	</head>
	<body>
		<!-- 상단 네비바 -->
  <div class="topnav" id="myTopnav">
    <%if((String)session.getAttribute("id")!=null){ %>
    <abbr title="회원 채팅">
      <a href="chatlist.jsp">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-left-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v11.586l2-2A2 2 0 0 1 4.414 11H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
            <path fill-rule="evenodd" d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
          </svg>
    </a>
    </abbr>
<%} %>
    <abbr title="비회원 채팅">
      <a href="anonymous.jsp" >
    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h2.5a2 2 0 0 1 1.6.8L8 14.333 9.9 11.8a2 2 0 0 1 1.6-.8H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
        </svg>
    </a>
    </abbr>
  
  <!-- 로그인 상태면 띄우는 화면 -->
  <%if((String)session.getAttribute("id")!=null){ %>
      <abbr title="로그아웃">
      <a href="logout.jsp" style="float: right;">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-unlock" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M9.655 8H2.333c-.264 0-.398.068-.471.121a.73.73 0 0 0-.224.296 1.626 1.626 0 0 0-.138.59V14c0 .342.076.531.14.635.064.106.151.18.256.237a1.122 1.122 0 0 0 .436.127l.013.001h7.322c.264 0 .398-.068.471-.121a.73.73 0 0 0 .224-.296 1.627 1.627 0 0 0 .138-.59V9c0-.342-.076-.531-.14-.635a.658.658 0 0 0-.255-.237A1.122 1.122 0 0 0 9.655 8zm.012-1H2.333C.5 7 .5 9 .5 9v5c0 2 1.833 2 1.833 2h7.334c1.833 0 1.833-2 1.833-2V9c0-2-1.833-2-1.833-2zM8.5 4a3.5 3.5 0 1 1 7 0v3h-1V4a2.5 2.5 0 0 0-5 0v3h-1V4z"/>
        </svg>
      </a>
      </abbr>
      <abbr title="마이페이지">
        <a href="mypage.jsp" style="float: right;" class="active">
          <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-info-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
            <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
            <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
            <circle cx="8" cy="4.5" r="1"/>
          </svg>
        </a>
       </abbr>
  <%} %>
  </div>
		
		<!-- 마이페이지 -->
		<div class="container">
			<form id="form" name="form" action="Mypage" method="post" enctype="multipart/form-data">
			<div id="imgfile">
					<img src="<%= img %>">
				</div>
				<div class="filebox">
					<label for="file">사진 변경</label>
					<input type="file" id="file" name="file" accept=".gif, .jpg, .png" onchange="readInputFile(event.target)">
				</div>
				
			<label for="nick">닉네임</label>
			<input type="text" id="nick" name="nick" placeholder="홍길동" value="<%= nick %>">
			
			<label for="country">언어</label>
			<select id="country" name="country">
			  <option value="australia">Australia</option>
			  <option value="canada">Canada</option>
			  <option value="usa">USA</option>
			  <option value="Korea">Korea</option>
			</select>
	
			<label for="statusmessage">상태 메세지</label>
			<div id="StatusMessage_d">
			<input type="text" id="statusmessage" name="statusmessage" value="<%= statusmessage %>" placeholder="상태 메세지 입력..">
			</div>
			<input type="hidden" id="id" name="id" value="<%= sessionID %>">
			<button type="button" onclick="Modify()">저장</button><button type="button" class="PasswordChange" onclick="PasswordChange()"> 비밀번호 변경</button><button type="button" onclick="Withdrawal()">회원탈퇴</button>
		  </form>
		</div>
	</body>
</html>