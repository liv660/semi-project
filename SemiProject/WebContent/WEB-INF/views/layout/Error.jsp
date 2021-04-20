<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR PAGE</title>

<style type="text/css">

body {
	margin : 0px;
	padding : 0px;
	font-family: sans-serif;
	min-height: 100vh;
	background-image: linear-gradient(125deg, #6a89cc, #b8e994)
}

.container {
	width: 100%;
	position : absolute;
	top : 50%;
	transform : translateY(-50%);
	text-align: center;
	color: #343434;
}

.container h1 {
	font-size: 160px; 
	margin: 0px;
	font-weight: 900px;
	letter-spacing: 20px;
	background: url("/resources/image/pets.jpg");
	-webkit-text-fill-color: transparent;
	-webkit-background-clip: text;
}

.container a {
	text-decoration :none;
	color:#fff;
	background: #e55039aa;
	padding:12px 24px;
	display : inline-block;
	border-radius: 25px;
	font-size : 14px;
	text-transform: uppercase;
	transition : 0.4s;
}

.container a:hover {
	background : #e55039;
}

</style>

</head>
<body>
	<div class="container">
		<h2>페이지를 찾을 수 없습니다.</h2>
		<h1>ERROR</h1>
		<p>에러내용</p>
		<a href="/main">go back home</a>
	</div>


</body>
</html>