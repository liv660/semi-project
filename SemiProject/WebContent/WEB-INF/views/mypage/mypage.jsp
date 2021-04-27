<%@page import="dto.PurchaseList"%>
<%@page import="java.util.List"%>
<%@page import="dto.MyBoard"%>
<%@page import="dto.UserImg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<PurchaseList> pl = (List) request.getAttribute("purchaseList"); %>    
<% UserImg userimg = (UserImg) request.getAttribute("userimg"); %>
<% List<MyBoard> listMyb = (List) request.getAttribute("myBoard"); %>
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
	background-color: rgba(234,205,153, 0.3 );
	height: 830px
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
	height: 24px;
	top: 110%;
	left: 15px;
	background: #FFC091;

}
.rel_ord {
	position: relative;
	width: 200px;
	height: 24px;
	top: 85%;
	left: 15px;
	background: #FFC091;

}

.abs_botx {
	text-align: center;
	font-size: 17px;
	font-weight: 600;
	
	
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

}

.table_di {
	font-size: 14px;

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

.no_pur {
    width: 684px;
    height: 155px;
    border: 1px solid #ccc;
    text-align: center;
}

.pur_layout {
	border: 1px solid #ccc;
	margin-top: 15px;
    margin-left: 30px;
    margin-bottom: 10px;
    width: 850px;
    height: 270px;
}
.table_layout {
	border: 1px solid #ccc;
    width: 684px;
}

.pur_layout p{
	margin-top: 10px;
    margin-left: 20px;
    margin-bottom: 0;
    font-size: 17px;
}

.td_onelay {
	width: 200px;
    padding-left: 16px;
    padding-top: 0;
    padding-bottom: 10px;
}
.td_onelay:nth-child(1) { 
	font-size: 17px; 
    font-weight: 600; 
    margin-bottom: 15px; 
}

.td_twolay {
	padding-top: 20px;
	width: 40%;
}

.twolay_onediv {

	margin-bottom: 15px;
	font-size: 20px; 
	font-weight: 600;
	
}

.twolay_onediv + div {

	font-size: 17px;

}

.td_threelay {
 text-align: center;

}

.pbox {
    width: 150px;
    height: 150px; 
    overflow: hidden;

}

.product {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>


<div id="wrapper">
<%@ include file="/WEB-INF/views/mypage/mypagemenu.jsp" %>



<div id="content" class="right">
<h1 style="text-align: center;">마이 페이지</h1>
<hr style="border-top: 5px solid #eee;">
<div class="rel_pro">

<div class="abs_img">
		<div id=myprofil>
		<div class="box" style="background: #BDBDBD;">
		<% if(  !"basic.png".equals(userimg.getStroedName()) && null != userimg.getStroedName() ) {%>
    	<img class="profile" src="/userimgup/<%=userimg.getStroedName() %>">
    	<% }  else {%>
    	<img class="profile" src="/resources/image/basic.png">
 		<% } %>
		</div>
		</div>
</div>

<div class="abs_info">
		<div style="font-size: 17px;"><%=session.getAttribute("nick") %> 님</div>
		<div><button class="btn btn-default btn-block" onclick="location.href= '/mypage/profile';">프로필수정</button></div>
</div>

<div class="rel_bor">
<div class="abs_botx">내가 작성한 글</div>
<div class="abs_puls"><a href="/mypage/written" style="font-size: 30px;">+</a></div>
</div>

<div class="rel_borad">
<table class="table table_di">
	<tr>
		<th style="width: 13%;">글번호</th>
		<th style="width: 20%;">게시판 이름</th>
		<th style="width: 50%;">제목</th>
		<th>날짜</th>
	</tr>
	<% if (listMyb.size() > 0) { %>
	<% for(int i=0; i < 3 && i <listMyb.size(); i++) { %>
	<tr>
	<td><%=listMyb.get(i).getBorad_no() %></td>
	<% if(listMyb.get(i).getBoard_div().equals("찾기 게시판")) { %>
	<td><a href="/find/list" style="font-size: 14px">
		<%=listMyb.get(i).getBoard_div() %>
		</a>
	</td>
	<% } else if (listMyb.get(i).getBoard_div().equals("발견 게시판")) {%>
	<td><a href="/discover/list" style="font-size: 14px">
		<%=listMyb.get(i).getBoard_div() %>
		</a>
	</td>
	<% } else if (listMyb.get(i).getBoard_div().equals("후기 게시판")) {%>
	<td><a href="/review/list" style="font-size: 14px">
		<%=listMyb.get(i).getBoard_div() %>
		</a>
	</td>
	<% } %>
	
	<% if (listMyb.get(i).getBoard_div().equals("찾기 게시판")) { %>
	<td><a href="find/read?FindNo=<%=listMyb.get(i).getBorad_no() %>" style="font-size: 17px">
		<%=listMyb.get(i).getTitle() %>
		</a>
	</td>
	<% } else if (listMyb.get(i).getBoard_div().equals("발견 게시판")) { %>
	<td><a href="discover/read?DiscoverNo=<%=listMyb.get(i).getBorad_no()%>" style="font-size: 17px">
		<%=listMyb.get(i).getTitle() %>
		</a>
	</td>
	<% } else if (listMyb.get(i).getBoard_div().equals("후기 게시판")) { %>
	<td><a href="/review/view?reviewNo=<%=listMyb.get(i).getBorad_no() %>" style="font-size: 17px">
		<%=listMyb.get(i).getTitle() %>
		</a>
	</td>
	<% } %>
	<td><%=listMyb.get(i).getCreate_date() %></td>
</tr>
<% } %>
<% } %>
</table>
</div>


<div class="rel_ord">
<div class="abs_botx">최근 주문 목록</div>
<div class="abs_puls"><a href="/purchase/list" style="font-size: 30px;">+</a></div>
</div>


<div class="rel_order">

<% 	if ( pl.size() > 0 ) { %>
<p style="text-align: left;"><%=pl.get(0).getPurchaseDate() %> 구매</p>
<table class="table_layout">
	<tr>
		<td class="td_onelay">
			<div style="margin-bottom: 15px;" >배송완료</div>
			<div class="pbox" style="background: #BDBDBD;">
				<a href="<%=request.getContextPath() %>/product/detail?productId=<%=pl.get(0).getProductId() %>"  >
    			<img class="product" src="<%=request.getContextPath() %>/uploadProd/<%=pl.get(0).getStoredImg() %>">
				</a>
			</div>
		</td>

		<td class="td_twolay">
			<div class="twolay_onediv"><%=pl.get(0).getProductName() %></div>
			<div><%=pl.get(0).getPrice() %>원</div>
		</td>

		<td class="td_threelay">
		</td>
	</tr>
</table>
<% 	} else { %>
<div class="no_pur">
		<h3>구매하신 상품이 없습니다</h3>
</div>
<% 	} %>


</div>



</div>


<!-- <div id="content" class="right"> end  -->
</div>



</div>



<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

