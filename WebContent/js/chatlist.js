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
			}		//"Num"
			for(var i = 0; json.length; i++)	{
				SuccessFriend(json[i]["Num"]);
			}
		}
	});
}

function SuccessFriend(Str) {
	var output = "";		//마이페이지 기능 구현 후 함.
	output += "<a href='#'>" + Str + "</a>";		//이미지 상태메세지도 출력 되야한다.
	output += "<hr>";
	$("#div2").html(output);
} 

function NoFriend()	{
	var output = "";
	output += "<h5>검색 결과를 얻어오지 못했습니다.</h5>";
	$("#div2").html(output);
}
