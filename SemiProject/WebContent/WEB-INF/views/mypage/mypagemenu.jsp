<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.left {
	float: left;
	width: 20%;
	margin-top: 130px
}

#mypageinfo {
	border: 1px solid #ccc;

}

a {
	color: #626960;
	text-decoration: none;
	font-size: 20px;

}
.tx_size {
	font-size: 30px;
}

.rel_tx {
	position: relative;
	height: 120px;
}

.abs_tx{
	position: absolute;
	left:15%;
	top:18%;
}
.rel_tx1 {
	position: relative;
	height: 120px;
}

.abs_tx1{
	position: absolute;
	left:15%;
	top:3%;
}
.rel_tx2 {
	position: relative;
	height: 140px;
}

.abs_tx2{
	position: absolute;
	left:15%;
	top:3%;
}
.rel_logo {
	position: relative;
	height: 165px;
	width: 20%;
}

.abs_logo{
	position: absolute;
	left:15%;
	top:3%;
}
</style>

<script type="text/javascript">
function uconfirm() {
	window.open("/mypage/confirm","본인확인","width=700, height=400");
}


</script>
<div id="mypageinfo" class="left">
<div class="rel_tx">
<div class="abs_tx">
	<div class="tx_size">MY 쇼핑</div>
	<a href="/mypage/basket">장바구니</a><br>
	<a href="#">구매목록</a>
</div>
</div>

	<hr>
<div class="rel_tx1">
<div class="abs_tx1">
	<div class="tx_size">MY 정보</div>
	<a href="/mypage/profile">프로필 관리</a><br>
	<a onclick="uconfirm()">회원정보 수정</a>
</div>
</div>
	<hr>
<div class="rel_tx2">
<div class="abs_tx2">
	<div class="tx_size">MY 활동</div>
	<a href="#">내가 작성한 게시물</a><br>
	<a href="#">찜 리스트</a><br><br>
</div>
</div>
</div>
	
