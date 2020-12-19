<script>
<!-- 페이지 접속 시간 -->
  var connectedDate = new Date();
  connectedDate = connectedDate.getFullYear() + '-' +
  ('00' + (connectedDate.getMonth()+1)).slice(-2) + '-' +
  ('00' + connectedDate.getDate()).slice(-2) + ' ' + 
  ('00' + connectedDate.getHours()).slice(-2) + ':' + 
  ('00' + connectedDate.getMinutes()).slice(-2) + ':' + 
  ('00' + connectedDate.getSeconds()).slice(-2);
  
  <!-- 채팅방 번호 -->
  var chatno = ""; 
  
  function chno(ch){
	  chatno = ch;
  }
	<!-- ajax 입력 -->
 function messageinput(){
	<!-- 공백 제거 -->
   if(!document.getElementById("inputmessage").value.replace(/(^\s*)|(\s*$)/gi, "")){
	   return;		//공백이 들어왔다면 리턴
   }
	 
   var xmlhttp = new XMLHttpRequest();
    
   var chatnum = "chatno="+chatno;		//채팅방의 번호
   <!-- encodeURIComponent : 한글 인코딩 -->
   var message = "message=" + encodeURIComponent(document.inme.inputmessage.value);	//사용자가 쓴 채팅 내용
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
		    var octail = "</p><span class=\'time-right\'>"+ myObj.comment[i].time +"</span>";
		    
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
  xmlhttp.send("chatno="+chatno);
}
  <!-- 채팅 1초마다 새로고침 -->
window.onload = setInterval(interval, 2000);

function interval(){
	update();
	chatlistupdate();
}

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
  function chatlistupdate() {
  var xmlhttp = new XMLHttpRequest();
  
  xmlhttp.onreadystatechange = function() {
	  if (this.readyState == 4 && this.status == 200) {
	    var myObj = JSON.parse(this.responseText);			//넘어온 제이슨 데이터 파싱
	    var mcount = Object.keys(myObj.chatlist).length;	//객체의  길이
	    
    	document.getElementById("chatlist").innerHTML = ""; 
	    
	    for(var i = 0; i<mcount; i++){	//객체의 길이만큼 반복
    	
    	document.getElementById("chatlist").innerHTML += "<div class='chatlist other' onclick=chno("+ 
    			myObj.chatlist[i].chatno +")><p>"+ myObj.chatlist[i].otherid + "</p>";
	    }
	  }
	};
  xmlhttp.open("POST", "chatlistgetjson.jsp", true);
  xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xmlhttp.send("id=<%=session.getAttribute("id")%>");
}
  <!-- 채팅방 생성 -->
	 function invite(id){
		 
	   var xmlhttp = new XMLHttpRequest();
	    
	   var otherid = "otherid="+id;
	   
	   xmlhttp.open("POST", "chatlistinputjson.jsp", true);
	   xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
	   xmlhttp.send(otherid+"&"+"myid=<%=session.getAttribute("id")%>");
	   document.getElementById("inputmessage").value = "";
	   
	   //입력하면 스크롤 내림
	   scrolldown();
	 }
  


	 function filecheck(frm){
	        var maxfilesize = 5*1024*1024; //5MB 제한
	        var filename = []; 
	        var con = "다음 파일을 업로드합니다.\n";
	        
	        for(var i=0; i<frm.files.length; i++){
	            //파일 개수 제한
	            if(i>4){
	                alert("파일은 5개까지만 업로드 가능합니다");
	                //frm.outerHTML = frm.outerHTML;
	                return false;
	            }
	            //파일 각각의 용량 제한
	            var nowfilesize = frm.files[i].size;
	            if(nowfilesize>maxfilesize){
	                alert("파일의 용량은 5mb를 넘을 수 없습니다");
	                //frm.outerHTML = frm.outerHTML;
	                return false;
	            }
	            //확인창에 파일 이름 추가 
	            con += "\n" + frm.files[i].name;
	            //console.debug(frm.files[i]);                        
	        }
	        //파일 업로드 취소시 알림창 안뜨게
	        if(frm.files.length>0){
	        	//확인
		        if (confirm(con) == true){  
		        	
		        }else{   //취소
		            return;
		        }
		    }
	    //ajax로 파일 전송시 FormData객체 생성 후 form을 넣어줘야한다.
	    var filedata = document.getElementById("fileuploadform");    
	    var formData = new FormData(filedata);
	    //console.debug(filedata);
		$.ajax({
			url:"fileuploadtest?chatno="+chatno,
			type:"POST",
			enctype: "multipart/form-data",
			contentType : false,
			processData : false,
			data:formData,
			success:function(result)	{
				var json = JSON.parse(result);
				if(json.length == 0)	{
					alert("받아온 제이슨 데이터가 0입니다.");
				}
			}
		});
	}

</script>