<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
		if(id == null){
			%><h1>�α��� �ȵǾ��ֳ� @@@@@@@@@@@@~</h1><%
		}
		
		if(id != null){
			%><h1>�α��� �Ǿ��ֳ� ~</h1><%
		}
	%>
	hi!
	<a href="anonymous.jsp">�͸� ä�ù� �ٷΰ���</a>
	���� ���̵� : <%= id %>
</body>
</html>