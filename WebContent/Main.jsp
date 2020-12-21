<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
	<head>
		<script src="jquery-3.5.1.min.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
		<title>메인 홈페이지</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<style>
		.div1 {
			width:250px;
		}
		
		#a1 {
			color:gray;
			font-size:13px;
		}
		
		#a2 {
			color:gray;
			font-size:13px;
		}
		
		.h1 {
			position:absolute;
			left:1360px;
			width:330px;
			top:50px;
		}
		.h6 {
			position:absolute;
			left:1324px;
			width:280px;
			top:98px;
		}
		
		.sidenav {
			height: 100%;
			width: 260px;
			position: fixed;
			z-index: 1;
			top: 0;
			left: 0;
			background-color: #111;
			overflow-x: hidden;
			padding-top: 20px;
		}

		.sidenav a {
			padding: 6px 8px 6px 16px;
			text-decoration: none;
			font-size: 25px;
			color: #818181;
			display: block;
		}

		.sidenav a:hover {
			color: #f1f1f1;
		}
		
		.aside1 {
			height: 100%;
			width:260px;
			position: fixed;
			background-color:#FFD700;
			top: 0;
			left: 0;
			left:1625px;
			width:299px;
		}
		
		#introImg {
			width:1320px;
			height:600px;
			position:absolute;
			left:285px;
			top:200px;
		}
		
		.h11 {
			position:absolute;
			left:285px;
			top:850px;
		}
		#carouselExampleSlidesOnly {
			width:900px; height:300px;
			position:relative;	
			left:300px;
			top:200px;
		}
		.ImageNext {
			width:370px;
			position:absolute;
			left:1230px;
			top:220px;
		}
		
		.hr1 {
			position:absolute;
			top:905px;
			left:290px;
			border: 0;
			height: 3px;
		}
		
		.box {
			width:100px;
			height:60px;
			background-color:red;
			position:relative;
			top:20px;
			left:20px;
		}
	</style>
	<body>
	<div class="sidenav">
		<a href="anonymous.jsp">Anonymous</a>
<%
			if(id != null) {
%>
				<a href="mypageAction">MyBoard</a>
				<a href="chatlist.jsp">Chat</a>
<%
			}
%>		
	</div>
		<header>
			<div class="div1" style="position:relative; left:1330px">
			<% 
				if(id == null)	{
			%>
				<a href="login.jsp" id="a1">로그인 | </a><a href="register.jsp" id="a1">회원가입</a>
			<%
				}
				else	{ 
					%> <%= id %>님 환영합니다.<a href="logout.jsp" id="a2"> 로그아웃</a><a href="mypageAction">내 정보</a> <%
				}
			%>
			</div>
			<h1 class="h1">Chat Design</h1>
				<h6 class="h6">This is my homepage. Have a nice day</h6>
		</header>
		<section>
			<article>
				<div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="./MainImage/us.jpg" class="d-block w-100" alt="...">
						</div>
						
						<div class="carousel-item">
							<img src="./MainImage/skyline.jpg" class="d-block w-100" alt="...">
						</div>
						
						<div class="carousel-item">
							<img src="./MainImage/manhattan.jpg" class="d-block w-100" alt="...">
						</div>
						
						<div class="carousel-item">
							<img src="./MainImage/chicago.jpg" class="d-block w-100" alt="...">
						</div>
						
						<div class="carousel-item">
							<img src="./MainImage/tower.jpg" class="d-block w-100" alt="...">
						</div>
						
						<div class="carousel-item">
							<img src="./MainImage/bridge.jpg" class="d-block w-100" alt="...">
						</div>
					</div>
				</div>
				<div class="ImageNext">
					<p class="font-weight-bold">After exploring the codelab playlist, try one of</p>
					<p class="font-weight-bold">our quickstarts to quickly build a working scri</p>
					<p class="font-weight-bold">pt project. Create menus and custom function</p>
					<p class="font-weight-bold">s Google Sheets, manage responses in Google</p>
					<p class="font-weight-bold"> Forms, or create a basic Google Docs add-on o</p>
					<p class="font-weight-bold">r Hangouts Chat bot!Apps Script makes it easy</p>
					<p class="font-weight-bold">to create and publish add-ons for Google Docs,</p>
					<p class="font-weight-bold">Sheets, Slides, and Forms. There’s no better wa</p>
					<p class="font-weight-bold">y to carousel GT. large numbers of users, wheth</p>
					<p class="font-weight-bold">er you want to ship your code to the whole wor</p>
					<p class="font-weight-bold">ld or keep it private to its population has been</p>
					<p class="font-weight-bold">profoundly shaped by centuries of immigration.</p>
				</div>
			</article>
			
			<article>
				<h1 class="h11">Chat Design Product</h1>
				<hr width = "68%" color = "#ccc" class="hr1">
				<div class="box">
					
				</div>
			</article>
		</section>
		<aside class="aside1">
		
		</aside>
	</body>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
</html>