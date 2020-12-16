<% 
  String myID = null;
	if (session.getAttribute("id") != null) {
		myID = (String) session.getAttribute("id");
	}
%>
<script>
  function test()	{
  			alert(<%= myID %>);
			var fromID = '<%= myID %>';
			var toID = "123";
			var inputmessage = $("#inputmessage").val();
		//	alert(inputmessage);
			$.ajax({
				url:"ChatSubmit",
				type:"POST",
				data:{
					fromID:fromID,
					toID:toID,
					content:inputmessage
				},
				success:function(result){
					var json = JSON.parse(result);
					if(json[0]["result"] == 1){
					//	alert(" test() => 메세지를 보냈다.");
					} else if(json[0]["result"] == 0){
						alert(" test() => 오류");
					} else{
						alert(" test() => 오류!!");
					}
				}
			});
			$("#inputmessage").val("");
		}
	  
	  	//var lastNo = "";
	  	var lastNo1 = ""; //*******************
		function ChattingList(num){
			var fromID = '<%= myID %>';
			var toID = "123";
			//alert("listNo1 ::::" + lastNo1);
			$.ajax({
				type : "POST",
				url : "ChatList",
				data : {
					fromID:fromID,
					toID:toID,
					lastNo: num, /*처음에는 no가 0 이상인것부터 쭉, 그다음부터는 lastNo 이후로 쭉(lastNo는 계속 업데이트됨)*/
				},
				success : function(result){
					if(result === undefined) {
						alert("ChattingList() => ajax통신 후 result 결과 값 알수 없는 오류 입니다.");
						return false;
					}
					//else	{
						//alert("리스트를 가져왔습니다.");	
					//}
					var json = JSON.parse(result);
					if(json.length == 0)	{
						return false;
					}
					//alert("json.length :: " + json.length);
					//no만 따로 받아 배열로 저장 후 정렬
					var list = [];
					for(var j = 0; j < json.length; j++){
						list[j] = json[j]["no"];
						//alert(list[j]);
					}
					
					for(var i = 0; i < json.length; i++){
						if(json[i]["fromID"].value == fromID){
							json[i]["fromID"].value = "";
						}
						ListCount(json[i]["fromID"], json[i]["content"], json[i]["date"]);
					} //*******************
					lastNo1 = list[list.length - 1];
				}
			});
		}
		
	  	//채팅내역을 출력해주는 함수.
		function ListCount(name, content, date)	{
			var output = "";
			output += "<div>";
			output += 	"<div>";
			output += 		"<div>";
			output +=			"<a href='#'>";
			output += 				"<img src='./image/man.jpg' style='width:30px;height:30px'>";
			output +=			"</a>";
			output +=			"<div>";
			output +=				"<h4>" + name + "<span>" + date + "</span></h4>";
			output +=				"<p>" + content + "</p>";
			output +=			"</div>";
			output += 		"</div>";
			output += 	"</div>";
			output += "</div>";
			output += "<hr>";
			$("#div1").append(output);
			$("#div1").scrollTop($("#div1")[0].scrollHeight);
			
		}
		
		
		function Reload(){
			setInterval(function (){
				ChattingList(lastNo1);
			}, 1000);
		}

		<!-- 엔터키 입력 -->
		window.onload=function(){
		document.getElementById('inputmessage').addEventListener('keydown',function(event){
		    if(event.keyCode ==13){
		    event.preventDefault();
		        document.getElementById('messagebutton').click();
		    }
		});
		}
		
		$(document).ready(function(){
			ChattingList("0"); 
			Reload();
		});
</script>