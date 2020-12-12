//사진 변경 버튼 클릭 후 사진을 변경하면 화면에 사진을 뿌려주는 함수.
function readInputFile(input) {
	if(input.files && input.files[0]) { 	//파일이 선택된 상태라면
		var reader = new FileReader();		// 파일을 읽기 위해서 객체 생성
		reader.onload = function (e) {		// 파일을 읽어들이기를 성공했을때 호출되는 이벤트
			var check = fileCheck();
			if(check != true)	{
				return false;
			}
			$("#imgfile").html("<img src='"+ event.target.result +"'>");	// event.target.result => 파일의 경로 + 이미지 이름
		}
		reader.readAsDataURL(input.files[0]);
	}
}
			
//이미지 확장자가 아니면 실행되는 함수
function fileCheck()	{
	var fileName = $("#file").val();
	alert(fileName);
	if(fileName != "")	{
		var num = fileName.slice(fileName.lastIndexOf(".") + 1).toLowerCase();
		alert("핉러링 한 이미지 확장자 네임 ::::::" + num);
		if(num != "gif" && num != "jpg" && num != "png")	{
			alert("이미지파일 (.jpg, .png, .gif)만 업로드 가능합니다.");
			return false;
		}
		else	{
			return true;
		}
	}
}

// 비밀번호 변경 버튼을 누르면 실행되는 함수.
function PasswordChange()	{
	// chatlist.html?id=<%= id %> id를 파라미터로 붙인다.
	window.open("chatlist.html","비밀번호 변경","width=600px,height=400px");
}

// 회원탈퇴 버튼을 누르면 실행되는 함수.
function Withdrawal()	{
	var check = confirm("정말 회원탈퇴를 하시겠습니까?");
	if(check == true)	{
		alert("확인 버튼 눌렀다.");
	}
	
	if(check == false)	{
		alert("취소 버튼 눌렀다.");
		return false;
	}
	
	alert("ajax 통신 한다 ?");
	$.ajax({
		url:"#",
		type:"POST", // data: "param1=aaaa&param2=zzzz,
		// 인자값을 serialize말고 id로 @@@@@@@@@@@@ 수정해야하는 부분
		data:$("form").serialize(),		//data:"id=" + <%= id %>
		success:function(result)	{
			//회원탈퇴 처리 완료되면 무슨 페이지로 이동?
		}
	});
}



function Modify()	{
	//찍어보자
	var check = confirm("정말 회원탈퇴를 하시겠습니까?");
	if(check == true)	{
		alert("확인 버튼 눌렀다.");
	}
	
	if(check == false)	{
		alert("취소 버튼 눌렀다.");
		return false;
	}
	$.ajax({
		url:"Mypage",
		type:"POST", // data: "param1=aaaa&param2=zzzz,
		data:$("form").serialize(),		//data:"id=" + <%= id %>
		success:function(result)	{
			//회원탈퇴 처리 완료되면 무슨 페이지로 이동?
		}
	});
}
		