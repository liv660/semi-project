<%@page import="dto.ReviewBoard"%>
<%@page import="dto.ReviewDetailView"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% ReviewDetailView view = (ReviewDetailView) request.getAttribute("reviewTextView"); %>
<%-- <% ReviewBoard reviewNo = (ReviewBoard) request.getAttribute("reviewNo"); %> --%>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style type="text/css">

#content {
/* 	width: 100%; */
	width: 98%;
}

.table {
	width: 1100px;
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
	<td>작성자</td><td colspan="2"><%=view.getNick() %></td>
	<td>작성일</td><td colspan="2"><%=view.getCreateDate() %></td>
	<td><button type="button" id="btnUpdate" class="btn">수정</button></td>
	<td><button type="button" id="btnDelete" class="btn">삭제</button></td>
<tr>
	<!-- 이미지 띄워줄 자리 -->
	<td colspan="2"><image></td>
	<td colspan="2"><image></td>
	<td colspan="2"><image></td>
	<td colspan="2"><image></td>
</tr>

<tr> <!-- 본문 -->
	<td colspan="8"><textarea 
			style="width: 97%; height: 300px;" name="content" id="content"><%=view.getContent() %></textarea></td>
</tr>

<tr>
	<td colspan="8" style="text-align: right; padding-right: 15px;"><button type="button" id="btnList" class="btn">목록으로</button></td>
</tr>

</table>

</div>

</body>
</html>