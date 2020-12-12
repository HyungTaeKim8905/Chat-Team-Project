<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String sessionID = (String)session.getAttribute("id");
	if(sessionID == null)	{
		%><script> alert("������ �����ϴ�."); location.href="Main.jsp"; </script><%	
	}
%>
<!DOCTPYE html lang="ko">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- �׺�� css -->
		<link rel="stylesheet" type="text/css" href="./css/nav.css" />
		<!-- ���������� css -->
		<link rel="stylesheet" type="text/css" href="./css/mypage.css" />
		<!-- ���������� js -->
		<script src="./js/mypage.js"></script>
		<!-- jQuery -->
		<script src="./js/jquery-3.5.1.min.js"></script>
		<title>���� ������</title>
	</head>
	<body>
		<!-- �׺�� -->
		<div class="topnav" id="myTopnav">
			<a href="chatlist.jsp">ä�ù�</a>
			<a href="#contact" class="active">����������</a>
		</div>
		
		<!-- ���������� -->
		<div class="container">
			<form id="form" name="form" action="Mypage" method="post" enctype="multipart/form-data">
			<div id="imgfile">
					<img src="./image/man.jpg">
				</div>
				<div class="filebox">
					<label for="file">���� ����</label>
					<input type="file" id="file" name="file" accept=".gif, .jpg, .png" onchange="readInputFile(event.target)">
				</div>
				
			<label for="nick">�г���</label>
			<input type="text" id="nick" name="nick" placeholder="ȫ�浿" readonly>
			
			<label for="country">���</label>
			<select id="country" name="country">
			  <option value="australia">Australia</option>
			  <option value="canada">Canada</option>
			  <option value="usa">USA</option>
			  <option value="Korea">Korea</option>
			</select>
	
			<label for="statusmessage">���� �޼���</label>
			<div id="StatusMessage_d">
			<input type="text" id="statusmessage" name="statusmessage" value="test" placeholder="���� �޼��� �Է�..">
			</div>
			<button type="button" onclick="Modify()">����</button><button type="button" class="PasswordChange" onclick="PasswordChange()"> ��й�ȣ ����</button><button type="button" onclick="Withdrawal()">ȸ��Ż��</button>
		  </form>
		</div>
	</body>
</html>