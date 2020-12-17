
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
   var sessionid = "sessionid=<%=session.getId()%>";
   
   xmlhttp.open("POST", "inputjson.jsp", true);
   xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
   xmlhttp.send(chatnum+"&"+message+"&"+sessionid);
   document.getElementById("inputmessage").value = "";
   
   //입력하면 스크롤 내림
   scrolldown();
 }
 
 <!-- 익명채팅 출력 -->
  function update() {
  
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
		   	var mctail = "</p><span class=\'time-left\'>"+ myObj.comment[i].time +"</span>";
		    var octail = "</p><span class=\'time-right\'>"+ myObj.comment[i].time +"</span>"
		    
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
	document.getElementById('anchat').scrollTop = document.getElementById('anchat').scrollHeight;
}
