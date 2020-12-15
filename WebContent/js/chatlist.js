/* 유저가 버튼을 클릭했을 때
드롭다운의 컨텐츠가 숨김, 보임 상태를 번갈아 보인다 */
function searchfn() {
  document.getElementById("searchfm").classList.toggle("show");
  document.getElementById("friendfm").classList.remove("show");
}


function friendfn() {
  document.getElementById("friendfm").classList.toggle("show");
  document.getElementById("searchfm").classList.remove("show");
   //친구 목록 버튼을 눌렀을때 실행되는 ajax
  $("#div2").html("");
  $.ajax({
		url:"PrintFriend",
		type:"POST",
		success:function(result){
			var json = JSON.parse(result);
			if(json.length == 0)	{
				alert("친구 리스트가 없습니다.");
			}
			for(var i = 0; i <json.length; i++)	{
				FriendList(json[i]["ID"], json[i]["pictureRealName"], json[i]["statusmessage"]);
			}
		}
	});
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
				alert("친구목록을 가져오지 못했습니다.");
			}
			$("#div3").html("");
			for(var i = 0; json.length; i++)	{
				SuccessFriend(json[i]["ID"], json[i]["pictureRealName"], json[i]["statusmessage"],i);
			}
		}
	});
}

function SuccessFriend(ID, pictureRealName, statusmessage, i)	{
	var output = "";
	output += "<div id='Sdiv_" + i + "'>";
	output += "<table>";
	output += 		"<tr>";
	output +=			"<td><a href='#' style='padding-top:0px; padding-bottom:0px;'><img src='" + pictureRealName + "' style='width:55px; height:50px; float:left;'></a></td>";
	output +=			"<td style='width:72%;'><h4>" + statusmessage + "</h4></td>";
	output +=			"<td><button type='button' id='btnFr_"+i+"' style='width:55px;'>친구추가</button></td>";
	output += 		"</tr>";
	output += 		"<tr>";
	output +=			"<td>&nbsp&nbsp&nbsp&nbsp&nbsp" + ID + "</td>";
	output += 		"</tr>";
	output += "</table>";
	output += "<hr>";
	output += "</div>";
	$("#div3").append(output);
	//onclick 속성에 문자열을 값으로 넘기기 위해서는 onclick="test('asd')" 형식으로 만들어줘야 하는데 '가 겹치기 때문에 전자의 형식으로
	//만들지 못한다 그래서 제이쿼리를 이용하여 버튼이 실행되게 함.
	$("#btnFr_"+i).click(function()	{
		AddFriend(ID,i);
	});
}

//친구추가 버튼을 누르면 실행되는 함수
function AddFriend(AddID, i )	{
	//alert(AddID);
	$("#Sdiv_"+i).remove();
	var check = confirm(AddID + "님을 친구추가 하시겠습니까?");
	if(check == true)	{
		alert("확인 버튼 눌렀다.");
	}
	
	if(check == false)	{
		alert("취소 버튼 눌렀다.");
		return false;
	}
	
	$.ajax({ 
		url:"AddFriend",
		type:"POST",
		data:{AddID:AddID},
		success:function(result){
			var json = JSON.parse(result);
			if(json[0]["result"] == 1)	{
				alert(AddID + "님을 친구로 추가하셨습니다.");
			}
			else if(json[0]["result"] == -1)	{
				alert(AddID + "님을 친구로 추가하지 못했습니다.");
			}
		}
	});
}



var j = 0;
function FriendList(ID, pictureRealName, statusmessage)	{
	var output = "";
	output += "<table>";
	output += 		"<tr>";
	output +=			"<td><a href='#' style='padding-top:0px; padding-bottom:0px;'><img src='" + pictureRealName + "' style='width:55px; height:50px; float:left;'></a></td>";
	output +=			"<td style='width:72%;'><h4>" + statusmessage + "</h4></td>";
	output +=			"<td><button type='button' id='btnMr_"+i+"' style='width:55px;'>1:1 메세지 보내기</button></td>";
	output += 		"</tr>";
	output += 		"<tr>";
	output +=			"<td>&nbsp&nbsp&nbsp&nbsp" + ID + "</td>";
	output += 		"</tr>";
	output += "</table>";
	output += "<hr>";
	$("#div2").append(output);
	j++;
}


