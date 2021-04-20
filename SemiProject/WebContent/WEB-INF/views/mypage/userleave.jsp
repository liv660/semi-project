<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

<style type="text/css">
#wrapper {
	width: 250px;
	margin: 0 auto;

}

#btnleave {
	border-radius: 10px;
	border: 0;
	background-color: #0CBCF2;
	color: white;
	width: 50px;
	height: 30px;
	font-size: 17px;
}
#btnleave:hover {
	color:#dc3545;

}
#btncancle {
	border-radius: 10px;
	border: 0;
	background-color: #dc3545;
	width: 50px;
	height: 30px;
	color: white;
	font-size: 17px;
}
#btncancle:hover {
	color:black;
}
hr {
border-color: red;

}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#five").click(function () {
		$("input[type=radio]").attr("checked", false);
	})
})

function goupdatepage() {
	
	self.close();
	
}

function sub() {
	
	var up = confirm("회원탈퇴를 정말로 하시겠습니까?")
	
	if ( up ) {
		
	$("form").submit();
	
	} else {
		return;
	}
	
}
</script>


</head>
<body>
<div id="wrapper">
<h1>회원탈퇴</h1>
<hr>
<form action="/mypage/leave" method="post">
<input type="radio" id="one" name="content" value="속도가 느림" checked="checked"/>
<label for="one">속도가 느림</label><br>
<input type="radio" id="two" name="content" value="자주 이용하지 않음"/>
<label for="two">자주 이용하지 않음</label><br>
<input type="radio" id="three" name="content" value="잦은 서비스 오류 및 장애"/>
<label for="three">잦은 서비스 오류 및 장애</label><br>
<input type="radio" id="four" name="content" value="찾고자 하는 정보가 없음"/>
<label for="four">찾고자 하는 정보가 없음</label><br><br>
<textarea rows="15px" cols="28px" id="five" name="content" placeholder="기타사항"></textarea>
<br>

</form>

<button id="btnleave" onclick="sub();">탈퇴</button>
<button id="btncancle" onclick="goupdatepage()">취소</button>

</div>
</body>
</html>