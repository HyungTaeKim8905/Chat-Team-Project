<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String id = request.getParameter("id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="./js/jquery-3.5.1.min.js"></script>
<script>
	function chkPW(){
		var pw = $("#newpassword").val();	
		var num = pw.search(/[0-9]/g);	//전체에서  0~9사이에 아무 숫자 '하나'  찾음 만약 1234가 입력되면 pw에는 1234가 저장되는지
		var eng = pw.search(/[a-z]/ig); 
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		if(pw.length < 8 || pw.length > 20){
			alert("8자리 ~ 20자리 이내로 입력해주세요.");
			return false;
		}else if(pw.search(/\s/) != -1){
			alert("비밀번호는 공백 없이 입력해주세요.");
			return false;
		}else if(num < 0 || eng < 0 || spe < 0 ){
			alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
			return false;
		}else {
			//console.log("통과"); 
			return true;
		}
	}
	
	$(document).ready(function(){      // blur() 요소에서 포커스를 잃을 경우에 발생하는 이벤트 이다

		$("#newpassword").blur(function(){
			if($(this).val()!=""){
				var result = chkPW();		// result값이 true면 blur 실행
			}
		});
	});
	
	function gogo()	{
		$("#join").click(function()	{
			alert("::::");
			if($("#newpassword").val() == ""){
				alert("비밀번호를 입력하세요.");
				$("#newpassword").focus();
				return false;
			}else if($("#newpasswordRe").val() == ""){
				alert("비밀번호 확인을 입력하세요.");
				$("#newpasswordRe").focus();
				return false;
			}else if($("#newpasswordRe").val() != $("#newpassword").val()){
				alert("비밀번호가 일치하지 않습니다.");
				$("#newpasswordRe").focus();
				return false;
			}
			var check = confirm("정말 비밀번호를 바꾸시겠습니까?");
			if(check == false)	{
				return false;
			}
			$.ajax({
				url:"Changepassword",
				type:"POST", 
				data:$("form").serialize(),
				success:function(result)	{
					var json = JSON.parse(result);
					if(json[0]["result"] == -1){
						alert("비밀번호 변경을 다시해주세요.");	
					}
					if(json[0]["result"] == 1){
						alert("비밀번호를 변경하였습니다.");	
					}
					window.close();
				}
			});
		});
	}
	
	
</script>
</head>
<body>
	<form id='form' name='form'><br>
		비밀번호 :     <input type='password' name='newpassword' id='newpassword' ><br>
		비밀번호 확인 : <input type='password' name='newpasswordRe' id='newpasswordRe'><br>
		<button type='button' id='join' onclick="gogo()">비밀번호 변경</button>
	</form>
</body>
</html>