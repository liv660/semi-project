<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

window.onload = function() {
	
	var msg = "${msg}";
	
	if (msg != null) {
		loginspan.innerHTML = msg;
	}
	
}

</script>

<style type="text/css">

body {
	margin: 0px;
	pading: 0px;
	font-family: sans-serif;
}

.box {
	width: 300px;
	padding: 40px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background: #fff;
	text-align: center;
}

.box h1, .box label {
	color : #EA9A56;
	text-transform: uppercase;
	font-weight: 500px;
}

.box input[type = "text"], .box input[type = "password"] {
	border : 0;
	background : none;
	display : block;
	margin: 20px auto;
	text-align: center;
	border : 2px solid #FFC091;
	padding: 14px 10px;
	width: 200px;
	outline: none;
	border-radius: 24px;
	transition: 0.25s;
}

.box input[type = "text"]:focus, .box input[type = "password"]:focus {
	width: 280px;
	border-color: #A48654;
}

.box input[type = "submit"] {
	border : 0;
	background : none;
	margin: 40px auto;
	text-align: center;
	border : 2px solid #FFC091;
	padding: 14px 40px;
	outline: none;
	border-radius: 24px;
	transition: 0.25s;
	cursor: pointer;
}

 .box input[type = "button"] {
 	border : 0;
	background : none;
	margin: 40px auto;
	text-align: center;
	border : 2px solid #EA9A56;
	padding: 14px 40px;
	outline: none;
	border-radius: 24px;
	transition: 0.25s;
	cursor: pointer;
 } 
 
.box input[type = "submit"]:hover {background: #FFC091;}

.box input[type = "button"]:hover {background: #EA9A56;}
 
#loginspan {color : red;}
 
.link {color : #A48654; text-decoration: none; font-size: small;}
.link:link {color : #A48654; text-decoration: none;}
.link:visited {color : #A48654; text-decoration: none;}
.link:hover {color : #A48654; text-decoration: none;}
.link:active {color : #A48654; text-decoration: none;}
.stick {color : #A48654;}

</style>

</head>
<body>

<% 	

	String value = "";
	if(request.getCookies() != null) {
	
	Cookie[] cookies = request.getCookies();
	
		for(Cookie c : cookies) {
		
		if("remuserid".equals(c.getName())) {
			value = c.getValue();
		}
	} 
	
	}%>

<form action="/login/login" method="post" class="box">

	<h1>Login</h1>
	
	<label for="id">아이디</label><br>
	<input type="text" id="id" name="id" <% if(!"".equals(value)) { %>
	
	value="<%=value %>"
	
	<% } %>/>
	
	<label for="pw">비밀번호</label><br>
	<input type="password" id="pw" name="pw" />
	
	<label for="autologin">자동 로그인</label>
	<input type="checkbox" id="autologin" name="autologin" />
	
	<label for="rememberid">아이디 저장</label>
	<input type="checkbox" id="rememberid" name="rememberid" /> <br>
	
	<span id="loginspan"></span>
	
	<a href="/main"><input type="button" id="cancle" value="main" /></a>
	<input type="submit" id="submit" value="login"/>
	
	<div style="border-top: 1px solid #A48654;">
	
	<a href="/login/terms" class="link">회원가입</a>
	<span class="stick">│</span>
	<a href="/login/findid" class="link">아이디 찾기</a>
	<span class="stick">│</span>
	<a href="/login/findpw" class="link">비밀번호 찾기</a>

</div>

<%  %>

</form>


</body>
</html>