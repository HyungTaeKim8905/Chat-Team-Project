<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./exclude/topnav.jsp" %>
<%@ include file="./exclude/chat.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- 채팅창 css -->
  <link rel="stylesheet" type="text/css" href="./css/chat.css" />
  <!-- 제이쿼리 -->
  <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
  <!-- 자바스크립트 -->
  <script src="./js/anonymous.jsp"></script>
  
  <title>익명 채팅</title>

</head>
<body>
  <div class="container">
  
  
  <!-- 채팅방 목록 -->
  <div class="left" style="width:25%; float: left; ">
  <div class="chatlist">
    <div class="chatlist other" onclick="chno(1)">
      <p>1번 채팅방</p>
      <span class="time-right">11:00</span>
    </div>
    <div class="chatlist other" onclick="chno(2)">
      <p>2번 채팅방</p>
      <span class="time-right">11:00</span>
    </div>
    <div class="chatlist other" onclick="chno(3)">
      <p>3번 채팅방</p>
      <span class="time-right">11:00</span>
    </div>
    <div class="chatlist other" onclick="chno(4)">
      <p>4번 채팅방</p>
      <span class="time-right">11:00</span>
    </div>
    <div class="chatlist other" onclick="chno(5)">
      <p>5번 채팅방</p>
      <span class="time-right">11:00</span>
    </div>
  </div>
  </div>
  <!-- 채팅창 -->
  <div class="center" id="center" style="width:66%; height: 100%; float: left; ">
  
  <div class="anchat" id="anchat" style="width: 105%;height: 80%; overflow-y : auto;">
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
</div>
</body>
</html>