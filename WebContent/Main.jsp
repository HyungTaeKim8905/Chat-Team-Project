<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
	<%
		String n = request.getParameter("n");
		String cookie = "";
		String check = request.getHeader("cookie");
		Cookie[] cookies = null;
		if(check != null){	
			cookies = request.getCookies();	// getCookies() �޼��带 ����ؼ� ��Ű ������ �迭�� �����Ѵ�.(HTTP ��û �޼����� ����� ���Ե� ��Ű�� javax.servlet.http.Cookie �迭�� ����)		
		}
		for(int i = 0; i < cookies.length; i++)	{
			out.println(":::::::::::1  "+cookies[i].getName());
		}
		
		if(n != "1")	{
			if((cookies != null) && (cookies.length > 0))	{	// cookies == null �̸� ��Ű�� �������� �ʴ´�.
				for(int i = 0; i < cookies.length; i++)		{
					if(cookies[i].getName().equals("autologincheckbox"))	{
						session.setAttribute("id", cookies[i].getValue());
						%> <br><br><br><br><br><br><br><br><%
						out.println("::::::::::::2"+cookies[i].getValue());
					}
				}
			}
		}
		
		String id = (String)session.getAttribute("id");
		if(id == null){
			%><h1>�α��� �ȵǾ��ֳ� @@@@@@@@@@@@~</h1><%
		}
		
		if(id != null){
			%><h1>�α��� �Ǿ��ֳ� ~</h1><br/><br/><br/> <a href="logout.jsp">�α׾ƿ�</a><%
		}
%>
			hi!<br>
			<a href="anonymous.jsp">�͸� ä�ù� �ٷΰ���</a><br>
			���� ���̵� : <%= id %>
<!-- <script>alert(document.cookie)</script>  -->