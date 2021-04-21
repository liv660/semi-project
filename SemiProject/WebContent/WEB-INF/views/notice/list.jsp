<%@page import="java.util.Map"%>
<%@page import="dto.Notice"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
    
<% List<Notice> list = (List) request.getAttribute("list"); %>

<% Map<String, Integer> map = (Map) request.getAttribute("map"); %>

<% String test = (String) request.getAttribute("hihi"); %>

<script type="text/javascript"
src = "http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})

})

function search() {
	
	location.href="/notice/list?title=" + $('#searchtitle').val() + "&search=" + $('#searchBox').val();
	
}


</script>


<style type="text/css">

* {
	font-family : sans-serif;
}

.container h1 {
	color : #EA9A56;
	text-transform: uppercase;
	font-weight: 500px;
	font-family: sans-serif;
	margin-bottom : 30px;
}
.noticeno {width: 100px; text-align : center;}
.important {width: 50px;}
.title {width:410px;}
.writer {width : 120px; text-align : center;}
.date {width:150px; text-align : center;}
.views {width:120px; text-align : center;}
.searchbox {float : right; margin-bottom : 10px;}


ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	color: #000;
	display: inline-block;
	padding: 8px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #FFC091;
	color: #fff;
	border-radius : 25% 25% 0 0; 
	border-bottom : none;
}

.tab-content{
	display: none;
	padding: 15px;
	background: #fffafa;
}

.tab-content.current{display: inherit;}



#wrapChart {
	width:600px;
	margin : 80px auto;
	text-align: center;
}



#searchbtn, #writebtn {
	border : 1px solid #A48654;
	background: #fff;
	border-radius : 24px;
	transition : 0.25s;
	padding : 2px 5px;
	color : #000;
}
#searchbtn:hover, #writebtn:hover {background : #A48654; color : #000;}
#writebtn {padding : 5px 8px; float: right;}
#searchBox {border : 2px solid #A48654; border-radius : 24px;}
#searchBox:focus {outline : none;}
#searchtitle {border : 1px solid #A48654; border-radius : 24px;}

.container .titleContent { color : #000;}
.container .titleContent:hover { color : #EA9A56; text-decoration :none; font-size: medium; transition: 0.5s;}

</style>


<div class="container">

<h1>Notice</h1>

	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">notice</li>
		<li class="tab-link" data-tab="tab-2">chart</li>
		<li class="tab-link" data-tab="tab-3">tab-3</li>
	</ul>
	<div id="tab-1" class="tab-content current">
		<div class="searchbox">
			<select id="searchtitle">
				<option value="writer">작성자</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" id="searchBox"/>
			<input type="button" id="searchbtn" onclick="search();" value="조회" />
		</div>
	
		<table class="table">
			<tr>
				<th class="noticeno">글번호</th>
				<th class="important"> </th>
				<th class="title">제목</th>
				<th class="writer">작성자</th>
				<th class="date">작성일</th>
				<th class="views">조회수</th>
			</tr>
			
			<% for(int i=0; i<list.size(); i++) { %>
			<tr>
				<td class=noticeno><%=list.get(i).getNoticeNo() %></td>
				<%if (list.get(i).getNoticeImp() == null) { %>
				<td> </td>
				<% } else {%>
				<td><img src="/resources/image/dot.png"></td>
				<% } %>
				<td><a href="/notice/view?noticeno=<%=list.get(i).getNoticeNo() %>" class="titleContent"><%=list.get(i).getTitle() %>
				<% if(list.get(i).getCommentCnt() != 0) { %>
				 (<%=list.get(i).getCommentCnt() %>)
				<% } %>
				 </a></td>
				<td class="writer"><%=list.get(i).getManagerId() %></td>
				<td class="date"><%=list.get(i).getCreateDate() %></td>
				<td class="views"><%=list.get(i).getViews() %> </td>
			</tr>
			<% } %>
		</table>
		
		<a href="/notice/write"><input type="button" value="글쓰기" id="writebtn"/></a>
		<br>
		<%@ include file="/WEB-INF/views/layout/NoticePaging.jsp" %>
	
	</div>
	<div id="tab-2" class="tab-content">
		<div id="wrapChart">
			<h3>요일별 유기동물 발견 글 수</h3>
			<canvas id="myChart"></canvas>
		</div>
		
	</div>

	<div id="tab-3" class="tab-content"></div>
</div>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.min.js"></script>
<script>
	var ctx = document.getElementById('myChart');
	var myChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: ['월', '화', '수', '목', '금', '토', '일'],
	        datasets: [{
	            data: [<%=map.get("mon")%>, <%=map.get("tue")%>, <%=map.get("wen")%>, <%=map.get("tur")%>
	            		, <%=map.get("fri")%>, <%=map.get("sat")%>, <%=map.get("sun")%>],
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
	                'rgba(0,0,0)'
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)',
	                'rgba(0,0,0)'
	            ], 
	            borderWidth: 1
	        }]
	    },
	    options: {
		    legend: {display: false} 
	
	    }
	});
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>



