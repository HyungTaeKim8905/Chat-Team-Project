<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String nick = (String)session.getAttribute("nick");
%>
<script>
alert("<%= nick %>가입을  축하드립니다.");

</script>