/* 유저가 버튼을 클릭했을 때
드롭다운의 컨텐츠가 숨김, 보임 상태를 번갈아 보인다 */
function searchfn() {
  document.getElementById("searchfm").classList.toggle("show");
  document.getElementById("friendfm").classList.remove("show");
}
function friendfn() {
  document.getElementById("friendfm").classList.toggle("show");
  document.getElementById("searchfm").classList.remove("show");
}

function FindTest()	{
	var ID = $("#friendid").val();
	alert(ID);
	$.ajax({ 
		url:"FindFriend",
		type:"POST",
		data:{ID:ID},
		success:function(result){
			var json = JSON.parse(result);
			if(json.length == 0)	{
				alert("친구목록을 가져오지 못했다.");
				NoFriend();
			}
			alert(json[0]["statusmessage"]);
			for(var i = 0; json.length; i++)	{
				SuccessFriend(json[i]["ID"], json[i]["pictureRealName"], json[i]["statusmessage"]);
			}
		}
	});
}

function SuccessFriend(ID, pictureRealName, statusmessage) {
	var output = "";		//마이페이지 기능 구현 후 함.
	output += "<div>";
	output += 	"<div>";
	output += 		"<div>";
	output +=			"<a href='#' style='padding-top:0px; padding-bottom:0px;'>";
	output += 				"<img src='" + pictureRealName + "' style='width:55px; height:50px; float:left;'>";
	output +=			"</a>";
	output +=				"<span>" + ID + "</span>";
	output +=			"<div>";
	output +=				"<p>" + statusmessage + "</p>";
	output +=			"</div>";
	output += 		"</div>";
	output += 	"</div>";
	output += "</div>";
	output += "<hr>";
	$("#div2").html(output);
} 

function NoFriend()	{
	var output = "";
	output += "<h5>검색 결과를 얻어오지 못했습니다.</h5>";
	$("#div2").html(output);
}
