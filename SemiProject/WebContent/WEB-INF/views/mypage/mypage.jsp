<%@page import="dto.UserImg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% UserImg userimg = (UserImg) request.getAttribute("userimg"); %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style type="text/css">
.box {
    width: 120px;
    height: 120px; 
    border-radius: 70%;
    overflow: hidden;

}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

#wrapper {
	width: 1200px;
	margin: 0 auto;
}
#content
{
	text-align: center;
	

}

.right {
	float: right;
	width: 80%;
}


.abs_img {
	position: absolute;
	margin: 20px;
	margin-left: 30px;

}
.abs_info {
	position: absolute;
	left: 27%;
	bottom: 35%;
}

.rel_pro {
	background: #F5F9F8;
	width: 700px;
	margin: 0 auto;
	height: 170px;
	position: relative;
}

.rel_bor {
	position: relative;
	width: 200px;
	height: 30px;
	top: 110%;
	left: 15px;
	background: #FFC091;

}
.rel_ord {
	position: relative;
	width: 200px;
	height: 30px;
	top: 85%;
	left: 15px;
	background: #FFC091;

}

.abs_botx {
	text-align: center;
	font-size: 25px;
	
	
}
.rel_borad {
	position: relative;
	width: 98%;
	height: 240px;
	top: 117%;
	left: 15px;

}

.rel_order {
	position: relative;
	width: 98%;
	height: 240px;
	top: 93%;
	left: 15px;
	border: 1px solid #333;

}

.table_di {
	font-size: 19px;

}
th{
	text-align: center;
}

.abs_puls {
position: absolute;
left: 328%;
top: 10%;
height: 30px;
width: 30px;
font-size: 30px;

}
</style>

<body>

<div id="wrapper">
<%@ include file="/WEB-INF/views/mypage/mypagemenu.jsp" %>



<div id="content" class="right">
<h1 style="text-align: center;">마이 페이지</h1>
<hr style="border-top: 5px solid #eee;">
<div class="rel_pro">

<div class="abs_img">
		<div id=myprofil>
		<div class="box" style="background: #BDBDBD;">
		<% if(  !"basic.png".equals(userimg.getStroedName()) ) {%>
    	<img class="profile" src="/userimgup/<%=userimg.getStroedName() %>">
    	<% }  else {%>
    	<img class="profile" src="/resources/image/basic.png">
 		<% } %>
		</div>
		</div>
</div>

<div class="abs_info">
		<div style="font-size: 25px;"><%=session.getAttribute("nick") %> 님</div>
		<div><button class="btn btn-default btn-lg btn-block" onclick="location.href= '/mypage/profile';">프로필수정</button></div>
</div>

<div class="rel_bor">
<div class="abs_botx">내가 작성한 글</div>
<div class="abs_puls">+</div>
</div>

<div class="rel_borad">
<table class="table table_di">
	<tr>
		<th>글번호</th>
		<th>게시판 이름</th>
		<th>제목</th>
		<th>날짜</th>
	</tr>
	<tr>
		<td>123</td>
		<td>후기 게시판</td>
		<td>덕분에 찾았습니다</td>
		<td>2021/03/05</td>
	</tr>
	<tr>
		<td>51</td>
		<td>반려동물 찾기 게시판</td>
		<td>우리 이쁜 강아지 찾습니다</td>
		<td>2021/02/05</td>
	</tr>
	<tr>
		<td>6</td>
		<td>유기동물 발견 게시판 </td>
		<td>이렇게 이쁜 강아지 발견했어요</td>
		<td>2021/01/05</td>
	</tr>
</table>
</div>


<div class="rel_ord">
<div class="abs_botx">최근 주문 목록</div>
<div class="abs_puls">+</div>
</div>


<div class="rel_order">




</div>



</div>


</div>






<!-- <div id="content" class="right"> end  -->
</div>

</body>
</html>