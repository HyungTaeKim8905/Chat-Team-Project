﻿	function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	               																
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
		
		
		
	// 아이디 중복확인 버튼을 눌렀을때 실행되는 함수
	var IDKimCheck = false;
	function idcheck()	{
		var id = document.form.id.value;
		//alert(id);
		$.ajax({
			url:"IDCheck",
			type:"POST", // data: "param1=aaaa&param2=zzzz,
			data:"id="+id,
			success:function(result)	{
				var json = JSON.parse(result);
				if(json[0]["result"] == true)	{
					IDKimCheck = true;
					alert("사용 가능한 아이디입니다.");
				}
				if(json[0]["result"] == false)	{
					alert("사용중인 아이디입니다.");
				}
			}
		});
	}
	
	//이메일 인증 버튼을 누르면 실행되는 함수
	var check = false;
	function EmailCheck()	{
	var mun = "@";
	var sender = $("#sender").val();
	var email = $("#email").val();
	if(sender == null || sender == "")	{
		return false;
	}
	if(email == null || email == "")	{
		alert("이메일 형식이 올바르지 않습니다.");
		return false;
	}
	if(email.indexOf("@") == -1 || email.indexOf(".") == -1)	{
		alert("이메일 형식이 올바르지 않습니다.1111111111");
		return false;
	}
	alert("귀하의 메일로 인증번호가 발송되었습니다.");
		$.ajax({
			url:"mailSendServlet",			//서블릿페이지로 이동.
			type:"POST",
			data:"email="+email + "&sender="+sender,
			success:function(result)	{
				var json = JSON.parse(result);
				var data = "";
				var output = "";
				output += "<input type='text' id='output' name='output'>";
				output += "<button type='button' style='width:200px;' class='registerbtn' onclick='Good(" + json[0]["numStr"] + ")'>인증</button>";
				$("#div1").html(output);
			}
		});
	}
	
	//인증 버튼을 누르면 실행되는 함수.
	function Good(num)	{
		 var output = $("#output").val();
		 if(output == num)	{
			 check = true;
			 alert("메일 인증이 확인되었습니다.");
			 $("#div1").html("메일 인증이 완료되었습니다.");
		 }
		 else	{
			check = false;
			alert("인증번호가 다릅니다."); 
		 }
	}



	// 비밀번호를 입력하는데 있어서 특수문자를 입력하라거나 공백없이 입력하라는 문구를 무시하고 회원가입을 할 수 있기 때문에 이를 막아주는 로직
	var pwCheckYn = false;		//비밀번호 체크를 하기 위한 변수 선언
	
	function chkPW(){
		var pw = $("#password").val();	
		var num = pw.search(/[0-9]/g);	//전체에서  0~9사이에 아무 숫자 '하나'  찾음 만약 1234가 입력되면 pw에는 1234가 저장되는지
		var eng = pw.search(/[a-z]/ig); 
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		if(pw.length < 8 || pw.length > 20){
			alert("8자리 ~ 20자리 이내로 입력해주세요.");
		}else if(pw.search(/\s/) != -1){
			alert("비밀번호는 공백 없이 입력해주세요.");
		}else if(num < 0 || eng < 0 || spe < 0 ){
			alert("비밀번호 영문,숫자, 특수문자를 혼합하여 입력해주세요.");
		}else {
			//console.log("통과");
			pwCheckYn = true;
		}
	}
	
	 $(document).ready(function(){      // blur() 요소에서 포커스를 잃을 경우에 발생하는 이벤트 이다
		$("#password").blur(function(){
			if($(this).val()!=""){
				chkPW();		// result값이 true면 blur 실행
			}
		});
		
		$("#id").click(function()	{
			IDKimCheck = false;
		});
		
		$("#email").click(function()	{
			check = false;
		});
		
		$("form").submit(function(){
		/*
			//아이디 중복확인을 쌩까고 회원가입하는걸 막아주는 로직(무조건 아이디 중복확인을 해야 회원가입이 가능)
			var url = location.href;	//현재 url 가져와서 변수 url에 할당	
			// 인자값으로 넘기는 문자열을 기준으로 잘라서 배열로 반환
			var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
			//변수 url에서 ? 바로 뒤 문자 부터 url끝 까지 잘라온다
			//잘라온 후 &를 기준으로 파라미터들을 배열로 parameters 변수에 할당
			value = parameters[0].split('=')[1];
			//parameters 배열의 0번째 인덱스에 해당하는 원소를 =를 기준으로 잘라서
			//배열을 만들고 value 변수에 1번쨰 인덱스 원소값을 할당한다.
			
			// value = 1 or "" or null이라면 회원가입 버튼을 눌렀을때 리턴시킨다. 
			if((value == 1) || (value == "") || (value == null))	{
				alert("아이디 중복확인을 해주세요.");
				return false;
			}
			*/
			if($("#password").val() != ""){////////////////////
				if(pwCheckYn == false){
					alert("비밀번호를 다시 입력해주세요.");
					return false;
				}
			}
			if($("#id").val() == ""){		
				alert("아이디를 입력하세요.");
				$("#id").focus();
				return false;
			}else if($("#password").val() == ""){
				alert("비밀번호를 입력하세요.");
				$("#password").focus();
				return false;
			}else if($("#confirmPassword").val() == ""){
				alert("비밀번호 확인을 입력하세요.");
				$("#confirmPassword").focus();
				return false;
			}else if($("#confirmPassword").val() != $("#password").val()){
				alert("비밀번호가 일치하지 않습니다.");
				$("#confirmPassword").focus();
				return false;
			} else if($("#name").val() == ""){
				alert("이름을 입력하세요.");
				$("#name").focus();
				return false;
			}else if($("#email").val() == ""){
				alert("이메일을 입력하세요.");
				$("#email").focus();
				return false;
			}else if($("#phone2 ").val() == ""){
				alert("전화번호를 입력하세요.");
				$("#phone2").focus();
				return false;
			}
			else if(IDKimCheck == false)	{
				alert("아이디 중복확인을 해주세요.");
				return false;	
			}
			else if(check == false)	{
				alert("이메일 인증을 다시 해주세요.");
				return false;	
			} else{
				var postcode = $("#sample6_postcode").val();
				var address = $("#sample6_address").val();
				var detailAddress = $("#sample6_detailAddress").val();
				var extraAddress = $("#sample6_extraAddress").val();			//각각의 주소값을 각각의 변수에 저장
				var result = postcode.concat(" ", address," ", detailAddress," ", extraAddress);
				
				$("#address").val(result);
				//---------------------------------
				var phone1 = $("#phone1").val();
				var phone2 = $("#phone2").val();
				if(phone2 == "")	{
					alert("전화번호를 제대로 작성 해주세요.");
					return false;
				}
				var phone3 = $("#phone3").val();
				if(phone3 == ""){
					alert("전화번호를 제대로 작성 해주세요.");
					return false;
				}
				var result1 = phone1.concat("-", phone2,"-", phone3);
				$("#phone").val(result1);
				return true;
			}
		});
	});