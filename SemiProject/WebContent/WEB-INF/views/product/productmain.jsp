<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@page import="dto.Product" %>
<%@page import="dto.ProductImg" %>
<%@page import="java.util.List"%>

<% List<Product> product = (List)request.getAttribute("product");%>
<% List<Product> product1 = (List)request.getAttribute("product1");%>
<% List<Product> product2 = (List)request.getAttribute("product2");%>
<% List<Product> product3 = (List)request.getAttribute("product3");%>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<!-- jQuery 2.2.4 -->
<script type="text/javascript" 
src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->


<script type="text/javascript">
	
	$(function(){
		
		
		// 이전 버튼을 해결하기 위하여 이미지 한장을 빼놓음
		$("#film").prepend( $(".scene:last") );
		$("#film").css({"marginLeft":"-100%"});
		

		/* 다음 버튼 누르기 */
		$(".nextBtn").click(function(){
			$("#film:not(:animated)").stop().animate({"marginLeft":"-=100%"},500,"swing",function(){
				$("#film").append( $(".scene:first") );
				$("#film").css({"marginLeft":"-100%"});
			});
		});


		/* 이전 버튼 누르기 */
		/* 
			문제점: 빈칸이 나옴
			
			다음 버튼과 다른점?
				다음버튼의 경우 이미지가 줄지어있음
				이전버튼의 경우 처음에 빈공간이 있음
		*/
		
		$(".prevBtn").click(function(){
			$("#film:not(:animated)").stop().animate({"marginLeft":"+=100%"},500,"swing",function(){
				$("#film").prepend( $(".scene:last") );
				$("#film").css({"marginLeft":"-100%"});
			});
		});
	
	
	});


</script>

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

</script>

	
<style>
		*{margin:0; padding:0;}
		li{list-style:none;}
		a:link, a:visited{text-decoration:none; color:#777;}
		
		
		#container{width:100%; height:1250px;}
		
		#screen{max-width:1200px; width:100%; height:400px; border:1px solid #ccc; margin:0 auto; position:relative; 
			overflow:hidden;
		}
		#film{width:400%;}
		/* 부모요소가 크던 작던 100%로 인식함*/
		.scene{float:left; width:25%;}
		.scene p{ width:100%; height:400px; }
		.scene p img{width:100%; height:100%;}
	
		#film:after{ content:""; display:block; clear:both; }

		#btn p{ position:absolute; top:60%; width:50px; height:100px; margin-top:-50px;}
		#btn p span{ width:100%; height:100%;}

		#btn .nextBtn{width:40px; height:60px; right:20px; text-align:right;}
		#btn .prevBtn{width:40px; height:60px; left:20px;}
		#btn .nextBtn img, #btn .prevBtn img{width:100%; height:100%;}
		
		
		hr{ width:880px; 
			margin:30px auto; 
			border:solid 10px #B2EBF4;
			border-radius:10px 10px 10px 10px;
		}
		

		#container #sponsor{width:100%; height:40px; margin:0;}
		#container #sponsor ul{width:800px; height:100%; margin:0 auto;}
		#container #sponsor li{float:right; list-style:disc;}
		
		#container #product_box{width:100%; overflow:hidden;}
		#container #product{ width:900px; margin:0 auto;}
		#container #pro_cate{width:850px; /*padding-left:50px;*/ margin-bottom:30px; height:26px;}
		#container #pro_cate li{float:left; text-align:center;} 
		#container #pro_cate li h3, h4{margin:0; line-height:26px;}
		#container #pro_cate .tab-link current{width:120px;}
		#container #pro_cate .tab-link{width:100px;}
		
		
		#container #tab-1{width:100%; height:720px; border:1px solid #ccc; margin:0 auto;}
		
		#container #tab-1 ul{width:100%; height:100%; }
		#container #tab-1 ul li{width:200px; height:200px; float:left; margin:20px 0 0 20px;}
		#container #tab-1 li img{width:100%; height:100%;}
		
.img_box {
  list-style:none;
  padding:0;
}
.img_box li {
  float: left;
  padding: 0;
  margin: 10px;
  overflow: hidden;
  position: relative;
}
.img_box img {
  margin:0;
  padding:0;
  float:left;
  z-index:1;
  width:200px;
  height:200px;
} 
.img_box .caption {
  position: absolute;
  top:200px;  /* 기준 위치보다 200px 아래로 */
  width:200px;
  height:200px;
  padding-top:20px;
  background:rgba(0,0,0,0.6);  /* 반투명한 검정 배경 */ 
  opacity:0;  /* 화면에 보이지 않게 */ 
  transition: all 0.6s ease-in-out;  /* 나타날 때 부드럽게 트랜지션 추가 */
  z-index:2;  /* 다른 요소보다 위에 있도록 */ 
}
.img_box li:hover .caption {
  opacity: 1;  /* 설명글이 화면에 보이게 */ 
  transform: translateY(-200px);  /* 설명글이 위로 200px 이동하게 */
}  
.img_box .caption h2, .img_box .caption p {
  color: #fff;
  text-align:center;
} 
 /* TAB */
ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}

