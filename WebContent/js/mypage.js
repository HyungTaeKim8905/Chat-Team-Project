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
	var maxsize = 4000000;
	var filesize = 0;
	//5 * 1024 * 1024 30mb
	var browser = navigator.appName;	//브라우저 확인
	
	// 익스플로러일 경우
	if (browser == "Microsoft Internet Explorer") {
		var oas = new ActiveXObject("Scripting.FileSystemObject");
		filesize = oas.getFile(file.value).size;
	}
	else {
		filesize = file.files[0].size;
	}
	
	alert("파일 사이즈 : " + filesize);
	
	if(maxsize < filesize)	{
		alert("파일 용량을 초과하였습니다.....(제한 용량 : " + maxsize + "바이트)");
		return false;
	}
	alert("브라우저 종류 : " + browser);
	alert(fileName);
	if(fileName != "")	{
		var num = fileName.slice(fileName.lastIndexOf(".") + 1).toLowerCase();
		alert("필터링 한 이미지 확장자 네임 ::::::" + num);
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
	window.open("Changepassword.jsp","비밀번호 변경","width=600px,height=400px");
}

// 회원탈퇴 버튼을 누르면 실행되는 함수.
function Withdrawal()	{
	var check = confirm("정말 회원탈퇴를 하시겠습니까?");
	if(check == true)	{
		alert("확인 버튼 눌렀다.");
	}
	$.ajax({
		url:"withdrawal",
		type:"POST",
		success:function(result)	{
			var json = JSON.parse(result);
			if(json.length == 0)	{
				alert("다시 회원탈퇴를 해주세요.");
			}
			if(json[0]["result"] == 1)	{
				alert("정상적으로 회원탈퇴가 되었습니다.");
				location.href="Main.jsp";
			}
			if(json[0]["result"] == -1)	{
				alert("다시 회원탈퇴를 해주세요.");
			}
		}
	});
}



//마이페이지 수정해주는 함수.
function Modify()	{
	//찍어보자
	var check = confirm("수정하시겟습니까?");
	if(check == true)	{
		alert("확인 버튼 눌렀다.");
	}
	
	if(check == false)	{
		alert("취소 버튼 눌렀다.");
		return false;
	}
	var data = new FormData(form);	//ajax로 파일 전송시 FormData객체 생성 후 form을 넣어줘야한다.
	$.ajax({
		url:"Mypage",
		type:"POST", // data: "param1=aaaa&param2=zzzz,
		enctype: "multipart/form-data",
		contentType : false,
		processData : false,
		data:data,		//data:"id=" + <%= id %>
		success:function(result)	{
			var json = JSON.parse(result);
			if(json.length == 0)	{
				alert("받아온 제이슨 데이터가 0입니다.");
			}
		}
	});
}






















		