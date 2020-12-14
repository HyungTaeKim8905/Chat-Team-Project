<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//*************** ��Ű�� �������� **********************************************************************************
String sessionID = (String)session.getAttribute("id");
if(sessionID != null){
	%> <script>alert("�߸��� �����Դϴ�."); location.href="Main.jsp"; </script> <%
}
String cookie = "";
String check = request.getHeader("cookie"); 
// out.println("getHeader : " + check);
Cookie[] cookies = null;
if(check != null){	
	cookies = request.getCookies();	// getCookies() �޼��带 ����ؼ� ��Ű ������ �迭�� �����Ѵ�.(HTTP ��û �޼����� ����� ���Ե� ��Ű�� javax.servlet.http.Cookie �迭�� ����)		
}

if((cookies != null) && (cookies.length > 0))	{	// cookies == null �̸� ��Ű�� �������� �ʴ´�.
	for(int i = 0; i < cookies.length; i++)		{
		if(cookies[i].getName().equals("id"))	{	// getName()�޼��带 �̿��Ͽ� ��Ű �̸��� ������ id�� �� ��ġ�Ѵٸ�
			cookie = cookies[i].getValue();			// getValue()�޼��带 �̿��Ͽ� ��Ű ���� cookie�� ����.
			//session.setAttribute("id", cookies[i].getValue());
		}
	}
}
/*
�̿� ���� ������ ����ڰ� �α����� ���� �ʾƵ� ���� ���� �� JSESSIONID ��Ű ���� �������� �����ִ� ���� �� �� �ִ�.
�׷� �� ��Ű ���� �����ִ� �ɱ�? HTTP ���������� stateless�� Ư¡�� ������ �ֱ� ������ ����ڿ� ������ �� �ѹ��� 
��û�� �������� ������ ��������. �׷��� ������ ���������� ������� �α��� ���� ���θ� Ȯ���� �� �ֵ��� key �� 
ó�� ����� �� �ִ� JSESSIONID ���� Ŭ���̾�Ʈ�� ���������ν� �̸� �̿��Ͽ� �α��� ó���� �� �� �ִ� ���̴�.
*/
//************************************************************************************************************
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- �׺�� css -->
  <link rel="stylesheet" type="text/css" href="./css/nav.css" />
  <!-- ä�ù� ����Ʈ css -->
  <link rel="stylesheet" type="text/css" href="./css/chatlist.css" />
  <!-- ȸ������ css -->
  <link rel="stylesheet" type="text/css" href="./css/register.css" />
  
  <title>�α���</title>

  <!-- �׺�� -->
  <div class="topnav" id="myTopnav">
    
    <abbr title="ȸ�� ä��">
      <a href="chatlist.jsp">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-left-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v11.586l2-2A2 2 0 0 1 4.414 11H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
            <path fill-rule="evenodd" d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
          </svg>
    </a>
    </abbr>

    <abbr title="��ȸ�� ä��">
      <a href="anonymous.jsp" >
    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-chat-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h2.5a2 2 0 0 1 1.6.8L8 14.333 9.9 11.8a2 2 0 0 1 1.6-.8H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
        </svg>
    </a>
    </abbr>

    <abbr title="ȸ������" >
      <a href="register.jsp" style="float: right;" >
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-person-plus" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M8 5a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6 5c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10zM13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
        </svg>
      </a>
      </abbr>
  
      <abbr title="�α���" >
      <a href="login.jsp" style="float: right;" class="active">
        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-lock" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M11.5 8h-7a1 1 0 0 0-1 1v5a1 1 0 0 0 1 1h7a1 1 0 0 0 1-1V9a1 1 0 0 0-1-1zm-7-1a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h7a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-7zm0-3a3.5 3.5 0 1 1 7 0v3h-1V4a2.5 2.5 0 0 0-5 0v3h-1V4z"/>
        </svg>
      </a>
    </abbr>
  </div>
</head>
<body>
  <div class="container">
  <!-- ���� ���� -->
  <div class="leftem" style="width:25%; height: 94%; float: left; background-color: white;">
  </div>
  <!-- �α���â -->
  <div class="centerlo" style="width:50%; height: 100%; float: left; ">
    <form action="login" method="post">
      <div class="container">
        <h1>�α���</h1>
        <hr>
        <label for="id"><b>���̵�</b></label>
        <input type="text" placeholder="�̸����� �Է����ּ���" value="<%= cookie %>" name="id" id="id" required>
    
        <label for="password"><b>��й�ȣ</b></label>
        <input type="password" placeholder="��й�ȣ�� �Է����ּ���" name="password" id="password" required>
        <hr>

        <input type="checkbox" name="rememberid">���̵� ����
        <input type="checkbox" name="rememberlogin">�ڵ� �α���

        <button type="submit" class="registerbtn">�α���</button>
      </div>
      
      <div class="container signin">
        <p> <a href="#">���̵� ã��</a> / <a href="#">��й�ȣ ã��</a></p>
      </div>
      <br/>
        <center>���̵� �����Ű���? <a href="register.jsp">ȸ������</a></center>
    </form>
</div>

</div>
</body>
</html>