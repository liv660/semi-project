<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<% String id = (String) request.getAttribute("id"); %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

body {text-align : center;}

.wrap {
	border : 1px solid #A48654;
	width : 500px;
	height : 300px;
	margin : 0 auto;
	margin-top : 100px;
}

.wrap h1 {
	color : #EA9A56;
	text-transform: uppercase;
	font-weight: 500px;
	margin-top: 70px;
	margin-bottom : 30px;
}

.word {font-size : 20px;}

.res {color : #EA9A56;}

.wrap input[type = "button"] {
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

.wrap input[type = "button"]:hover {background: #EA9A56;}
 
 a {color : #000;}
 a:hover {color: #000;}
 
.link {color : #A48654; text-decoration: none; font-size: small;}
.link:link {color : #A48654; text-decoration: none;}
.link:visited {color : #A48654; text-decoration: none;}
.link:hover {color : #A48654; text-decoration: none;}
.link:active {color : #A48654; text-decoration: none;}
.stick {color : #A48654; font-size: small;}

</style>

</head>
<body>
 
<div class="wrap">
	<h1> ID </h1>
	
	<%if (id == null) { %>
		<span class="word">조회된 결과가 없습니다</span>
	<% } else { %>
		<span class="word">아이디는</span> <span class="res"><%=id %></span> <span class="word">입니다.</span>
	<% } %>
	
	<br>
	<a href="/main"><input type="button" id="button"  class="button" value="main"/></a>

</div>

<span class="stick">혹시 비밀번호를 찾으시나요? │ </span>
<a href="/login/findpw" class="link">비밀번호 찾기</a>

</body>
</html>