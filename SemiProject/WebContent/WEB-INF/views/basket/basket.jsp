<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
.h_po {
    margin-top: 45px;
    margin-left: 30px;
    margin-right: 50px;
}

hr {
    margin-top: 20px;
    margin-bottom: 5px;
    border: 0;
    border-top: 1px solid #ccc;

}
.allchk_layout {
	width: 250px;
	margin-left: 15px;
} 
#allcheck {
	zoom:1.6;
	margin-top: 0;
}
.btn_del {
	border: 1px solid #ccc;
    background-color: white;
    color: #0CBCF2;
    border-radius: 10px;
    height: 23px;
    width: 85px;
    font-size: 14px;
    margin-left: 10px;

}

.btn_del:hover {
	
	color:red;
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

.table_layout {
	border: 1px solid #ccc;
    margin-left: 30px;
    margin-top: 15px;
    width: 870px;

}
.table_layout tr th {
	font-size: 20px;
}
.table_layout tr td {
	font-size: 15px;
	text-align: center;
}
.f_po {
    margin-left: 30px;
    margin-right: 50px;
}
.pri_info {
	width: 650px;
    height: 37px;
    border: 4px solid #ccc;
    text-align: center;
	font-size: 20px;
	margin: 0 auto;
}

.pri_info span {
	font-size: 20px;
}
.btn_f {
	margin: 0 auto;
    width: 310px;
    margin-top: 70px;

}
#store_btn {
	width: 130px;
	height: 33px;
	font-size: 17px;
	border: 0;
	border-radius: 10px;
	
}

#store_btn:hover {
	color:white;

}

#pur_btn {
	width: 130px;
	height: 33px;
	font-size: 17px;
	background-color: #0CBCF2;
	border-radius: 10px;
	border: 0;
	color: white;

}

#pur_btn:hover {
	color: red;
}

.no_basket {
    width: 870px;
    height: 155px;
    margin-left: 30px;
    border: 1px solid #ccc;
    margin-top: 15px;
    text-align: center;
}
</style>

<script type="text/javascript">
$(document).ready (function () {
	
	﻿ //전체 클릭시에 하위요소 전체 선택/해체	
	$("#allcheck").bind("click", function(){﻿
		$(".checkList").each(function(){
			$(this).prop("checked", $("#allcheck").prop("checked"));
		});
	});
	
	//하위요소 클릭시에 전체 자동 선택/해체
	$(".checkList").bind("click", function(){
	  	$("#allcheck").prop("checked", $(".checkList").length == $(".checkList:checked").length);
	}); 
	
});


</script>
<div id="wrapper">
	<%@ include file="/WEB-INF/views/mypage/mypagemenu.jsp" %>
	<div id="content" class="right">
		<div class="h_po">
			<h1>주문목록</h1>
			<hr>

		<div class="allchk_layout">
			<input type="checkbox" id="allcheck"/>
			<label for="allcheck"style="font-size: 15px; margin-left: 15px;">전체선택</label>
			<button class="btn_del">선택 삭제</button>
		</div>

		<hr style="margin-top: 2px;">
		</div>
	
		<table class="table_layout">
			<tr>
				<td style="padding-bottom: 95px; width: 5%;"><input type="checkbox" class="checkList" style="zoom:1.6;"/></td>
				<td style="width: 30%;">
					<div class="box" style="background: #BDBDBD;">
    				<img class="product" src="/resources/image/basic.png">
					</div>
				</td>
				<th>상품명</th>
				<td>가격</td>
				<td>배송비</td>
			</tr>
		</table>
		
		<div class="no_basket">
		<h1>장바구니에 담긴 상품이 없습니다</h1>
		
		</div>
		<div class="f_po">
			<hr style="margin-bottom: 30px;">
			<div class="pri_info">
			총 상품 가격 
				<span>0</span>
			원 + 배송비
				<span>0</span>
			원 = 주문금액 
				<span style="color: red; text-decoration: underline; ">0</span>
			원
			</div>
		</div>
		<div class="btn_f">
			<button id="store_btn">계속 쇼핑하기</button>
			<button id="pur_btn">구매하기</button>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/layout/myfooter.jsp" %>