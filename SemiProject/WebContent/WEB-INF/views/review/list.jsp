<%@page import="dto.ReviewUserJoin"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% List<ReviewUserJoin> reviewList = (List) request.getAttribute("reviewList"); %>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>

h2 {
	text-align: center;
}

.pagination > .active > a {
	background-color: #EBC680;
	border-color: #EBC680;
} 

.bigbox {
	width: 98%;
	height: 7px;
	margin-top: 30px;
}

#sortbtn {
	float: left;
}

.bigbox #sortbtn input {
	background-color: green;
	border-style: none;
	border-radius: 10px;
	color: #eee;
	margin-left: 10px;
	padding: 1px 10px;
}

#btnBox {
	float: right;
}

#write {
	background-color: green;
	color: white;
	border-radius: 8px;
	padding: 3px 15px;
	border: 0;
	outline: 0;
}


</style>

<script type="text/javascript">
$(document).ready(function() {
	
	<%	if(session.getAttribute("login") == null || !(boolean)session.getAttribute("login")) { %>
	<!-- 비로그인상태 -->
	
	$("#write").click(function() {
		alert("로그인 후 이용하세요")
		location.href="/login/login";
	});
	
	<%	} else if( (boolean)session.getAttribute("login") ) { %>
	<!-- 로그인상태 -->
	
	$("#write").click(function() {
		location.href="/review/write";
	});
	
	<%	} %>
});


function search() {
// 	console.log($('#review').val());

	location.href="/review/list?sort=" + $('#sort').val();
}

</script>

<div class="container">

<h2 style="color: #EA9A56;">후기 게시판</h2>


<div class="bigbox">

	<div id="sortbtn">
		<select id="sort">
			<option value="">후기</option>
			<option value="1">스토어 후기</option>
			<option value="2">유기동물 찾아준 후기</option>
			<option value="3">반려동물 찾은 후기</option>
		</select>
		<input type="button" id="reviewsearch" onclick="search();" value="조회" />
	</div>
	
	<div id="btnBox">
		<button id="write">글쓰기</button>
	</div>
	
</div>


<br><br>


<table class="table table-hover">
<tr style="background-color: #EBC680;">
	<th style="width: 8%">글 번호</th>
	<th style="width: 22%">분류</th>
	<th style="width: 35%">제목</th>
	<th style="width: 15%">작성자</th>
	<th style="width: 13%">작성일</th>
	<th style="width: 7%">조회수</th>
</tr>
<% for(int i=0; i<reviewList.size(); i++) { %>
<tr>
	<td><%=reviewList.get(i).getReviewNo() %></td>
	<td><%=reviewList.get(i).getReviewSortDetail() %></td>
	<td>
		<a href="/review/view?reviewNo=<%=reviewList.get(i).getReviewNo() %>">
		<%=reviewList.get(i).getTitle() %>
		</a>
	</td>
	<td><%=reviewList.get(i).getUserId() %></td>
	<td><%=reviewList.get(i).getCreateDate() %></td>
	<td><%=reviewList.get(i).getViews() %></td>
</tr>
<% } %>
</table>

</div>

<%@ include file="/WEB-INF/views/layout/Reviewpaging.jsp" %>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
