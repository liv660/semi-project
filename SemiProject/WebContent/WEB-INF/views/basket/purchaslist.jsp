<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>


<script type="text/javascript">
$(document).ready (function () {

		
	var $btnone = $("#btn_layout button:nth-child(1)");
	var $btntwo = $("#btn_layout button:nth-child(2)");
	var $btnthree = $("#btn_layout button:nth-child(3)");
	var $btnfour = $("#btn_layout button:nth-child(4)");
	var $btnfive = $("#btn_layout button:nth-child(5)");
	
	
	$($btnone).on("click",function() {
			
		btnskin($btnone);
		
		oribtnskinetc($btntwo);
		oribtnskinetc($btnthree);
		oribtnskinetc($btnfour);
		oribtnskinetc($btnfive);
	});
	$($btntwo).on("click",function() {
			
		btnskin($btntwo);
		
		btnoriskinone($btnone);
		oribtnskinetc($btnthree);
		oribtnskinetc($btnfour);
		oribtnskinetc($btnfive);
	});
	$($btnthree).on("click",function() {
			
		btnskin($btnthree);
		
		btnoriskinone($btnone);
		oribtnskinetc($btntwo);
		oribtnskinetc($btnfour);
		oribtnskinetc($btnfive);
	});
	$($btnfour).on("click",function() {
			
		btnskin($btnfour);
		
		btnoriskinone($btnone);
		oribtnskinetc($btntwo);
		oribtnskinetc($btnthree);
		oribtnskinetc($btnfive);
	});
	$($btnfive).on("click",function() {
			
		btnskin($btnfive);
		
		btnoriskinone($btnone);
		oribtnskinetc($btntwo);
		oribtnskinetc($btnthree);
		oribtnskinetc($btnfour);
	});
	
});	

function btnskin(data) {
	
	$(data).css({
		"width":"100px",
		"font-size":"17px",
		"background":"#0CBCF2",
		"color":"white",
		"border":"0"})
	
}

function btnoriskinone(data) {
	
	$(data).css({
		"width":"105px",
		"font-size":"15px",
		"background":"white",
		"color":"black",
		"border":"1px solid #ccc"})
	
}

function oribtnskinetc(data) {
	
	$(data).css({
		"width":"75px",
		"font-size":"15px",
		"background":"white",
		"color":"black",
		"border":"1px solid #ccc"})
	
}


</script>
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

.rel_head {
	position: relative;
    width: 800px;
    top: 60px;
    margin-left: 60px;

}

.box {
    width: 150px;
    height: 150px; 
    overflow: hidden;

}

.product {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

#btn_layout {
    width: 600px;
    margin-top: 15px;
    margin-left: 30px;


}

#btn_layout button:first-child {
	border: 1px solid #ccc;
    background-color: white;
    color: black;
    border-radius: 30px;
    width: 105px;
    font-size: 15px;
	height: 33px;
}
#btn_layout button {
	border: 1px solid #ccc;
    background-color: white;
    color: black;
    border-radius: 30px;
    width: 75px;
    font-size: 15px;
	height: 33px;
}

.h_po {
    margin-top: 45px;
    margin-left: 30px;
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
	margin-top: 5px;
    margin-left: 20px;
    margin-bottom: 15px;
    width: 805px;
}

.pur_layout p{
	margin-top: 10px;
    margin-left: 20px;
    margin-bottom: 0;
    font-size: 20px;
}

.td_onelay {
	width: 200px;
    padding-left: 16px;
    padding-top: 0;
    padding-bottom: 10px;
}
.td_onelay:nth-child(1) { 
	font-size: 18px; 
    font-weight: 600; 
    margin-bottom: 15px; 
}

.td_twolay {
	padding-top: 20px;
	width: 40%;
	border-right: 1px solid #ccc;
}

.twolay_onediv {

	margin-bottom: 15px;
	font-size: 25px; 
	
}

.twolay_onediv + div {

	font-size: 23px;

}

.td_threelay {
 text-align: center;

}

#btn_basket {
	font-size: 20px;
    width: 170px;
    background: white;
    border: 1px solid #ccc

}
#btn_basket:hover {
	
	background: #A48654;
	color: white;
	
}
.no_pur {
    width: 870px;
    height: 155px;
    margin-left: 30px;
    border: 1px solid #ccc;
    margin-top: 15px;
    text-align: center;
}
</style>
<div id="wrapper">
<%@ include file="/WEB-INF/views/mypage/mypagemenu.jsp" %>

<div id="content" class="right">

<div class="h_po">
<h1>구매 목록</h1>
</div>

<div id="btn_layout">
<button type="button" >최근 6개월</button>
<button type="button" >2021</button>
<button type="button" >2020</button>
<button type="button" >2019</button>
<button type="button" >2018</button>
</div>

<div class="pur_layout">
<p>2021 1월 21일 주문</p>
<table class="table_layout">
	<tr>
		<td class="td_onelay">
			<div style="margin-bottom: 15px;" >배송완료</div>
			<div class="box" style="background: #BDBDBD;">
    			<img class="product" src="/resources/image/basic.png">
			</div>
		</td>

		<td class="td_twolay">
			<div class="twolay_onediv">상품명</div>
			<div>14,200 원</div>
		</td>

		<td class="td_threelay">
			<button type="button" id="btn_basket">장바구니 담기</button>
		</td>
	</tr>
</table>
</div>

<div class="no_pur">
		<h1>구매하신 상품이 없습니다</h1>
		
</div>



</div>
</div>
</body>
</html>