<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <!-- 제이쿼리 -->
  <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
  
  <title>익명 채팅</title>

  <!-- 상단 네비바 -->
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
      <a href="anonymous.jsp" class="active">
    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h2.5a2 2 0 0 1 1.6.8L8 14.333 9.9 11.8a2 2 0 0 1 1.6-.8H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
        </svg>
    </a>
    </abbr>

    <abbr title="회원가입">
      <a href="register.jsp" style="float: right;">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-person-plus" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M8 5a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6 5c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10zM13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
        </svg>
      </a>
      </abbr>
  
      <abbr title="로그아웃">
      <a href="logout.jsp" style="float: right;">
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
  
  <div class="anchat" id="anchat" style="width: 105%;height: 70%; overflow-y : auto;">
  
  
  
  <script>
  var chatno = 1; 
  
  function chno(ch){
	  chatno = ch;
  }
	<!-- ajax 입력 -->
 function messageinput(){
   var xmlhttp = new XMLHttpRequest();
    
   var chatnum = "chatno="+chatno;
   <!-- encodeURIComponent : 한글 인코딩 -->
   var message = "message=" + encodeURIComponent(document.inme.inputmessage.value);
   var sessionid = "sessionid=<%=session.getId()%>";
   
   xmlhttp.open("POST", "inputjson.jsp", true);
   xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
   xmlhttp.send(chatnum+"&"+message+"&"+sessionid);
   document.getElementById("inputmessage").value = "";
   
   //입력하면 스크롤 내림
   scrolldown();
 }
  function update() {
  <!-- 스크롤 높이 구하기 -->

  //채팅창 div의 높이
  let elmnt = document.getElementById("anchat").scrollHeight;
  elmnt -= document.getElementById("anchat").offsetHeight;
  //현재 스크롤의 높이
  let scrollLocation = document.getElementById('anchat').scrollTop;
  
  var scr = false;
  if(scrollLocation >= elmnt){
	  scr = true;
  }
  
  <!-- json 출력 -->
  var xmlhttp = new XMLHttpRequest();
  
  xmlhttp.onreadystatechange = function() {
	  if (this.readyState == 4 && this.status == 200) {
	    var myObj = JSON.parse(this.responseText);
	    var mcount = Object.keys(myObj.comment).length;
	    
	    <!-- word-break : 글이 길어지면 자동 엔터 -->
	    var mchead = "<div class='chat me'><p style='margin:5px; word-break:break-all;'>";
	    var ochead = "<div class='chat other'><p style='margin:5px; word-break:break-all;'>";
	    
	    
    	document.getElementById("anchat").innerHTML = "";
	    
	    for(var i = 0; i<mcount; i++){
    	var mctail = "</p><span class='time-left'>"+ myObj.comment[i].time +"</span>";
	    var octail = "</p><span class='time-right'>"+ myObj.comment[i].time +"</span>"
	    
	    var chatid = "<b>" + myObj.comment[i].id.substring(0, 6) + "</b><br>";
	    var chat = myObj.comment[i].content;
	    
	    <!-- 내 채팅 -->
	    if("<%=session.getId()%>" == myObj.comment[i].id){
    	document.getElementById("anchat").innerHTML += mchead + chatid + chat + mctail ;
	    }
	    <!-- 다른사람 채팅 -->
	    if("<%=session.getId()%>" != myObj.comment[i].id){
	    document.getElementById("anchat").innerHTML += ochead + chatid + chat + octail ;
	    }
	    }
	  }
	};
  xmlhttp.open("POST", "json.jsp", true);
  xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xmlhttp.send("chatno="+chatno);
  
  if(scr == true){
  //5초뒤 스크롤 내림
  scrolldown();
  }
  
}
  <!-- 채팅 1초마다 새로고침 -->
window.onload = setInterval(update, 1000);

<!-- 엔터키 눌렀을 때 입력 -->
window.onload=function(){
document.getElementById('inputmessage').addEventListener('keydown',function(event){
    if(event.keyCode ==13){
    event.preventDefault();
        document.getElementById('messagebutton').click();
    }
});
}

//스크롤 위치 받아오기
/*
window.addEventListener('scroll', () => {
	let scrollLocation = document.getElementById('anchat').scrollTop; // 현재 스크롤바 위치
	let windowHeight = window.innerHeight; // 스크린 창
	let fullHeight = document.getElementById('anchat').scrollHeight; //  margin 값은 포함 x

	if(scrollLocation + windowHeight >= fullHeight){
		alert('끝')
	}
})
*/

//스크롤 제일 아래로
function scrolldown(){
	document.getElementById('anchat').scrollTop = document.getElementById('anchat').scrollHeight;
}

</script>
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