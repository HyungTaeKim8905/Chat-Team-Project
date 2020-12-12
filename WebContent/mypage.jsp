<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*"%>
<%
	String sessionID = (String)session.getAttribute("id");
	if(sessionID == null)	{
		%><script> alert("������ �����ϴ�."); location.href="Main.jsp"; </script><%	
	}
	DBManager dbm = new DBManager();
	String sql = "select nick, statusmessage, pictureOriginName, pictureRealName from user where id = '" + sessionID + "'";
	String nick = "";
	String img = "";
	String statusmessage = "";
	try	{
		dbm.DBOpen();
		dbm.OpenQuery(sql);
		while(dbm.ResultNext())	{
			nick = dbm.getString("nick");
			img = dbm.getString("pictureRealName");
			statusmessage = dbm.getString("statusmessage");
		}
		dbm.CloseQuery();
		dbm.DBClose();
	} catch(Exception e)	{
		System.out.println("ERRO : " + e.getMessage());
	}
	if(statusmessage == null)	{
		statusmessage = "";
	}
	if(img == "null" || img == "NULL" || img == null)	{
		//�ű� ȸ�������̶�� �⺻ ������ �Ƿ��ش�.
		img = "./image/man.jpg";
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
					<img src="<%= img %>">
				</div>
				<div class="filebox">
					<label for="file">���� ����</label>
					<input type="file" id="file" name="file" accept=".gif, .jpg, .png" onchange="readInputFile(event.target)">
				</div>
				
			<label for="nick">�г���</label>
			<input type="text" id="nick" name="nick" placeholder="ȫ�浿" value="<%= nick %>">
			
			<label for="country">���</label>
			<select id="country" name="country">
			  <option value="australia">Australia</option>
			  <option value="canada">Canada</option>
			  <option value="usa">USA</option>
			  <option value="Korea">Korea</option>
			</select>
	
			<label for="statusmessage">���� �޼���</label>
			<div id="StatusMessage_d">
			<input type="text" id="statusmessage" name="statusmessage" value="<%= statusmessage %>" placeholder="���� �޼��� �Է�..">
			</div>
			<input type="hidden" id="id" name="id" value="<%= sessionID %>">
			<button type="button" onclick="Modify()">����</button><button type="button" class="PasswordChange" onclick="PasswordChange()"> ��й�ȣ ����</button><button type="button" onclick="Withdrawal()">ȸ��Ż��</button>
		  </form>
		</div>
	</body>
</html>