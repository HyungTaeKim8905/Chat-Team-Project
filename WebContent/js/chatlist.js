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
  $.ajax({
		url:"PrintFriend",
		type:"POST",
		success:function(result){
			var json = JSON.parse(result);
			if(json.length == 0)	{
				alert("친구 리스트가 없습니다.");
			}
			$("#div2").html("");
			for(var i = 0; i <json.length; i++)	{
				FriendList(json[i]["Nick"], json[i]["pictureRealName"], json[i]["statusmessage"], i);
			}
		}
	});
}

//친구 검색을 하면 실행되는 메서드
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

// 친구 검색을 하면 실행되는 메서드후 친구들을 뿌려주는 메서드
function SuccessFriend(Nick, pictureRealName, statusmessage, i)	{
	var output = "";
	output += "<div id='Sdiv_" + i + "'>";
	output += "<table>";
	output += 		"<tr>";
	output +=			"<td><a href='#' style='padding-top:0px; padding-bottom:0px;'><img src='" + pictureRealName + "' style='width:55px; height:50px; float:left;'></a></td>";
	output +=			"<td style='width:72%;'><h4>" + statusmessage + "</h4></td>";
	output +=			"<td><button type='button' id='btnFr_"+i+"' style='width:55px;'>친구추가</button></td>";
	output += 		"</tr>";
	output += 		"<tr>";
	output +=			"<td>&nbsp&nbsp&nbsp&nbsp&nbsp" + Nick + "</td>";
	output += 		"</tr>";
	output += "</table>";
	output += "<hr>";
	output += "</div>";
	$("#div3").append(output);
	//onclick 속성에 문자열을 값으로 넘기기 위해서는 onclick="test('asd')" 형식으로 만들어줘야 하는데 '가 겹치기 때문에 전자의 형식으로
	//만들지 못한다 그래서 제이쿼리를 이용하여 버튼이 실행되게 함.
	$("#btnFr_"+i).click(function()	{
		AddFriend(Nick,i);
	});
}

//친구추가 버튼을 누르면 실행되는 함수
function AddFriend(AddID, i)	{
	//alert(AddID);
	$("#Sdiv_"+i).remove();	//삭제를 해줄때는 무조건 i값을 파라미터로 받아서 처리해준다.
							//전역변수로 i값을 설정하면 아래있는 div가 삭제된다.
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


//친구 리스트를 뿌려주는 함수.
function FriendList(ID, pictureRealName, statusmessage, i)	{
	var output = "";
	output += "<div id='divDn_" + i + "'>";
	output += "<table>";
	output += 		"<tr>";
	output +=			"<td><a href='#' style='padding-top:0px; padding-bottom:0px;'><img src='" + pictureRealName + "' style='width:55px; height:50px; float:left;'></a></td>";
	output +=			"<td style='width:72%;'><h4>" + statusmessage + "</h4></td>";
	output +=			"<td><button type='button' id='btnMr_"+i+"' style='width:60px;'>메세지 보내기</button></td>";
	output += 		"</tr>";
	output += 		"<tr>";
	output +=			"<td>&nbsp&nbsp&nbsp&nbsp" + ID + "</td>";
	output +=			"<td></td>";
	output +=			"<td style='text-align:right;'><button type='button' id='btnDn_" + i + "' style='width:60px; height:42px;'>친구<br>끊기</button></td>";
	output += 		"</tr>";
	output += "</table>";
	output += "<hr>";
	output += "</div>";
	$("#div2").append(output);
	$("#btnDn_" + i).click(function()	{
		DeleteFriend(ID, i);
	});
}

// 친구 끊기 버튼 누르면 실행되는 함수.
function DeleteFriend(DeleteID, i)	{
	alert("i:::::" + i);
	var check = confirm(DeleteID + "님을 삭제 하시겠습니까?");
	if(check == true)	{
		alert("확인 버튼 눌렀다.");
	}
	
	if(check == false)	{
		alert("취소 버튼 눌렀다.");
		return false;
	}
	$("#divDn_" + i).remove();
	$.ajax({ 
		url:"DeleteFriend",
		type:"POST",
		data:{DeleteID:DeleteID},
		success:function(result){
			var json = JSON.parse(result);
			if(json[0]["Num"] == 1)	{
				alert("삭제하였습니다.");
			}
			else if(json[0]["Num"] == -1)	{
				alert("삭제를 못헀다.");
			}
		}
	});
}


//친구목록 검색을하면 실행되는 메서드
function SerachFriend()	{	//서블릿 만들어야함.
	var SearchID = $("#friend").val();
	alert(SearchID);
	$.ajax({ 
		url:"SearchFriend",
		type:"POST",
		data:{SearchID:SearchID},
		success:function(result){
			var json = JSON.parse(result);
			if(json.length == 0)	{
				alert("친구목록을 가져오지 못했습니다.");
			}
			$("#div2").html("");
			for(var i = 0; json.length; i++)	{
				FriendList(json[i]["ID"], json[i]["pictureRealName"], json[i]["statusmessage"],i);
			}
		}
	});
}









