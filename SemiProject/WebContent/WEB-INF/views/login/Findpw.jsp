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

<form action="/login/findpw" method="post" class="box">

	<h1>비밀번호 찾기</h1>
	
	<label for="id">아이디</label>
	<input type="text" id="id" name="id" />
	
	<label for="name">이름</label>
	<input type="text" id="name" name="name" />
	
	<label for="email">이메일</label>
	<input type="text" id="email" name="email" />
	
	<input type="submit" id="submit" value="비밀번호 찾기"/>
	
	<div style="border-top: 1px solid #A48654;">
		<span class="stick">혹시 아이디를 찾으시나요? │ </span>
		<a href="/login/findid" class="link">아이디 찾기</a>
	</div>

</form>

</body>
</html>