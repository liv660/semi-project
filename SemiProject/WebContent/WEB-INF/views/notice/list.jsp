<%@page import="java.util.Map"%>
<%@page import="dto.Notice"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
    
<% List<Notice> list = (List) request.getAttribute("list"); %>

<% Map<String, Integer> map = (Map) request.getAttribute("map"); %>

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

/* TAB */
ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}

.tab-content{
	display: none;
	padding: 15px;
	background: #fffafa;
	border : 1px solid rgb(255, 206, 86);
}

ul.tabs li{
	background: none;
	color: #000;
	display: inline-block;
	padding: 8px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: rgba(255, 206, 86, 0.3);
	color: #000;
	border-radius : 25% 25% 0 0; 
	border : 1px solid rgb(255, 206, 86);
	border-bottom : none;
}

.tab-content.current{display: inherit;}


/* TAB-1 */
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
.searchbox {float : right; margin-bottom : 10px; margin-top : 10px;}

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


/* TAB-2 */
#wrapChart {
	width:600px;
	margin : 80px auto;
	text-align: center;
}

#wrapChart h3 {
	margin-bottom : 50px;
}



/* TAB-3 */
#imgwrapbox #imgbox1, #imgwrapbox #imgbox2, #imgwrapbox #imgbox3 {
	display : inline-block;
	text-align: center;
}

.container #tab-3 {
	text-align : center;
}

#imgwrapbox .img {
	border : 1px solid #000;
	border-radius : 24px;
}

#imgwrapbox .stopbtn {
	border : 1px solid orange;
	margin-top : 20px;
	margin-bottom : 50px;
	padding : 5px 15px;
	border-radius : 10px;
	background : #f7d794;	
}

#imgwrapbox [id*="imgbox"] {
	margin : 20px;
}

#tab-3 #result, #tab-3 #couponNo {
	border : none;
	text-align: center;
	margin-bottom : 20px;
	background : #fffafa;
}

#tab-3 #result:focus, #tab-3 #couponNo:focus, #imgwrapbox .stopbtn:focus {
	outline : none;
}

#tab-3 .startbtn {
  background-color: #c47135;
  border: none;
  color: #ffffff;
  cursor: pointer;
  display: inline-block;
  font-family: 'BenchNine', Arial, sans-serif;
  font-size: 1em;
  font-size: 22px;
  line-height: 1em;
  margin: 15px 40px;
  outline: none;
  padding: 12px 40px 10px;
  position: relative;
  text-transform: uppercase;
  font-weight: 700;
}
#tab-3 .startbtn:before, #tab-3 .startbtn:after {
  border-color: transparent;
  -webkit-transition: all 0.25s;
  transition: all 0.25s;
  border-style: solid;
  border-width: 0;
  content: "";
  height: 24px;
  position: absolute;
  width: 24px;
}
#tab-3 .startbtn:before {
  border-color: #c47135;
  border-right-width: 2px;
  border-top-width: 2px;
  right: -5px;
  top: -5px;
}
#tab-3 .startbtn:after {
  border-bottom-width: 2px;
  border-color: #c47135;
  border-left-width: 2px;
  bottom: -5px;
  left: -5px;
}
#tab-3 .startbtn:hover {
  background-color: #c47135;
}
#tab-3 .startbtn:hover:before, #tab-3 .startbtn:hover:after{
  height: 100%;
  width: 100%;
}

</style>


<div class="container">

