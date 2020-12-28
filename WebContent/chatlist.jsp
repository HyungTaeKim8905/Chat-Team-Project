<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.DBManager" %>
<%@ page import="file.*" %>
<%@ include file="./exclude/topnav.jsp" %>
<%@ include file="./exclude/chat.jsp" %>
<%
	if(sessionID == null)	{
		%><script>alert("로그인 후 이용해주세요."); location.href="login.jsp";</script><%
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  
  <!-- 채팅창 css -->
  <link rel="stylesheet" type="text/css" href="./css/chat.css" />
  
  <!-- 아이콘바 css -->
  <link rel="stylesheet" type="text/css" href="./css/iconbar.css" />
  
  <!-- 제이쿼리 -->
  <script src="./js/jquery-3.5.1.min.js"></script>
  
  <!-- 자바스크립트문 -->
  <script src="./js/chatlist.js" charset="utf-8"></script>  
  <%@ include file="./js/chat.jsp" %>
   <!--  <script src="./js/test.js"></script>   -->
  <title>채팅</title>
  
</head>
<body>
  
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