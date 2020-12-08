<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

  <!-- 네비바 -->
  <div class="topnav" id="myTopnav">
    
    <abbr title="회원 채팅">
      <a href="chatlist.jsp">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-left-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v11.586l2-2A2 2 0 0 1 4.414 11H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
            <path fill-rule="evenodd" d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
          </svg>
    </a>
    </abbr>

    <abbr title="비회원 채팅">
      <a href="anonymous.jsp" >
    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h2.5a2 2 0 0 1 1.6.8L8 14.333 9.9 11.8a2 2 0 0 1 1.6-.8H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
        </svg>
    </a>
    </abbr>

    <abbr title="회원가입" >
      <a href="register.jsp" style="float: right;" class="active">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-person-plus" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M8 5a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6 5c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10zM13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
        </svg>
      </a>
      </abbr>
  
      <abbr title="로그아웃">
      <a href="#" style="float: right;">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-unlock" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M9.655 8H2.333c-.264 0-.398.068-.471.121a.73.73 0 0 0-.224.296 1.626 1.626 0 0 0-.138.59V14c0 .342.076.531.14.635.064.106.151.18.256.237a1.122 1.122 0 0 0 .436.127l.013.001h7.322c.264 0 .398-.068.471-.121a.73.73 0 0 0 .224-.296 1.627 1.627 0 0 0 .138-.59V9c0-.342-.076-.531-.14-.635a.658.658 0 0 0-.255-.237A1.122 1.122 0 0 0 9.655 8zm.012-1H2.333C.5 7 .5 9 .5 9v5c0 2 1.833 2 1.833 2h7.334c1.833 0 1.833-2 1.833-2V9c0-2-1.833-2-1.833-2zM8.5 4a3.5 3.5 0 1 1 7 0v3h-1V4a2.5 2.5 0 0 0-5 0v3h-1V4z"/>
        </svg>
      </a>
    </abbr>
  
      <abbr title="로그인">
      <a href="login.jsp" style="float: right;">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-lock" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M11.5 8h-7a1 1 0 0 0-1 1v5a1 1 0 0 0 1 1h7a1 1 0 0 0 1-1V9a1 1 0 0 0-1-1zm-7-1a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h7a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-7zm0-3a3.5 3.5 0 1 1 7 0v3h-1V4a2.5 2.5 0 0 0-5 0v3h-1V4z"/>
        </svg>
      </a>
    </abbr>
  
      <abbr title="마이페이지">
        <a href="mypage.jsp" style="float: right;">
          <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-info-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
            <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
            <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
            <circle cx="8" cy="4.5" r="1"/>
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

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!! -->