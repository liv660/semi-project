<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#wrapper {
	width: 230px;
	margin: 0 auto;
	text-align: center;
}

#mainbtn {
	width: 10em;
	height: 2em;
	font-size: 17px;
	background-color: #F5F6E7;
	border-radius: 10px;
	border: 0;
}

#mainbtn:hover {
	color: blue;
}

.blue {

	color: #0CBCF2;
}

hr {
border-color: red;
}

</style>

<script type="text/javascript">
function gomain() {
	
	self.close();
	opener.location.href = "/login/logout";
	
}

</script>
</head>
<body>
<div id="wrapper">
<br><br>


<h3>회원탈퇴가</h3>
<h3 class="blue">완료되었습니다</h3>
<hr>
<h3>이용해주셔서</h3>
<h3 class="blue">감사합니다</h3>
<hr>
<h3>다음에 오신다면</h3>
<h3>더 좋은</h3>
<h3 class="blue">서비스로 보답하겠습니다</h3>

<button onclick="gomain();" id="mainbtn">메인페이지 이동</button>




</div>
</body>
</html>