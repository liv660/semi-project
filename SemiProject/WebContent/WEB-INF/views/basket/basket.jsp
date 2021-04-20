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
	width: 960px;
	height: 160px;
}

.right {
	float: right;
	width: 80%;
}

.rel_head {
	position: relative;
	width: 800px;
	margin: 0 auto;
	top: 30px;

}

.hr_red {
	border-color: red;
}
.hr_bot {
	margin-bottom: 0;
	
}
#allcheck {
	zoom:2.0;
}
.abs_chkbox {
 	position: absolute; 
	width: 28px;
	height: 26px;
	left: 20px;
} 
.abs_chklab {
 	position: absolute; 
	width: 83px;
	height: 26px;
	left:60px;
	top:67px;
} 
.abs_chkbtn {
 	position: absolute; 
	width: 83px;
	height: 26px;
	left:155px;
	top:65px;
}
.btn_del {
	border: 1px solid #ccc;
    background-color: white;
    color: #0CBCF2;
    border-radius: 10px;
    height: 31px;
    width: 50px;
    font-size: 15px;

}

.btn_del:hover {
	
	color:red;
}
#se {
	width: 960px;
	height: 400px;
}
.rel_se1 {
	position: relative;
    width: 800px;
    height: 170px;
    margin: 0 auto;
    top: 5px;
    padding-top: 8px;
}
.rel_se2 {
	position: relative;
    width: 800px;
    height: 170px;
    margin: 0 auto;
    top: 130px;
    padding-top: 8px;
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

.abs_pdt {
	position: absolute;
    top: 0px;
    left: 30px;
    width: 159px;
    height: 155px;
    text-align: center;
}

.abs_tt {
	position: absolute;
    left: 220px;
    width: 520px;
    height: 150px;
    text-align: center;
    top: 0;

}

.abs_tt th {
	font-size: 25px;

}
.abs_tt td {
	font-size: 18px;

}
#fot {
	width: 960px;
	height: 240px;
	
}

.rel_fot {
	position: relative;
	width: 800px;
	height: 145px;
	margin: 0 auto;

}
.abs_pri {
	position: absolute;
    width: 740px;
    height: 44px;
    border: 4px solid #ccc;
    left: 27px;
    top: 40px;
    text-align: center;
	font-size: 20px;
	

}
.abs_pri > span {
	font-size: 26px;
}

.abs_fobtn {
	position: absolute;
    top: 100px;
    left: 250px;
    width: 280px;
    height: 37px;
    text-align: center;

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

<div class="rel_head">
<h1>장바구니</h1>
<hr class="hr_red hr_bot">
<div class="abs_chkbox">
<input type="checkbox" id="allcheck"/>
</div>
<div class="abs_chklab">
<label for="allcheck" style="font-size: 20px;">전체선택</label>
</div>
<div class="abs_chkbtn">
<button class="btn_del">삭제</button>
</div>
<hr class="hr_red hr_bot" style="margin-top:40px; ">
</div>

<!-- <div id="content" class="right"> -->
</div>
<div id="se" class="right">

<div class="rel_se1">
<input type="checkbox" class="checkList" style="zoom:1.6;"/>
	<div class="abs_pdt">
		<div class="box" style="background: #BDBDBD;">
    	<img class="product" src="/userimgup/basic.png">
	<table class="abs_tt">
		<tr>
			<th>상품명</th>
			<td>가격</td>
			<td>배송비</td>
		</tr>
	</table>
	</div>
</div>

<div class="rel_se2">
<input type="checkbox" class="checkList" style="zoom:1.6;"/>
	<div class="abs_pdt">
		<div class="box" style="background: #BDBDBD;">
    	<img class="product" src="/userimgup/basic.png">
	<table class="abs_tt">
		<tr>
			<th>상품명</th>
			<td>가격</td>
			<td>배송비</td>
		</tr>
	</table>
	</div>
</div>



</div>


</div>

<!-- <div id="se" class="right"> -->
</div>

<div id="fot" class="right">

<div class="rel_fot">
<hr class="hr_red hr_bot" style="margin-top: 5px;">

<div class="abs_pri">
	총 상품 가격 <span>0</span>원 + 배송비 <span>0</span>원 = 주문금액 <span style="color: red; text-decoration: underline; ">0</span>원
</div>

<div class="abs_fobtn">
	<button id="store_btn">계속 쇼핑하기</button>
	<button id="pur_btn">구매하기</button>
</div>

<!-- <div id="fot" class="right"> -->
</div>

<!-- <div id="wrapper"> -->
</div>
</body>
</html>