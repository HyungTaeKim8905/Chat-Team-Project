<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./exclude/topnav.jsp" %>
<%@ page import="DB.*"%>
<%@ page import="VO.*"%>
<%
	if(sessionID == null)	{
		%><script> alert("권한이 없습니다."); location.href="Main.jsp"; </script><%	
	}
	UserVO vo = (UserVO)request.getAttribute("vo");
	if(vo == null){
		System.out.println("mypage.jsp => vo가 null입니다.");
		return;
	}
%>
<!DOCTYPE html>
<html lang="ko">
<html>
	<head>
		<!-- 마이페이지 css -->
		<link rel="stylesheet" type="text/css" href="./css/mypage.css" />
		<!-- jQuery -->
		<script src="./js/jquery-3.5.1.min.js"></script>
		<!-- 마이페이지 js -->
		<script src="./js/mypage.js"></script>
		<title>마이 페이지</title>
	</head>
	<body>
		
		<!-- 마이페이지 -->
		<div class="container">
			<form id="form" name="form" action="Mypage" method="post" enctype="multipart/form-data">
			<div id="imgfile">
					<img src="<%= vo.getPictureRealName() %>">
				</div>
				<div class="filebox">
					<label for="file">사진 변경</label>
					<input type="file" id="file" name="file" accept=".gif, .jpg, .png" onchange="readInputFile(event.target)">
				</div>
				
			<label for="nick">닉네임</label>
			<input type="text" id="nick" name="nick" placeholder="홍길동" value="<%= vo.getNick() %>">
	
			<label for="statusmessage">상태 메세지</label>
			<div id="StatusMessage_d">
			<input type="text" id="statusmessage" name="statusmessage" value="<%= vo.getStatusmessage() %>" placeholder="상태 메세지 입력..">
			</div>
			<input type="hidden" id="id" name="id" value="<%= sessionID %>">
			<button type="button" onclick="Modify()">저장</button><button type="button" class="PasswordChange" onclick="PasswordChange()"> 비밀번호 변경</button><button type="button" onclick="Withdrawal()">회원탈퇴</button>
		  </form>
		</div>
	</body>
</html>