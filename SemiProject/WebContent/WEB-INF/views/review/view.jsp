<%@page import="dto.ReviewImgFile"%>
<%@page import="java.util.List"%>
<%@page import="dto.ReviewBoard"%>
<%@page import="dto.ReviewDetailView"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% ReviewDetailView view = (ReviewDetailView) request.getAttribute("reviewTextView"); %>
<% List<ReviewImgFile> imgs = (List<ReviewImgFile>) request.getAttribute("reviewImgs"); %>
<% ReviewBoard reviewNo = (ReviewBoard) request.getAttribute("reviewNo"); %>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<% String nick = (String) session.getAttribute("nick"); %>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#btnList").click(function() {
		location.href="/review/list";
	});
	
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/review/update?reviewNo=<%=reviewNo.getReviewNo() %>")
	});
	
	$("#btnDelete").click(function() {
		if(confirm("게시글을 삭제하시겠습니까?")) {
			$(location).attr("href", "/review/delete?reviewNo=<%=reviewNo.getReviewNo() %>")
		}
	});
	
});
</script>


<style type="text/css">

#content {
/* 	width: 100%; */
	width: 98%;
}

.table {
	width: 1100px;
}

#imgs {
	width: 240px;
	height: 200px;
	float: left;
	margin: 5px;
}

</style>


<div class="container">

<h3 style="text-align: center;">게시글 상세보기</h3>
<hr>

<table class="table table-bordered">

<tr>
	<td>분류</td><td colspan="3"><%=view.getReviewSortDetail() %></td>
</tr>

<tr>
	<td>제목</td><td colspan="6"><%=view.getTitle() %></td>
</tr>

<tr>
	<td>작성자</td><td colspan="2"><%=view.getNick() %></td>
	<td>작성일</td><td colspan="2"><%=view.getCreateDate() %></td>
	<% if(nick.equals(view.getNick()))  {%>
	<td><button type="button" id="btnUpdate" class="btn">수정</button></td>
	<td><button type="button" id="btnDelete" class="btn">삭제</button></td>
	<% } %>
</tr>
	
<% int i = imgs.size(); %>	
	<% if(i <= 0) { %>
		<tr>
			<!-- 이미지 띄워줄 자리 -->
			<td colspan="2"><img src=".." alt="img1" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img2" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img3" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img4" id="imgs"></td>
		</tr>
	<% } else if(i < 2 && i > 0) { %>
		<tr>
			<!-- 이미지 띄워줄 자리 -->
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(0).getStoredImg() %>" alt="img1" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img2" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img3" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img4" id="imgs"></td>
		</tr>
	<% } else if(i < 3 && i > 1)  {%>	
		<tr>
			<!-- 이미지 띄워줄 자리 -->
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(0).getStoredImg() %>" alt="img1" id="imgs" /></td>
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(1).getStoredImg() %>" alt="img2" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img3" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img4" id="imgs"></td>
		</tr>
	<% } else if(i < 4 && i > 2) { %>
		<tr>
			<!-- 이미지 띄워줄 자리 -->
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(0).getStoredImg() %>" alt="img1" id="imgs" /></td>
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(1).getStoredImg() %>" alt="img2" id="imgs" /></td>
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(2).getStoredImg() %>" alt="img3" id="imgs" /></td>
			<td colspan="2"><img src=".." alt="img4" id="imgs"></td>
		</tr>
	<% } else if(i < 5 && i > 3) { %>
		<tr>
			<!-- 이미지 띄워줄 자리 -->
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(0).getStoredImg() %>" alt="img1" id="imgs" /></td>
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(1).getStoredImg() %>" alt="img2" id="imgs" /></td>
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(2).getStoredImg() %>" alt="img3" id="imgs" /></td>
			<td colspan="2"><img src="/reviewImgFile/<%=imgs.get(3).getStoredImg() %>" alt="img4" id="imgs"></td>
		</tr>
	<% } %>
		
		
<tr> <!-- 본문 -->
	<td colspan="8">
<%-- 		<textarea style="width: 97%; height: 300px;" name="content" id="content"><%=view.getContent() %></textarea> --%>
		<div style="width: 1100px; height: 300px; border: 1px solid; margin: 10px 0 10px 0;">
		<p><%=view.getContent() %></p>
		</div>
	</td>
</tr>

<tr>
	<td colspan="8" style="text-align: right; padding-right: 15px;"><button type="button" id="btnList" class="btn">목록으로</button></td>
</tr>

</table>

</div>

</body>
</html>