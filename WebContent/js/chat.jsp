
<!-- 페이지 접속 시간 -->
  var connectedDate = new Date();
  connectedDate = connectedDate.getFullYear() + '-' +
  ('00' + (connectedDate.getMonth()+1)).slice(-2) + '-' +
  ('00' + connectedDate.getDate()).slice(-2) + ' ' + 
  ('00' + connectedDate.getHours()).slice(-2) + ':' + 
  ('00' + connectedDate.getMinutes()).slice(-2) + ':' + 
  ('00' + connectedDate.getSeconds()).slice(-2);
  
  <!-- 채팅방 번호 -->
  var chatno = 1; 
  
  function chno(ch){
	  chatno = ch;
  }
	<!-- ajax 입력 -->
 function messageinput(){
	<!-- 공백 제거 -->
   if(!document.getElementById("inputmessage").value.replace(/(^\s*)|(\s*$)/gi, "")){
	   return;
   }
	 
   var xmlhttp = new XMLHttpRequest();
    
   var chatnum = "chatno="+chatno;
   <!-- encodeURIComponent : 한글 인코딩 -->
   var message = "message=" + encodeURIComponent(document.inme.inputmessage.value);
   var sessionid = "sessionid=<%=session.getAttribute("id")%>";
   
   xmlhttp.open("POST", "chatinputjson.jsp", true);
   xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
   xmlhttp.send(chatnum+"&"+message+"&"+sessionid);
   document.getElementById("inputmessage").value = "";
   
   //입력하면 스크롤 내림
   scrolldown();
 }
 
 <!-- json 출력 -->
  function update() {
  var xmlhttp = new XMLHttpRequest();
  
  xmlhttp.onreadystatechange = function() {
	  if (this.readyState == 4 && this.status == 200) {
	    var myObj = JSON.parse(this.responseText);
	    var mcount = Object.keys(myObj.comment).length;
	    
	    <!-- word-break : 글이 길어지면 자동 엔터 -->
	    var mchead = "<div class='chat me'><p style='margin:5px; word-break:break-all;'>";
	    var ochead = "<div class='chat other'><p style='margin:5px; word-break:break-all;'>";
	    
	    
    	document.getElementById("chat").innerHTML = "";
	    
    	
	    for(var i = 0; i<mcount; i++){
		   	var mctail = "</p><span class=\'time-left\'>"+ myObj.comment[i].time +"</span>";
		    var octail = "</p><span class=\'time-right\'>"+ myObj.comment[i].time +"</span>"
		    
		    var chatid = "<b>" + myObj.comment[i].id.substring(0, 6) + "</b><br>";
		    var chat = myObj.comment[i].content;
		    
		    <!-- 내 채팅 -->
		    if("<%=session.getAttribute("id")%>" == myObj.comment[i].id){
		   	document.getElementById("chat").innerHTML += mchead + chatid + chat + mctail ;
		    }
		    <!-- 다른사람 채팅 -->
		    if("<%=session.getAttribute("id")%>" != myObj.comment[i].id){
		    document.getElementById("chat").innerHTML += ochead + chatid + chat + octail ;
		    }
	    }
	  }
	};
  xmlhttp.open("POST", "chatjson.jsp", true);
  xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xmlhttp.send("chatno="+chatno+"&connectiontime="+connectedDate);
}
  <!-- 채팅 1초마다 새로고침 -->
window.onload = setInterval(update, 2000);

<!-- 엔터키 눌렀을 때 입력 -->
window.onload=function(){
document.getElementById('inputmessage').addEventListener('keydown',function(event){
    if(event.keyCode ==13){
    event.preventDefault();
        document.getElementById('messagebutton').click();
    }
});
}

//스크롤 제일 아래로
function scrolldown(){
	document.getElementById('chat').scrollTop = document.getElementById('chat').scrollHeight;
}


<!-- 채팅방 목록 불러오기 -->
<!-- json 출력 -->
  function chatlistupdate() {
  var xmlhttp = new XMLHttpRequest();
  
  xmlhttp.onreadystatechange = function() {
	  if (this.readyState == 4 && this.status == 200) {
	    var myObj = JSON.parse(this.responseText);
	    var mcount = Object.keys(myObj.chatlist).length;
	    
    	document.getElementById("chatlist").innerHTML = "";
	    var header = "<div class='chatlist other' onclick='chno(";
	    var mid = ")'><p>";
	    var tail = "</p></div>";
	    
	    for(var i = 0; i<mcount; i++){
	    
	    document.getElementById("chatlist").innerHTML += header + myObj.chatlist[i].chatno;
	    document.getElementById("chatlist").innerHTML += mid + myObj.chatlist[i].otherid;
	    document.getElementById("chatlist").innerHTML += tail;
	    }
    	
	  }
	};
  xmlhttp.open("POST", "chatlistgetjson.jsp", true);
  xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xmlhttp.send(id=<%=session.getAttribute("id")%>");
}
window.onload = setInterval(chatlistupdate, 2000);