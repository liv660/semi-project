<%@page import="dto.Product"%>
<%@page import="dto.Notice"%>
<%@page import="dto.ReviewUserJoin"%>
<%@page import="dto.DiscoverBoard"%>
<%@page import="dto.FindBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<script src="http://code.jquery.com/jquery-2.2.4.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/js/slider.js"></script>

<%List<FindBoard> findboard = (List) request.getAttribute("findboard"); %>
<%List<DiscoverBoard> discoverboard = (List) request.getAttribute("discoverboard"); %>
<%List<ReviewUserJoin> reviewboard = (List) request.getAttribute("reviewboard"); %>
<%List<Notice> noticeboard = (List) request.getAttribute("noticeboard"); %>
<%List<Product> productboard = (List) request.getAttribute("productboard"); %>

<script type="text/javascript">

delete localStorage.menu;

</script>
<style type="text/css">
	/* 여백 초기화 */
	*{margin:0; padding:0;}
	li{list-style:none;}
	a:link, a:visited{text-decoration:none; color:#000;}
	
	#container{width:100%; overflow:hidden;
		margin:0 auto; 
	}
	
	#screen{ 
		width:100%; 
		height:520px;
/* 		border:5px solid #ccc;  */
		margin:0 auto; 
		position:relative; 
		overflow:hidden;
	}
	#film{width:400%; height:100%; margin:0; padding:0;}
	/* 부모요소가 크던 작던 100%로 인식함*/
	.scene{float:left; width:25%; height:100%; position:relative;}
	.scene img{ width:100%; height:100%;}
	.scene div{position:absolute; 
		z-index:99; 
		left:300px; top:180px;
	}
	.scene div p{color:#fff;
		font-size:45px;
		font-family:"nanumsquare";
		font-weight:800;
	}
	#film:after{ content:""; display:block; clear:both; }

	#btn p{ position:absolute; top:50%; width:50px; height:100px; margin-top:-50px;}
	#btn p img{ width:100%; height:100%;}

	#btn .nextBtn{right:20px;}
	#btn .prevBtn{left:20px;}
	
	#content_box{width:100%; height:520px;}
	#content_box #content_all{width:830px; overflow:hidden;
		padding:70px 0 0;
		margin:0 auto;
	}
	#content_box .discover_box{width:400px;
		height:350px;
/* 		overflow:hidden; */
		border:1px solid #ccc;
		border-radius:10px;
		float:left;
		margin-right:30px;
		background-color:#fff;
	}
	#content_box .discover_box .sel_box{width:400px; height:250px; margin:0; padding:30px;}
	#content_box .discover_box .sel_box .title_box{width:100%;
	
		height:40px;
		margin-bottom:15px;
		
	}
	#content_box .discover_box .sel_box .title_box h4{width:250px;
		height:40px;
		line-height:40px;
		margin:0;
		text-indent:20px;
		font-weight:700;
		font-size:16px;
		float:left;
		
		
	}
	#content_box .discover_box .sel_box .title_box a{
		display:block;
		width:70px;
		height:20px; 
		float:left;
		background-color:aqua;
		text-align:center;
		margin-top:10px;
		font-size:12px;
		border-radius:5px;
		line-height:20px;
	}
	
	#content_box .discover_box .sel_box .discover_sub{width:100%; height:250px;}
	#content_box .discover_box .sel_box .discover_sub li{width:115px; 
		text-align:center;
		float:left;
		cursor:pointer;
	}
	
	#content_box .discover_box .sel_box .discover_sub .fir{margin-right:40px;}
	#content_box .discover_box .sel_box .discover_sub li p{width:150px;}
	#content_box .discover_box .sel_box .discover_sub li .img_box{ width:150px; height:150px; line-height:150px;}

	#content_box .notice_box{width:400px;
		height:350px;
		overflow:hidden;
		border:1px solid #ccc;
		border-radius:10px;
		float:left;
		overflow:hidden; 
		background-color:#fff;
	}
	
	#content_box .notice_box .sel_box{width:400px; height:100%; padding:30px; overflow:hidden;}
	#content_box .notice_box .sel_box .title_box{width:100%;
		height:40px;
		margin-bottom:15px;
		
	}
	#content_box .notice_box .sel_box .title_box h4{width:250px;
		height:40px;
		line-height:40px;
		margin:0;
		text-indent:20px;
		font-weight:700;
		font-size:16px;
		float:left;
		
		
	}
	#content_box .notice_box .sel_box .title_box a{
		display:block;
		width:70px;
		height:20px; 
		float:left;
		background-color:aqua;
		text-align:center;
		margin-top:10px;
		font-size:12px;
		border-radius:5px;
		line-height:20px;
	}
	#content_box .notice_box .sel_box .notice_sub{width:100%; height:220px; overflow:hidden;}
	#content_box .notice_box .sel_box .notice_sub li{width:100%;
		line-height:30px;
	} 
	
	#content_box .notice_box .sel_box .notice_sub li a{
		display:block;
		width:100%;
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
		font-size:15px;
	}
	
	#product_box{width:100%; padding-top:50px; background-color:#f0f0f0; }
	#product_box .product_sub{width:1200px; margin:0 auto;}
	#product_box .product_sub h4{text-align:center; font-weight:700; font-size:20px;}
	#product_box .product_sub ul{width:840px; height:400px; overflow:hidden; margin:20px auto 0;}
	#product_box .product_sub ul li{width:200px; margin-right:10px; height:300px; float:left;}
	#product_box .product_sub ul li p{text-align: center;}
	#product_box .product_sub ul .last{margin:0;}
	#product_box .product_sub ul li img{width:100%; height:200px;}
	
	#bt_box{width:100%;
		height:450px;
		margin:0 auto; 
		background-image:url("../resources/se2/img/bg_img.jpeg");
		background-repeat:repeat-x;
		background-position:0 0;
		background-size:100% 100%;
	}
	#bt_box h5{text-align:center; 
		font-size:30px; 
		padding:50px 0;
		color:#fff;
		font-weight: 600;
		font-family: "nanumsquare";
		margin:0;
	
	}
	#bt_box ul{width:1200px; height:220px; margin:0 auto;}
	#bt_box ul li{width:350px;
		height:100%;
		float:left; 
		margin-left:20px;
		background-color: rgba(255,255,255,0.1);
   		border: 1px solid rgba(255,255,255,0.2);
	
	}
	#bt_box ul li .bgicon{width:60px; height:60px; 
		background-color:#009d8f;
		margin:0 auto;
		border-radius:0 0 10px 10px;
	
	}
	#bt_box ul li .bgicon img{width:35px; 
		height:35px;
		margin-top:10px;
		text-align:center;
	}
	#bt_box ul li p{color:#fff; text-align:center; font-family: "nanumsquare";}
	#bt_box ul li .bgtext{ padding:30px 0; line-height:40px;}
	#bt_box ul li p strong{font-size:24px;}
	
	
