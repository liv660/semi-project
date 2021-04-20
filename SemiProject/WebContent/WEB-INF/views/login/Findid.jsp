<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="/resources/css/find.css"/>

</head>
<body>

<form action="/login/findid" method="post" class="box">

<h1>아이디 찾기</h1>

	<label for="name">이름</label>
	<input type="text" id="name" name="name" />
	
	<label for="email">이메일</label>
	<input type="text" id="email" name="email" />
	
	<input type="submit" id="submit" value="아이디 찾기" class="btn">
	
	<div style="border-top: 1px solid #A48654;">
		<span class="stick">혹시 비밀번호를 찾으시나요? │ </span>
		<a href="/login/findpw" class="link">비밀번호 찾기</a>
	</div>

</form>

</body>
</html>