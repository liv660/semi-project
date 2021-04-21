<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% String Pw = (String) request.getAttribute("Pw");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>본인확인</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<style type="text/css">
.wrapper {
	width: 680px;
	margin: 0 auto;
}


#pw {
	color: blue;
}
#pw_cor {
	color: red;
}


table {
	width: 450px;
	height: 150px;
	margin: 0 auto;
}
th {
	font-size: 20px;
	text-align: left;
	width: 100px;
}
td {
	font-size: 20px;

}

#userpw {
	width: 200px;
	height: 1.5em;
	border-radius: 13px;
	text-align: center;
}

.btn_po {
	text-align: center;

}

#confirm {
	width: 4em;
	height: 2em;
	font-size: 17px;
	background-color: #0CBCF2;
	border-radius: 10px;
	border: 0;
	color: white;

}
#pwcon {
	width: 10em;
	height: 2em;
	font-size: 17px;
	background-color: #F5F6E7;
	border-radius: 10px;
	border: 0;
}

#confirm:hover {
	color: red;
}
</style>

<script type="text/javascript">
$(document).ready(function () {

	
	
})

function goupdatepage() {
	
	self.close();
	opener.location.href = "/mypage/profile/update";
	
}

function pwconfirm() {
	
	
	var ipw = $("input").val();
	$.ajax({
		type: 'post',
		url: '/mypage/confirm',
		data: { ipw:ipw },
		success : function( data ) {
			console.log( data )
				if( data == "true") {
					$("#pw_cor").html("");
					$("#pw").html("PASSWORD MATCH");
					$("#pwcon").removeAttr("disabled")
				
				} else {
					$("#pw").html("");
					$("#pw_cor").html("PASSWORD MISMATCH");
					
					
				}
			

			}
		}) 
	
	
}


</script>
</head>
<body>
<div class="wrapper">
<h1>회원 정보 확인</h1>
<div style="text-align: center;">
<%=request.getSession().getAttribute("nick") %> 님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인합니다.
</div>
<div>
<table>
	<tr>
		<th>아이디</th>
		<td><%=request.getSession().getAttribute("userid") %></td>
	</tr>
	<tr>
		<th><label>비밀번호</label></th>
		<td>
		<input type="password" id="userpw" name="userpw" /><br>
		<span id="pw"></span><span id="pw_cor"></span>
		</td>
		
	</tr>
</table>
<div class="btn_po">
	<input type="button" id="confirm" onclick="pwconfirm()" value="확인" />
	<button onclick="goupdatepage()" id="pwcon" disabled="disabled">마이페이지 이동</button>
</div>


</div>



</div>
</body>
</html>