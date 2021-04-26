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

.boxone {
    width: 120px;
    height: 120px; 
    border-radius: 70%;
    overflow: hidden;

}
.hlogo {
    width: 100%;
    height: 100%;
    object-fit: cover;
    
}

.box {
    width: 150px;
    height: 150px; 
    overflow: hidden;
	margin-top: 10px;
}

.product {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.menu_table {
	border: 1px solid #ccc;
	border-bottom: 0;
	width: 875px;
    height: 80px;
}

.menu_table tr th {
	text-align: center;
}

.prod_text {
	border-left: 2px solid blue;
	border-top: 2px solid blue;
	border-right: 2px solid blue;
	border-bottom: 0;

}

.lab_text {

	border-bottom: 2px solid blue;
}

.allchk_layout {
	width: 875px;
	margin-left: 30px;
} 
#allcheck {
	zoom:1.6;
	margin-top: 0;
	margin-left: 15px;
}
.btn_del {
	border: 1px solid #ccc;
    background-color: white;
    color: #0CBCF2;
    border-radius: 10px;
    height: 31px;
    width: 85px;
    font-size: 15px;
    margin-left: 10px;

}

.btn_del:hover {
	
	color:red;
}

.table_layout {
	border-bottom: 1px solid #ccc;
	margin-top: 5px;
    margin-left: 30px;
    margin-bottom: 15px;
    width: 875px;
}

.td_onelay {
	width: 200px;
    padding-left: 16px;
    padding-top: 0;
    padding-bottom: 10px;
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

	font-size: 15px;

}

.td_threelay {
 text-align: center;

}

#btn_basket {
	font-size: 17px;
    width: 170px;
    background: white;
    border: 1px solid #ccc

}
#btn_basket:hover {
	
	background: #A48654;
	color: white;
	
}
</style>

<script type="text/javascript">
$(document).ready (function() {
	
	
	$(".prod_text").click(function() {
		
		$(".prod_text").css({
			"border-left": "2px solid blue",
			"border-top": "2px solid blue",
			"border-right": "2px solid blue",
			"border-bottom": "0",
		})
		
		$(".lab_text").css({
			"border-left": "1px solid #ccc",
			"border-top": "1px solid #ccc",
			"border-right": "1px solid #ccc",
			"border-bottom": "2px solid blue",
			
		})
	})
		
	$(".lab_text").click(function() {
		
		$(".lab_text").css({
			"border-left": "2px solid blue",
			"border-top": "2px solid blue",
			"border-right": "2px solid blue",
			"border-bottom": "0",
		})
		
		$(".prod_text").css({
			"border-left": "1px solid #ccc",
			"border-top": "1px solid #ccc",
			"border-bottom": "2px solid blue",
			
		})
		
	
		
	})
	
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
			<table>
				<tr>
					<td>
						<div class="boxone" style="background: #BDBDBD; border: 0;">
    					<img class="hlogo" src="/resources/image/heart.png">
						</div>	
					<td>
					<td><h1>찜 리스트</h1>총 1개</td>
				</tr>
			</table>
			<table class="menu_table">
				<tr>
					<th class="prod_text" style="width: 50%"><h3>상품(2)</h3></th>
					<th class="lab_text"><h3>스크랩(3)</h3></th>
				</tr>			
			</table>
		</div>
		
		<div class="allchk_layout">
			<hr style="margin-bottom: 10px">
			<input type="checkbox" id="allcheck"/>
			<label for="allcheck"style="font-size: 15px; margin-left: 15px;">전체선택</label>
			<button class="btn_del">선택 삭제</button>
			<hr style="margin-top: 10px">
		</div>
		
		<table class="table_layout">
			<tr>
				<td style="padding-bottom: 95px; width: 5%;"><input type="checkbox" class="checkList" style="zoom:1.6;"/></td>
				<td class="td_onelay">
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
</div>
</body>
</html>