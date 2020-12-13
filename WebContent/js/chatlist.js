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
			//alert(json[0]["statusmessage"]);
			for(var i = 0; json.length; i++)	{
				SuccessFriend(json[i]["ID"], json[i]["pictureRealName"], json[i]["statusmessage"]);
			}
		}
	});
}
/*
function SuccessFriend(ID, pictureRealName, statusmessage) {
	var output = "";		//마이페이지 기능 구현 후 함.
	output += "<div>";
	output += 	"<div>";
	output += 		"<div>";
	output +=			"<a href='#' style='padding-top:0px; padding-bottom:0px;'>";
	output += 				"<img src='" + pictureRealName + "' style='width:55px; height:50px; float:left;'>";
	output +=			"</a>";
	output +=				"<div>";
	output +=					"<span>" + ID + "</span><a href='chatlist.jsp?toID=" + ID + "'><span>친구 추가</span></a>";
	output +=				"</div>";
	output +=			"<div>";
	output +=				"<p>" + statusmessage + "</p>";
	output +=			"</div>";
	output += 		"</div>";
	output += 	"</div>";
	output += "</div>";
	output += "<hr>";
	$("#div3").html(output);
}
*/

function SuccessFriend(ID, pictureRealName, statusmessage)	{
	var output = "";
	output += "<table>";
	output += 		"<tr>";
	output +=			"<td><a href='#' style='padding-top:0px; padding-bottom:0px;'><img src='" + pictureRealName + "' style='width:55px; height:50px; float:left;'></a></td>";
	output +=			"<td style='width:72%;'><h4>" + statusmessage + "</h4></td>";
	output +=			"<td><button type='button' onclick='AddFriend(" + ID + ")' style='width:55px;'>친구추가</button></td>";
	output += 		"</tr>";
	output += 		"<tr>";
	output +=			"<td>&nbsp&nbsp&nbsp" + ID + "</td>";
	output += 		"</tr>";
	output += "</table>";
	output == "<hr>";
	$("#div3").append(output);
}

function NoFriend()	{
	var output = "";
	output += "<h5>검색 결과를 얻어오지 못했습니다.</h5>";
	$("#div3").html(output);
}

function AddFriend(AddID)	{
	alert(AddID);
	//알럿이 안뜸 해결 바람
	var check = confirm(AddID + "님을 친구추가 하시겠습니까?");
	if(check == true)	{
		alert("확인 버튼 눌렀다.");
	}
	
	if(check == false)	{
		alert("취소 버튼 눌렀다.");
		return false;
	}
	$.ajax({ 
		url:"#",
		type:"POST",
		data:{AddID:AddID},
		success:function(result){
			var json = JSON.parse(result);
			if(json == null)	{
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
