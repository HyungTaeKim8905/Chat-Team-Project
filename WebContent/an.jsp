<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<link rel="stylesheet" type="text/css" href="./css/chat.css" />
<% 
/*
	String no = request.getParameter("no");

	Connection m_Connection = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String m_DBMS = "jdbc:mysql://127.0.0.1/project02?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String m_UserID = "root";
	String m_UserPass = "mySQL1234";

	Class.forName("com.mysql.cj.jdbc.Driver");
	
	try(
		m_Connection = DriverManager.getConnection(m_DBMS, m_UserID, m_UserPass);
			
	){
		
		
	}catch(Exception e){
		
	}
	*/
%>


<div class="chat">
<!-- 상대 채팅 -->
    <div class="chat other" onclick="location.href='#'">
      <p>안녕안녕</p>
      <span class="time-right">11:00</span>
    </div>
    
    <!-- 내 채팅 -->
    <div class="chat me" onclick="location.href='#'">
      <p>그래그래</p>
      <span class="time-left">11:00</span>
    </div>
    <!-- 상대 채팅 -->
    <div class="chat other" onclick="location.href='#'">
      <p>안녕안녕</p>
      <span class="time-right">11:00</span>
    </div>
    
    <!-- 내 채팅 -->
    <div class="chat me" onclick="location.href='#'">
      <p>그래그래</p>
      <span class="time-left">11:00</span>
    </div>
    <!-- 상대 채팅 -->
    <div class="chat other" onclick="location.href='#'">
      <p>안녕안녕</p>
      <span class="time-right">11:00</span>
    </div>
    
    <!-- 내 채팅 -->
    <div class="chat me" onclick="location.href='#'">
      <p>그래그래</p>
      <span class="time-left">11:00</span>
    </div>
    <!-- 상대 채팅 -->
    <div class="chat other" onclick="location.href='#'">
      <p>안녕안녕</p>
      <span class="time-right">11:00</span>
    </div>
    
    <!-- 내 채팅 -->
    <div class="chat me" onclick="location.href='#'">
      <p>그래그래</p>
      <span class="time-left">11:00</span>
    </div>
    <!-- 상대 채팅 -->
    <div class="chat other" onclick="location.href='#'">
      <p>안녕안녕</p>
      <span class="time-right">11:00</span>
    </div>
    
    <!-- 내 채팅 -->
    <div class="chat me" onclick="location.href='#'">
      <p>그래그래</p>
      <span class="time-left">11:00</span>
    </div>
    <!-- 상대 채팅 -->
    <div class="chat other" onclick="location.href='#'">
      <p>안녕안녕</p>
      <span class="time-right">11:00</span>
    </div>
    
    <!-- 내 채팅 -->
    <div class="chat me" onclick="location.href='#'">
      <p>그래그래</p>
      <span class="time-left">11:00</span>
    </div><!-- 상대 채팅 -->
    <div class="chat other" onclick="location.href='#'">
      <p>안녕안녕</p>
      <span class="time-right">11:00</span>
    </div>
    
    <!-- 내 채팅 -->
    <div class="chat me" onclick="location.href='#'">
      <p>그래그래</p>
      <span class="time-left">11:00</span>
    </div><!-- 상대 채팅 -->
    <div class="chat other" onclick="location.href='#'">
      <p>안녕안녕</p>
      <span class="time-right">11:00</span>
    </div>
    </div>