<h1>Notice</h1>

	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">Notice</li>
		<li class="tab-link" data-tab="tab-2">Statistic</li>
		<li class="tab-link" data-tab="tab-3">Event</li>
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
				<td><img src="/resources/image/check.jpg" style="width:20px; height:20px;"></td>
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

	<div id="tab-3" class="tab-content">
		<div id="imgwrapbox">

		<div id="imgbox1">
		<img src="/resources/image/dog2.jpg" class="img" name="first" style="width:200px; height:200px;"> <br>
		<input type="button" value="stop" id="stop1" name="firstb" class="stopbtn" onClick='end(1);'>
		</div>
		
		<div id="imgbox2">
		<img src="/resources/image/cat2.jpg" class="img" name="second" style="width:200px; height:200px;"> <br>
		<input type="button" value="stop" id="stop2" name="secondb" class="stopbtn" onClick='end(2);'>
		</div>
		
		<div id="imgbox3">
		<img src="/resources/image/cat3.jpg" class="img" name="third" style="width:200px; height:200px;"> <br>
		<input type="button" value="stop" id="stop3" name="thirdb" class="stopbtn" onClick='end(3);'>
		</div>
		
		</div>
		
		<button type="button" class="startbtn" onClick='userCoupon();'>START</button> <br><br><br>
		
		<input type="text" size=55 name="result" id="result" value="START버튼을 눌러주세요" readonly="readonly"><br>
		<input type="text" size=55 id='couponNo' readonly="readonly" />
		
		
		<div ></div>
		
		<input type="hidden" id="firstPart" value=""/>
		
	</div>
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
                'rgba(0,0,0,0.2)'
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
	
	
function userCoupon() {
	
	if(<%=session.getAttribute("userno")%> == null) {

		alert('로그인 후 참여가 가능합니다.')
		
	} else {
		$.ajax({
			type:'get'
			, url: '/coupon/lookup'
			, data: {'userno' : <%=session.getAttribute("userno")%>}
			, dataType: 'json'
			, success : function(data) {
	
				var jsontext = JSON.stringify(data);
				var coupon = JSON.parse(jsontext);
				
				$('#firstPart').val(coupon.firstPart)
				
				if(coupon.gameSuccess == 'Y') {
					alert('이미 쿠폰을 받으셨습니다.')
				}else if (coupon.dateCompare == 1) {
					alert('하루에 한번만 참여 가능합니다.')
				}else if(coupon.firstPart == 2 || coupon.dateCompare == 2) {
					rullet()
				}
				
			}
			
		})
	
	}
	 
}



game = false
box1 = true
box2 = true
box3 = true
num = Math.floor(Math.random() * 10)

IMG = new Array();

IMG[0] = new Image(); IMG[0].src = "/resources/image/cat1.jpg";
IMG[1] = new Image(); IMG[1].src = "/resources/image/dog1.jpg";
IMG[2] = new Image(); IMG[2].src = "/resources/image/cat2.jpg";
IMG[3] = new Image(); IMG[3].src = "/resources/image/dog2.jpg";
IMG[4] = new Image(); IMG[4].src = "/resources/image/cat3.jpg";
IMG[5] = new Image(); IMG[5].src = "/resources/image/dog3.jpg";
IMG[6] = new Image(); IMG[6].src = "/resources/image/dog4.jpg";
IMG[7] = new Image(); IMG[7].src = "/resources/image/dog5.jpg";
IMG[8] = new Image(); IMG[8].src = "/resources/image/dog6.jpg";
IMG[9] = new Image(); IMG[9].src = "/resources/image/dog7.jpg";

//쿠폰번호 생성
function randomCode() {
  	let str = '';
  	for (let i = 0; i < 16; i++) {
    	str += Math.floor(Math.random() * 10)
  	}
	return str
}

//룰렛 돌리기
function rullet(){
       
   game = true;   
	
   if(num == 10) num = 0
   if(box1)document.images["first"].src = IMG[num % 10].src
   if(box2)document.images["second"].src = IMG[(num+3) % 10].src
   if(box3)document.images["third"].src = IMG[(num+6) % 10].src
   
	num += 1
	tid = setTimeout("rullet()",60)  
}

//스탑
function end(variable){
	if(game == true){
			if(variable == 1)box1 = false
			if(variable == 2)box2 = false
			if(variable == 3)box3 = false
			
			$('#stop'+variable).css('background','#e58e26');
	  }
	if((box1 == false) && (box2 == false) && (box3 == false)){
			clearTimeout(tid)
			resultgame()
	  }
}


//결과
function resultgame(){
	
	var discount;
	
	if((document.images["first"].src == document.images["second"].src) && (document.images["second"].src == document.images["third"].src) && (document.images["third"].src == document.images["first"].src)){ 
		$("#result").val("축하합니다 30% 할인쿠폰 당첨");
		$("#couponNo").val(randomCode());
		discount = 30;
	}
	else if((document.images["first"].src == document.images["second"].src) || (document.images["second"].src == document.images["third"].src) || (document.images["third"].src == document.images["first"].src)) {
		$("#result").val("축하합니다 20% 할인쿠폰 당첨");
		$("#couponNo").val(randomCode());
		discount = 20;
	} else {
		$("#result").val("꽝!");
	}
	
	$.ajax({
		type:'get'
		, url:'couponSave'
		, data: {'userno' : <%=session.getAttribute("userno")%>
				, 'firstPart' : $('#firstPart').val()
				, 'discount' : discount
				, 'couponNo' : $('#couponNo').val()}
		, url : '/coupon/save'
	})
}
	
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>



