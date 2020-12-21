<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.DBManager" %>
<%@ page import="file.*" %>
<%
	String myID = null;
	if (session.getAttribute("id") != null) {
		myID = (String) session.getAttribute("id");
	}
	String toID = null;
	if(request.getParameter("toID") != null){
		toID = (String)request.getParameter("toID");
	}
	else if(session.getAttribute("id") == null)	{
		%><script>alert("로그인 후 이용해주세요."); location.href="login.jsp";</script><%
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- 상단 네비바 css -->
  <link rel="stylesheet" type="text/css" href="./css/nav.css" />

  <!-- 채팅방 리스트 css -->
  <link rel="stylesheet" type="text/css" href="./css/chatlist.css" />
  
  <!-- 채팅창 css -->
  <link rel="stylesheet" type="text/css" href="./css/chat.css" />
  
  <!-- 아이콘바 css -->
  <link rel="stylesheet" type="text/css" href="./css/iconbar.css" />
  
  <!-- 제이쿼리 -->
  <script src="./js/jquery-3.5.1.min.js"></script>
  
  <!-- 자바스크립트문 -->
  <script src="./js/chatlist.js"></script>  
  <%@ include file="./js/chat.jsp" %>
   <!--  <script src="./js/test.js"></script>   -->
  <title>채팅</title>
  
</head>
<body>
  <!-- 상단 네비바 -->
  <div class="topnav" id="myTopnav">
    <abbr title="회원 채팅">
      <a href="chatlist.jsp" class="active" >
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-left-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v11.586l2-2A2 2 0 0 1 4.414 11H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
          <path fill-rule="evenodd" d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
        </svg>
    </a>
    </abbr>

    <abbr title="비회원 채팅">
      <a href="anonymous.jsp">
      <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h2.5a2 2 0 0 1 1.6.8L8 14.333 9.9 11.8a2 2 0 0 1 1.6-.8H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
      </svg>
    </a>
    </abbr>

<%
	if(myID != null)	{
%> 
   

    <abbr title="로그아웃">
    <a href="logout.jsp" style="float: right;">
      <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-unlock" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M9.655 8H2.333c-.264 0-.398.068-.471.121a.73.73 0 0 0-.224.296 1.626 1.626 0 0 0-.138.59V14c0 .342.076.531.14.635.064.106.151.18.256.237a1.122 1.122 0 0 0 .436.127l.013.001h7.322c.264 0 .398-.068.471-.121a.73.73 0 0 0 .224-.296 1.627 1.627 0 0 0 .138-.59V9c0-.342-.076-.531-.14-.635a.658.658 0 0 0-.255-.237A1.122 1.122 0 0 0 9.655 8zm.012-1H2.333C.5 7 .5 9 .5 9v5c0 2 1.833 2 1.833 2h7.334c1.833 0 1.833-2 1.833-2V9c0-2-1.833-2-1.833-2zM8.5 4a3.5 3.5 0 1 1 7 0v3h-1V4a2.5 2.5 0 0 0-5 0v3h-1V4z"/>
      </svg>
    </a>
  </abbr>
<%
	}
	if(myID == null)	{
%>
 <abbr title="회원가입">
    <a href="register.jsp" style="float: right;">
      <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-person-plus" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M8 5a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6 5c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10zM13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
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
<%
	}
	if(myID != null)	{
%>
    <abbr title="마이페이지">
      <a href="mypageAction" style="float: right;">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-info-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
          <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
          <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
          <circle cx="8" cy="4.5" r="1"/>
        </svg>
      </a>
      </abbr>
<%
	}
%>
  </div>
  <div class="container">
  <!-- 채팅방 목록 -->
  <div class="left" style="width:25%; float: left; ">
  <div class="chatlist" id="chatlist">
  
  </div>
  </div>
  <!-- 채팅창 -->
  <div class="center" id="center" style="width:66%; height: 95%; float: left;">
  <div class="chat" id="chat" style="width: 100%;height: 80%; overflow-y : auto;">
  
 <!-- ***************************************************************** -->   
 <!-- ***************************************************************** -->
 <!-- ***************************************************************** -->
 <!-- ***************************************************************** -->
  </div>
  
  
  <!-- 채팅입력창 -->
  <div class="inputchat" style="width: 100%; height: 30%;">
    <hr>
    <form name="inme">
      <table width="100%">
        <tr>
          <td width="86%" ><textarea name="inputmessage" id="inputmessage" class="inputmessage"></textarea></td>
          <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td ><button type="button" class="messagebutton" id= "messagebutton" onclick="messageinput()">
            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-reply-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
              <path d="M9.079 11.9l4.568-3.281a.719.719 0 0 0 0-1.238L9.079 4.1A.716.716 0 0 0 8 4.719V6c-1.5 0-6 0-7 8 2.5-4.5 7-4 7-4v1.281c0 .56.606.898 1.079.62z"/>
            </svg>
          </button></td>
        </tr>
      </table>
    </form>
  </div>
</div>
<!-- 오른쪽 UI -->
<div class="icon-bar">
  <!-- 친구목록 -->
  <div style="position: relative;">
    <abbr title="친구 목록">
    <a href="javascript:friendfn();" id="friendbt">
      <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person-lines-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7 1.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm-2-3a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm2 9a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
      </svg>
    </a>
    </abbr>
    <div id="friendfm" class="friendfm" style="width:100%; height:100%;">
		<div>  
			<center> 
    			<h2>친구 목록</h2>   
    			<input type="text" id="friend" name="friend">
    			<button type="button" onclick="SerachFriend()">검색</button>
    		</center>
    	</div>
    	<hr>
    	<div id="div2">
    		
    	</div>
    </div>
    </div>
  <!-- 검색 아이콘 -->
  <div style="position: relative;">
    <abbr title="검색">
    <a href="javascript:searchfn();" id="searchbt" class="searchbt">
      <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-search" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
      <path fill-rule="evenodd" d="M10.442 10.442a1 1 0 0 1 1.415 0l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1 0-1.415z"/>
      <path fill-rule="evenodd" d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
      </svg>
    </a> 
    </abbr>
    <div id="searchfm" class="searchfm" style="width:100%; height:100%;">
		<div>  
			<center> 
    			<h2>친구 찾기</h2>   
    			<input type="text" id="friendid" name="friendid">
    			<button type="button" onclick="FindTest()">검색</button>
    		</center>
    	</div>
    	<hr>
    	<div id="div3">
    		
    	</div>
    </div>
  </div>

  <!-- 파일 업로드 -->
  <div class="fileupload">
    <form enctype="multipart/form-data" method="post" id="fileuploadform" name="fileuploadform">
    <a href="javascript:filecheck(this);">
     <label for="fileuld">
  	  <input type="file" id="fileuld" name="fileuld" maxlength="5" onchange="filecheck(this)" multiple style='display: none;'>
       <abbr title="파일 업로드">
        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-box-arrow-up" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
         <path fill-rule="evenodd" d="M3.5 6a.5.5 0 0 0-.5.5v8a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-8a.5.5 0 0 0-.5-.5h-2a.5.5 0 0 1 0-1h2A1.5 1.5 0 0 1 14 6.5v8a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-8A1.5 1.5 0 0 1 3.5 5h2a.5.5 0 0 1 0 1h-2z"/>
         <path fill-rule="evenodd" d="M7.646.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 1.707V10.5a.5.5 0 0 1-1 0V1.707L5.354 3.854a.5.5 0 1 1-.708-.708l3-3z"/>
        </svg>
       </abbr>
       </label>
    </a> 
    </form>
  </div>
</div>
</div>
</body>
</html>