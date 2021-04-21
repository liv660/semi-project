<%@page import="dto.UserImg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	UserImg userimg = (UserImg) request.getAttribute("userimg");
%>
<%@ include file="/WEB-INF/views/layout/header.jsp"%>


<style type="text/css">
.box {
	width: 120px;
	height: 120px;
	border-radius: 70%;
	overflow: hidden;
	position: absolute;
	left: 42%;
}

.profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#wrapper {
	width: 1200px;
	margin: 0 auto;
}

#content {
	
	height: 700px;

	
}

.right {
	float: right;
	width: 70%;
}

.rel_pic {
	position: relative;
	height: 140px;
}

.center {
	padding: 12px;
	text-align: center;
}

.inSize {
	padding: 5px;
}

.lab_size {
	font-size: 17px;
	margin-right: 10px;
	margin-top: 10px;
	margin-bottom: 10px;
}

#profileimg {
	display: none;
}

.rel-btndd {
	position: relative;
	width: 180px;
	height: 41px;
	left: 400px;
	bottom: -160px;
}
.rel_phi {
	position: relative;
	top:75px;
	width: 660px;

}

.rel_forin {
	position: relative;
	width: 600px;
	height: 320px;
	top:130px;


}

</style>

<script type="text/javascript">
$(document).ready( function () {
	
$("#nickbtn").click(function() {
	console.log("nickck")
			var nick = $("#nick").val();
			
				$.ajax({
					type: 'post',
					url: '/login/nickcheck',
					data: {nick:nick},
					success : function(data) {
						if(data > 0) {
							$("#nickMsg_cor").html("");
							$("#nickMsg").html("중복된 닉네임 입니다.");
							idchFlag = false;
						} else {
							$("#nickMsg").html("");
							$("#nickMsg_cor").html("사용가능한 닉네임 입니다.");
							idchFlag = true;
						}
					}
				})
}) //$("#nickbtn").click end
		

$(document.body).on("change", "#profileimg", function( e ) {
	console.log("change")
	
	var files = e.target.files;
	
	//이미지만 처리할 수 있도록 적용
	if( !files[0].type.includes("image") ) {
		alert("이미지가 아닙니다")
		
		//선택한 파일 제거(해제)
		e.target.value = null
		
		//이벤트 처리 중단(종료)
		return false;
	}
	
	//FileReader 객체 생성
	var reader = new FileReader();
	
	//이벤트 리스너
	reader.onload = function(ev) {
		//이미지를 한 장만 유지하도록 만듦
		$("#preview").html(
				$("<img>").attr({
					"src": ev.target.result
					, "width": "100%"
			   		, "height": "100%"
			    	, "object-fit": "cover"
				})
			);
		}
	

	// FileReader객체를 이용해 파일 정보 읽기
	reader.readAsDataURL( files[0] )
	
	
})
	
	
	var domEle = [$("#profileimg").clone()];
	$("#baseimg").click( function () {
		
		console.log(domEle[0])
		
		domEle[1] = domEle[0].clone(true);
		$('#profileimg').replaceWith(domEle[1]);
	    $("#blah").hide();
	
		$.ajax({
			type: 'post',
			url: '/mypage/profile/basicimg',
			data: { },
			success : function() {
				
					$("#preview").html(
						$("<img>").attr({
						"src": "/resources/image/basic.png" ,
						"width" : "100%",
						"height" : "100%",
						"object-fit" : "cover"
					}))

				}
			}) 

		})
	})
</script>

<div id="wrapper">
<%@ include file="/WEB-INF/views/mypage/mypagemenu.jsp"%>

<div id=content class="right">
<div class="rel_phi">
	<h1>프로필 관리</h1>
<hr style="border-color: red;">
</div>
<div class="rel_forin">
	<div class="rel_pic">
		<div class="box" id="preview" style="background: #BDBDBD;">
			<% if(  (userimg.getUpdateDate()) != null) {%>
    		<img class="profile" src="/userimgup/<%=userimg.getStroedName() %>">
    		<% } else {%>
    		<img class="profile" src="/resources/image/basic.png">
 			<% } %>
		</div>
	</div> 
	<form action="/mypage/profile" method="post"enctype="multipart/form-data">

	<div class="center ">
		<label for="profileimg" class="btn btn-default">
		<input type="file" name="profileimg" id="profileimg">사진올리기</label>
		<button type="button" id="baseimg" class="btn btn-default">기본이미지로변경</button>
	</div>

	<div class="center">
		<label for="nick" class="lab_size">닉네임</label> 
		<input type="text"class="inSize" id="nick" name="nick" placeholder="닉네임" /> 
		<input type="button" id="nickbtn" value="중복" /> <br> 
		<span id="nickMsg"></span><span id="nickMsg_cor"></span> <br><br>
	</div>
</div>
		<div class="rel-btndd">
			<div class="abs-btndd">
				<button class="btn btn-default">변경사항 저장</button>
				<button class="btn btn-danger"onclick="location.href= '/mypage/profile';">취소</button>
			</div>
		</div>
	</form>

	</div>
</div>

</body>
</html>