<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	 <script src="./js/jquery-3.5.1.min.js"></script>
</head>
<body>
<%
	String cookie = "";
	String check = request.getHeader("cookie");
	Cookie[] cookies = null;
	
	
	if(check != null){	
		cookies = request.getCookies();	// getCookies() �޼��带 ����ؼ� ��Ű ������ �迭�� �����Ѵ�.(HTTP ��û �޼����� ����� ���Ե� ��Ű�� javax.servlet.http.Cookie �迭�� ����)		
	}
	
	if((cookies != null) && (cookies.length > 0))	{	
		for(int i = 0; i < cookies.length; i++)		{
			if(cookies[i].getName().equals("autologincheckbox")){
				cookies[i].setMaxAge(0);
				response.addCookie(cookies[i]);
			}
		}
	}
		session.invalidate();
	%>
	<form name="form" id="form" method="post" action="Main.jsp">
		<input type="hidden" id="num" name="num" value="1">
	</form>
	 <script>
		alert("�α׾ƿ� �Ǿ����ϴ�.");
		
		$("#form").submit();
	</script>
	
</body>
</html>