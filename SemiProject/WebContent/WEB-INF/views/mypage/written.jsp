<%@page import="dto.MyBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<MyBoard> mbl = (List) request.getAttribute("myBoardList"); %>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>


<style type="text/css">
#wrapper {
	width: 1200px;
	margin: 0 auto;
}

#content
{
	height:680px;

}

.right {
	float: right;
	width: 80%;
}

.rel_h {
	position: relative;
    top: 75px;
    margin-left: 60px;
}
.rel_btn {
	position: relative;
    width: 250px;
    margin-left: 680px;
    top: 100px;
}
.rel_se {
	position: relative;
    top: 105px;
    left: 75px;
    background: #F5F9F8;
    width: 160px;
    text-align: center;
}

.rel_t {
	position: relative;
    width: 780px;
    left: 75px;
    top: 110px;

}
.rel_page {
	position: relative;
    width: 500px;
    top: 100px;
    margin: 0 auto;
}
.t_design {
	font-size: 17px;
	text-align: center;
	line-height: 10px;
}
.t_design th {
	text-align: center;

}

.btn_del {
	border: 1px solid #ccc;
    background-color: white;
    color: #0CBCF2;
    border-radius: 10px;
    width: 85px;
    font-size: 17px;
	height: 33px;

}

.btn_del:hover {
	
	color:red;
}

.btn_all {
	width: 95px;
	height: 33px;
	font-size: 17px;
	background-color: #0CBCF2;
	border-radius: 10px;
	border: 0;
	color: white;

}

.btn_all:hover {
	color: red;

</style>

<script type="text/javascript">
$(document).ready (function () {
	
	
});

function allchecked() {

	// 체크박스의 이름과 prop 메서드를 사용하여 전체 선택
	$('.checkList').prop('checked', true);

}

function writtenDelete() {
	var cnt = $("input[class='checkList']:checked").length;
	var arr = new Array();
	$("input[class='checkList']:checked").each(function() {
		arr.push($(this).attr('id'));
	});
	if(cnt == 0){
		alert("선택된 글이 없습니다.");
	} else {
		
		$.ajax({
			type: 'post',
			url: '/written/delete',
			data: "no_div=" + arr + "&CNT=" + cnt,
			success : function( ) {
				
			location.href="/mypage/written";

			},
			error: function(){alert("서버통신 오류");}
		}); 
	}
}
</script>

<div id="wrapper">
<%@ include file="/WEB-INF/views/mypage/mypagemenu.jsp" %>

<div id="content" class="right">
<div class="rel_h">
<h1>내가 작성한 글</h1>
</div>


<div class="rel_btn">
<button type="button" class="btn_all" onclick="allchecked()">전체선택</button>
<button type="button" class="btn_del" onclick="writtenDelete()">선택삭제</button>
</div>

<div class="rel_se">
<span style="font-size: 23px;">내가 작성한 글</span>
</div>

<div class="rel_t">
<table class="table table_di t_design">
<tr>
	<th style="width: 10%;">글번호</th>
	<th style="width: 16%;">게시판 이름</th>
	<th style="width: 50%;">제목</th>
	<th>날짜</th>
	<th>선택</th>
</tr>
<% if (mbl.size() > 0 ) { %>
<% for(int i=0; i<mbl.size(); i++) { %>
<tr>
	<td><%=mbl.get(i).getBorad_no() %></td>
	<% if(mbl.get(i).getBoard_div().equals("찾기 게시판")) { %>
	<td><a href="/find/list" style="font-size: 14px">
		<%=mbl.get(i).getBoard_div() %>
		</a>
	</td>
	<% } else if (mbl.get(i).getBoard_div().equals("발견 게시판")) {%>
	<td><a href="/discover/list" style="font-size: 14px">
		<%=mbl.get(i).getBoard_div() %>
		</a>
	</td>
	<% } else if (mbl.get(i).getBoard_div().equals("후기 게시판")) {%>
	<td><a href="/review/list" style="font-size: 14px">
		<%=mbl.get(i).getBoard_div() %>
		</a>
	</td>
	<% } %>
	
	<% if (mbl.get(i).getBoard_div().equals("찾기 게시판")) { %>
	<td><a href="find/read?FindNo=<%=mbl.get(i).getBorad_no() %>" style="font-size: 14px">
		<%=mbl.get(i).getTitle() %>
		</a>
	</td>
	<% } else if (mbl.get(i).getBoard_div().equals("발견 게시판")) { %>
	<td><a href="discover/read?DiscoverNo=<%=mbl.get(i).getBorad_no()%>" style="font-size: 14px">
		<%=mbl.get(i).getTitle() %>
		</a>
	</td>
	<% } else if (mbl.get(i).getBoard_div().equals("후기 게시판")) { %>
	<td><a href="/review/view?reviewNo=<%=mbl.get(i).getBorad_no() %>" style="font-size: 17px">
		<%=mbl.get(i).getTitle() %>
		</a>
	</td>
	<% } %>
	<td><%=mbl.get(i).getCreate_date() %></td>
	<td><input type="checkbox" class="checkList" id="<%=mbl.get(i).getBorad_no() %>_<%=mbl.get(i).getBoard_div() %>"/></td>
</tr>
<% } %>
<% } %>
</table>
</div>

<div class="rel_page">
<%@ include file="/WEB-INF/views/layout/myPaging.jsp" %>
</div>

</div>


</div>

