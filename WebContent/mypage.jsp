<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
		<script src="jquery-3.5.1.min.js"></script>
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
			<form id="ProfilePicture" name="ProfilePicture" action="#" method="post">
				<div id="imgfile">
					<img src="man-avatar-profile-on-round-icon_24640-14046.jpg">
				</div>
				<div class="filebox">
					<label for="file">사진 변경</label>
					<input type="file" id="file" name="file" onchange="readInputFile(event.target)">
				</div>
			</form>
			<form id="form" name="form" action="#" method="post">
			<label for="fname">이름</label>
			<input type="text" id="fname" name="firstname" placeholder="홍길동" readonly>
			
			<label for="country">언어</label>
			<select id="country" name="country">
			  <option value="australia">Australia</option>
			  <option value="canada">Canada</option>
			  <option value="usa">USA</option>
			  <option value="Korea">Korea</option>
			</select>
	
			<label for="lname">상태 메세지</label>
			<div id="StatusMessage_d">
			<input type="text" id="StatusMessage" name="StatusMessage" value="test" placeholder="상태 메세지 입력..">
			</div>
			<input type="submit" value="저장"><button type="button" class="PasswordChange" onclick="PasswordChange()"> 비밀번호 변경</button><button type="button" onclick="Withdrawal()">회원탈퇴</button>
		  </form>
		</div>
	</body>
</html>