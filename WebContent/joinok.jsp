<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String nick = (String)session.getAttribute("nick");
%>
<script>
alert("<%= nick %>������  ���ϵ帳�ϴ�.");

</script>