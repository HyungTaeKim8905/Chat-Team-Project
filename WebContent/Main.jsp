<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
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