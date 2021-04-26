<%@page import="util.FindPaging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%@page import="util.Paging"%>
<% FindPaging paging = (FindPaging) request.getAttribute("paging"); %>

<style type="text/css">

.pagination>.active>a, .pagination>.active>a:focus, .pagination>.active>a:hover, .pagination>.active>span, .pagination>.active>span:focus, .pagination>.active>span:hover {

	background-color : #EBC680;
	border-color : #ccc;
	z-index: 0;
	/* FFC091 */
}

.pagination>li>a:focus, .pagination>li>a:hover, .pagination>li>span:focus, .pagination>li>span:hover, .pagination>li>a {

	color: #000;
	/* EA9A56 */

}

</style>

<div class="text-center">
	<ul class="pagination">
		
		<!-- 현재페이지가 1이 아닐때만 왼쪽이동 표시 -->
		<% if(paging.getCurPage() != 1 ) { %>
		<li><a href="<%=request.getContextPath() %>?curPage=<%=paging.getCurPage() - 1%>">&lt;</a></li>
		<% } %>
	    
	    <% for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++) { %>
			<% if(i == paging.getCurPage()) { %>
				<li class="active"><a href="<%=request.getContextPath() %>?curPage=<%=i%>"><%=i %></a></li>
			<% } else { %>
				<li><a href="<%=request.getContextPath() %>?curPage=<%=i%>"><%=i %></a></li>
			<% } %>
		<% } %>
		
		<!-- 현재페이지가 마지막 페이지가 아닐때만 오른쪽이동 표시 -->
		<% if(paging.getCurPage() != paging.getTotalPage()) { %>
		<li><a href="<%=request.getContextPath() %>?curPage=<%=paging.getCurPage() + 1 %>">&gt;</a></li>
		<% } %>
	
	
	</ul>
</div>