ul.tabs{
margin: 0px;
padding: 0px;
list-style: none;
}
ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
	font-weight: bold;
}


ul.tabs li.current{
	background: #FFC091;
	border : 1px solid #EA9A56;
	color: #222;
}

.firsttab-content, .secondtab-content{
	display: none;
	padding: 15px;
}

.firsttab-content.current, .secondtab-content.current{
	display: inherit;
}
</style>
<script>
	
		$(function(){
			
			
			// 이전 버튼을 해결하기 위하여 이미지 한장을 빼놓음
			$("#film").prepend( $(".scene:last") );
			$("#film").css({"marginLeft":"-100%"});
			

			/* 다음 버튼 누르기 */
			$(".nextBtn").click(function(){
				$("#film").animate({"marginLeft":"-=100%"},500,"swing",function(){
					$("#film").append( $(".scene:first") );
					$("#film").css({"marginLeft":"-100%"});
				});
			});


			/* 이전 버튼 누르기 */
			
			
			$(".prevBtn").click(function(){
				$("#film:not(:animated)").stop().animate({"marginLeft":"+=100%"},500,"swing",function(){
					$("#film").prepend( $(".scene:last") );
					$("#film").css({"marginLeft":"-100%"});
				});
			});
		
		
		});


</script>
<div id="container">
	<div id="screen">
		<ul id="film">
			<li class="scene">
				<img src="../resources/se2/img/main-visual01.jpg" />
				<div>
					<p>3조 유기견</p>
					<p>복지센터</p>
				</div>
			</li>
			<li class="scene">
				<img src="../resources/se2/img/main-visual02.jpg" />
				<div>
					<p>3조 유기견</p>
					<p>복지센터</p>
				</div>
			</li>
			<li class="scene">
				<img src="../resources/se2/img/main-visual03.jpg" />
				<div>
					<p>3조 유기견</p>
					<p>복지센터</p>
				</div>
			</li>
			<li class="scene">
				<img src="../resources/se2/img/main-visual04.jpg" />
				<div>
					<p>3조 유기견</p>
					<p>복지센터</p>
				</div>
			</li>
			<li class="scene">
				<img src="../resources/se2/img/main-visual05.jpg" />
				<div>
					<p>3조 유기견</p>
					<p>복지센터</p>
				</div>
			</li>
			<li class="scene">
				<img src="../resources/se2/img/main-visual06.jpg" />
				<div>
					<p>3조 유기견</p>
					<p>복지센터</p>
				</div>
			</li>
		</ul>
		<div id="btn">
			<p class="nextBtn"><img src="../resources/se2/img/next_shadow.png" alt="다음버튼" class="next"/></p>
			<p class="prevBtn"><img src="../resources/se2/img/prev_shadow.png" alt="이전버튼" class="prev"/></p>
		</div>
	</div>
	<div id="content_box">
		<div id="content_all">
			<div class="discover_box">
				<div class="sel_box"> <!-- 선택박스 -->
					<div class="title_box">
						<ul class="tabs">
							<li class="firsttab-link current" data-tab="firsttab-1">유기동물 찾기</li>
							<li class="firsttab-link" data-tab="firsttab-2">유기동물 발견</li>
						</ul>
					</div>
					<ul class="discover_sub firsttab-content current" id="firsttab-1">
						<%for(int i=0; i<findboard.size(); i++) { %>
						<li class="fir">
							<a href="/find/read?FindNo=<%=findboard.get(i).getFindNo() %>">
							<img class="img_box" src="<%=request.getContextPath()%>/upload/<%=findboard.get(i).getStroed_img()%>">
							</a>
							<p class="text_box"><%=findboard.get(i).getTitle() %></p>
							<p class="loc_box"><%=findboard.get(i).getLoc() %></p>
							<p class="kinds_box"><%=findboard.get(i).getPetKinds() %></p>
						</li>
						<% } %>
					</ul>
					<ul class="discover_sub firsttab-content" id="firsttab-2">
						<%for(int i=0; i<discoverboard.size(); i++) { %>
						<li class="fir">
							<a href="/discover/read?FindNo=<%=discoverboard.get(i).getDiscoverNo() %>">
							<img class="img_box" src="<%=request.getContextPath()%>/upload/<%=discoverboard.get(i).getStroed_img()%>">
							</a>
							<p class="text_box"><%=discoverboard.get(i).getTitle() %></p>
							<p class="loc_box"><%=discoverboard.get(i).getLoc() %></p>
							<p class="kinds_box"><%=discoverboard.get(i).getPetKinds() %></p>
						</li>
						<% } %>
					</ul>
				</div>
			</div>
			<div class="notice_box">
				<div class="sel_box"> <!-- 선택박스 -->
					<div class="title_box">
						<ul class="tabs">
							<li class="secondtab-link current" data-tab="secondtab-1">후기</li>
							<li class="secondtab-link" data-tab="secondtab-2">공지사항</li>
						</ul>
					</div>
					<ul class="notice_sub secondtab-content current" id="secondtab-1">
						<% for(int i=0; i<noticeboard.size(); i++) { %>
						<li><a href="/review/view?reviewNo=<%=reviewboard.get(i).getReviewNo() %>" title="후기">
							<span style="font-size: small; font-weight: bold;">[<%=reviewboard.get(i).getReviewSortDetail() %>]</span> <%=reviewboard.get(i).getTitle() %>
						</a></li>
						<% } %>
					</ul>
					<ul class="notice_sub secondtab-content" id="secondtab-2">
						<% for(int i=0; i<noticeboard.size(); i++) { %>
						<li><a href="/notice/view?noticeno=<%=noticeboard.get(i).getNoticeNo() %>" title="공지사항">
							<%if (noticeboard.get(i).getNoticeImp() != null) { %>
								<img src="/resources/image/check.jpg" style="width:15px; height:15px;"/>
							<% } else { %>
								<img src="#" style="width:15px; height:15px;"/>
							<% } %>
							<%=noticeboard.get(i).getTitle() %>
						</a></li>
						<% } %>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="product_box">
		<div class="product_sub">
			<h4>스토어</h4>
			<ul>
				<% for(int i=0; i<productboard.size(); i++) { %>
				<li>
					<a href="/product/detail?productId=<%=productboard.get(i).getProductId() %>" title="이미지"><img src="<%=request.getContextPath()%>/uploadProd/<%=productboard.get(i).getStoredName() %>" /></a>
					<p><%=productboard.get(i).getProductName() %></p>
					<p><%=productboard.get(i).getPrice() %> 원</p>
				</li>
				<% } %>
			</ul>
		</div>
	</div>
	<div id="bt_box">
		<h5>유기견 보호센터 안내</h5>
		<ul>
			<li>
				<p class="bgicon">
					<img src="../resources/se2/img/bg_icon01.png" alt="배경이미지1"/>
				</p>
				<p class="bgtext">
					<strong>운영시간안내</strong><br/>
					<span>09:00 am ~ 18:00 pm</span>
				</p>
			</li>
			<li>
				<p class="bgicon"><img src="../resources/se2/img/bg_icon02.png" alt="배경이미지1"/></p>
				<p class="bgtext">
					<strong>입양 및 기타 문의사항</strong><br/>
					<span>TEL : 010-1234-5678</span>
				</p>
			</li>
			<li>
				<p class="bgicon"><img src="../resources/se2/img/bg_icon03.png" alt="배경이미지1"/></p>
				<p class="bgtext">
					<strong>찾아오시는길</strong><br/>
					<span>서울특별시 강남구 테헤란로14길 6 남도빌딩 2F</span>
				</p>
			</li>
		</ul>
	</div>
</div>

<script type="text/javascript">

$(document).ready(function(){
	
	$('ul.tabs li.firsttab-link').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li.firsttab-link').removeClass('current');
		$('.firsttab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})

	$('ul.tabs li.secondtab-link').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li.secondtab-link').removeClass('current');
		$('.secondtab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})

})
</script>


<%@ include file="/WEB-INF/views/layout/footer.jsp" %>