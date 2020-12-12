<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String sessionID = (String)session.getAttribute("id");
	if(sessionID == null)	{
		%><script> alert("권한이 없습니다."); location.href="Main.jsp"; </script><%	
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
		<!-- 네비바 -->
		<div class="topnav" id="myTopnav">
			<a href="chatlist.jsp">채팅방</a>
			<a href="#contact" class="active">마이페이지</a>
		</div>
		
		<!-- 마이페이지 -->
		<div class="container">
			<form id="form" name="form" action="Mypage" method="post" enctype="multipart/form-data">
			<div id="imgfile">
					<img src="./image/man.jpg">
				</div>
				<div class="filebox">
					<label for="file">사진 변경</label>
					<input type="file" id="file" name="file" accept=".gif, .jpg, .png" onchange="readInputFile(event.target)">
				</div>
				
			<label for="nick">닉네임</label>
			<input type="text" id="nick" name="nick" placeholder="홍길동" readonly>
			
			<label for="country">언어</label>
			<select id="country" name="country">
			  <option value="australia">Australia</option>
			  <option value="canada">Canada</option>
			  <option value="usa">USA</option>
			  <option value="Korea">Korea</option>
			</select>
	
			<label for="statusmessage">상태 메세지</label>
			<div id="StatusMessage_d">
			<input type="text" id="statusmessage" name="statusmessage" value="test" placeholder="상태 메세지 입력..">
			</div>
			<button type="button" onclick="Modify()">저장</button><button type="button" class="PasswordChange" onclick="PasswordChange()"> 비밀번호 변경</button><button type="button" onclick="Withdrawal()">회원탈퇴</button>
		  </form>
		</div>
	</body>
</html>