.tab-content{
	display: none;
	padding: 5px;
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
#wrapChart1 {
	width:600px;
	margin : 80px auto;
	text-align: center;
}

#wrapChart2 {
	width:1000px;
	margin : 80px auto;
	text-align: center;
}

#wrapChart2chart {
	width: 600px;
}

#wrapChart2chart, #wrapChart2info {
	display : inline-block;
}

#wrapChart2info {
	position : absolute;
	top : 1000px;
	text-align: left;
}

#wrapChart1 h3, #wrapChart2 h3  {
	margin-bottom : 50px;
}

#wrapChart2info #infoColor1 {
	width:20px;
	height:20px;
	background : rgba(255, 99, 132, 0.2);
	border : 1px solid rgba(255, 99, 132, 1);
	display: inline-block;
}

#wrapChart2info #infoColor2 {
	width:20px;
	height:20px;
	background : rgba(54, 162, 235, 0.2);
	border : 1px solid rgba(54, 162, 235, 1);
	display: inline-block;
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

#imgwrapbox h2 {
	font-family: fantasy;
	letter-spacing: 5px;
	display : inline-block;
	padding : 10px 20px;
	margin-bottom : 50px;
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

#tab-3 #guide {
	text-align: left;
	width : 600px;
	margin : 0 auto;
	margin-top : 50px;
	line-height: 40px;
	
}
  </style>
<body>
	<div id="container">
		<div id="screen">
			<ul id="film">
				<li class="scene">
					<p><img src="../resources/se2/img/product_slider3.png" /></p>
				</li>
				<li class="scene">
					<p><img src="../resources/se2/img/product_slider2.png" /></p>
				</li>
				<li class="scene">
					<p><img src="../resources/se2/img/product_slider1.png" /></p>
				</li>
			</ul>
			<div id="btn">
				<p class="nextBtn"><img src="../resources/se2/img/next_shadow.png" alt="다음버튼" class="next"/></p>
				<p class="prevBtn"><img src="../resources/se2/img/prev_shadow.png" alt="이전버튼" class="prev"/></p>
			</div>
		</div>
			<div id="sponsor">
				<ul>
					<li>수익금액 일부는 후원금으로 사용됩니다.</li>
				</ul>
			</div>
		<div id="product_box">
			<div id="product">
				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">전체보기</li>
					<li class="tab-link" data-tab="tab-2">반려동물</li>
					<li class="tab-link" data-tab="tab-3">악세서리</li>
					<li class="tab-link" data-tab="tab-4">사료 및 간식</li>
				</ul>

				<div id="tab-1" class="tab-content current">
					<ul class="img_box">
					<% for( int i=0; i<product.size(); i++) { %>
<%-- 					<p><%=product.get(i).getCategoryId() %></p> --%>
						<li><a href="/product/detail?productId=<%=product.get(i).getProductId() %>" ><img src="<%=request.getContextPath() %>/uploadProd/<%=product.get(i).getStoredName() %>" alt="제품이미지1"/>
							<div class="caption">
								<h2><%=product.get(i).getProductName() %></h2>
								<p> 가격 : <%=product.get(i).getPrice() %> </p>
							</div>
						</a>
						</li>
					<% } %>
					</ul>
				</div>
				
				<div id="tab-2" class="tab-content" style="height: 720px;">
				
					<ul class="img_box">
					<% for( int i=0; i<product1.size(); i++) { %>
						<li><a href="/product/detail?productId=<%=product1.get(i).getProductId() %>" ><img src="<%=request.getContextPath() %>/uploadProd/<%=product1.get(i).getStoredName() %>" alt="제품이미지1"/>
							<div class="caption">
								<h2><%=product1.get(i).getProductName() %></h2>
								<p> 가격 : <%=product1.get(i).getPrice() %> </p>
							</div>
						</a>
						</li>
					<% } %>
					</ul>
				
				</div>
			
				<div id="tab-3" class="tab-content" style="height: 720px;">
									<ul class="img_box">
					<% for( int i=0; i<product2.size(); i++) { %>
						<li><a href="/product/detail?productId=<%=product2.get(i).getProductId() %>" ><img src="<%=request.getContextPath() %>/uploadProd/<%=product2.get(i).getStoredName() %>" alt="제품이미지1"/>
							<div class="caption">
								<h2><%=product2.get(i).getProductName() %></h2>
								<p> 가격 : <%=product2.get(i).getPrice() %> </p>
							</div>
						</a>
						</li>
					<% } %>
					</ul>
				</div>

				<div id="tab-4" class="tab-content" style="height: 720px;">
									<ul class="img_box">
					<% for( int i=0; i<product3.size(); i++) { %>
						<li><a href="/product/detail?productId=<%=product3.get(i).getProductId() %>" ><img src="<%=request.getContextPath() %>/uploadProd/<%=product3.get(i).getStoredName() %>" alt="제품이미지1"/>
							<div class="caption">
								<h2><%=product3.get(i).getProductName() %></h2>
								<p> 가격 : <%=product3.get(i).getPrice() %> </p>
							</div>
						</a>
						</li>
					<% } %>
					</ul>
				</div>
								
		</div>
	</div>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>