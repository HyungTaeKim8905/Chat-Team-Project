<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./exclude/topnav.jsp" %>
<%
	if(sessionID != null)	{
		%><script> alert("잘못된 접근입니다."); history.back(); </script><%
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- 네비바 css -->
  <link rel="stylesheet" type="text/css" href="./css/nav.css" />
  <!-- 채팅방 리스트 css -->

  <link rel="stylesheet" type="text/css" href="./css/chatlist.css" />
  <!-- 회원가입 css -->
  <link rel="stylesheet" type="text/css" href="./css/register.css" />
  
  <!-- 우편번호 js -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
  <script src="./js/jquery-3.5.1.min.js"></script>
  <!-- 회원가입페이지 js -->
  <script src="./js/register.js"></script>
  <title>회원가입</title>

</head>
<body>    
  <div class="container">
  <!-- 왼쪽 공백 -->
  <div class="leftem" style="width:25%; height: 94%; float: left; background-color: white;">
  </div>
  <!-- 가입양식 -->
  <div class="centerre" style="width:50%; height: 100%; float: left; ">
    <form action="register" name="form" id="form" method="post">
      <div class="container">
        <h1>회원가입</h1>
        <hr>
		<!-- 아이디 -->
		<label for="id"><b>아이디 *</b></label><button type="button" onclick="idcheck()" class="registerbtn" style="width:200px; margin-left:8px;">아이디 중복확인</button>
        <input type="text" placeholder="아이디를 입력해주세요" name="id" id="id" required>
		
		<!-- 비밀번호 -->
        <label for="password"><b>비밀번호 *</b></label>
        <input type="password" placeholder="비밀번호를 입력해주세요" name="password" id="password" required>
		
		<!-- 비밀번호 확인 -->
        <label for="confirmPassword"><b>비밀번호 확인 *</b></label>
        <input type="password" placeholder="비밀번호를 한번 더 입력해주세요" name="confirmPassword" id="confirmPassword" required>
		
		<!-- 닉네임 -->
		<label for="nick"><b>닉네임 *</b></label>
        <input type="text" placeholder="닉네임을 입력해주세요" name="nick" id="nick" required>
		
		<!-- 이메일 -->
		<label for="email"><b>이메일 *</b></label>
        <input type="hidden" name="sender" id="sender" value="gudxo1226@naver.com">
        <input type="email" placeholder="이메일을 입력해주세요" name="email" id="email" required style="float:left;">
		<button type="button" class="registerbtn" onclick="EmailCheck()" style="width:200px;">이메일 인증</button><br/>
		<div id="div1">
		<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 이메일 확인 메세지 뿌려주는곳 @@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		</div>
		<label for="address"><b>주소</b></label><br/>
		<input type="text" id="sample6_postcode" placeholder="우편번호" style="width:200px;">
		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="registerbtn" style="width:200px;"><br/>
		<input type="text" id="sample6_address" placeholder="주소" style="width:200px;">
		<input type="text" id="sample6_detailAddress" placeholder="상세주소" style="width:200px;">
		<input type="text" id="sample6_extraAddress" placeholder="참고항목" style="width:200px;">
		<input type="hidden" id="address" name="address" value="">
		<br/>
		<label for="phone"><b>전화번호 *</b></label><br/>
		<select name="phone1" id="phone1">	<!--  input hidden  -->
			<option value="010" selected>010</option>
			<option value="011">011</option>
			<option value="012">012</option>
			<option value="013">013</option>
			<option value="014">014</option>
			<option value="015">015</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option> 
			<option value="019">019</option>
		</select> 
		<input type="text" style="width:100px; margin-right:5px;" name="phone2" id="phone2" size="5" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"><strong>-</strong><input type="text" style="width:100px; margin-left:5px;" name="phone3" id="phone3" size="5" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></h3>
		<input type="hidden" id="phone" name="phone" value="">
        <hr>

        <button type="submit" class="registerbtn">회원가입</button>
      </div>
      
      <div class="container signin">
        <p> 아이디가 이미 있으신가요? <a href="login.jsp">로그인</a></p>
      </div>
    </form>
</div>
</div>
</body>
</html>
