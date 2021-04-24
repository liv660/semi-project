<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style type="text/css">
#wrapper {
	width: 1200px;
	margin: 0 auto;
}
#content
{
	height: 800px;
}

.right {
	float: right;
	width: 80%;
}

.rel_up {
	position: relative;
}
.abs_uphead {
	position: absolute;
	left: 20px;
	top:57px;
	
}
.abs_upinfo {
	position: absolute;
	left: 87px;
	top: 135px;
	width: 820px;
	height:300px;

}
.abs_upinfo_th {
	font-size: 20px;
	text-align: right;
	width: 137px;
	position: absolute;
}

input {
	width: 450px;
	height: 38px;
	border-radius: 15px; 
	text-align: center;
	font-size: 17px;
}

tr {
	position: relative;
	height: 75px;
}
#user_postcode {
	width: 200px;
	height: 38px;
	border-radius: 15px; 
	position: absolute;
	right: 250px;
	top: 1px;
}
#user_roadAddress {
	width: 300px;
	position: absolute;
	right: 152px;
}

#user_jibunAddress {
	width: 300px;
	position: absolute;
	left: -142px;
}
#user_detailAddress {
	width: 230px;
	position: absolute;
	right: 220px;
}

#user_extraAddress {
	width: 230px;
	position: absolute;
	left: -205px;
}
.upinfo_td {
	text-align: center;
}

.abs_upinfo_td {
	position: absolute;
	left: 200px;
}

.abs_deltex {
	position: absolute;
	left: 377px;
	bottom: 47px;
	font-size: 16px;
	color: #ccc;

}
.abs_btnup {
	position: absolute;
	bottom: 10px;
	right: 90px;
	border-radius: 10px;
	border: 0;
	background-color: #0CBCF2;
	color: white;
	width: 130px;
	height: 30px;
	font-size: 17px;
}
.abs_btnup:hover {
	color:#dc3545;

}
.abs_btncancle {
	position: absolute;
	bottom: 10px;
	right: 30px;
	border-radius: 10px;
	border: 0;
	background-color: #dc3545;
	width: 50px;
	height: 30px;
	color: white;
	font-size: 17px;
}
.abs_btncancle:hover {
	color:black;
}
.abs_email_in {
	position: absolute;
	bottom: 258px;
	right: 160px;
	border-radius: 10px;
	border: 0;
	background-color: #ccc;
	width: 50px;
	height: 30px;
	color: black;
	font-size: 17px;
}

.abs_email_in:hover {
	color: white;
}

.abs_email_inco {
	position: absolute;
	bottom: 184px;
	right: 340px;
	border-radius: 10px;
	border: 0;
	background-color: #ccc;
	width: 50px;
	height: 30px;
	color: black;
	font-size: 17px;
}

.abs_email_inco:hover {
	color: white;
}


.abs_userleave {
	position: absolute;
	bottom: 48px;
	right: 108px;
	border-radius: 10px;
	border: 0;
	width: 77px;
	height: 28px;
	font-size: 15px;
	font-style: italic;
}

.abs_userleave:hover {
	color:blue;
}

.abs_search {
	height: 35px;
	width: 52px;
	position: absolute;
	right: 414px;
	top: 287px;
	border: 0;
	background: white;
}
img {
	width: 100%;
	height: 100%;
}

.Pwconfirm {
	height: 0;

}

.abs_pwup {
	position: absolute;
	width: 220px;
	height: 30px;
	left: 404px;
	top: 175px;
	text-align: center;
}
.abs_cpwup {
	position: absolute;
	width: 220px;
	height: 30px;
	left: 404px;
	top: 250px;
	text-align: center;
}
.abs_em {
	position: absolute;
	width: 235px;
	height: 30px;
	left: 404px;
	top: 550px;
	text-align: center;
}
.abs_numc {
	position: absolute;
	width: 220px;
	height: 30px;
	left: 312px;
	top: 625px;
	text-align: center;
}
.abs_numw {
	position: absolute;
	width: 260px;
	height: 30px;
	left: 312px;
	top: 625px;
	text-align: center;
}
.abs_guide {
	position: absolute;
	width: 460px;
	height: 30px;
	left: 290px;
	top: 400px;
	text-align: center;
}
.abs_tel {
	position: absolute;
	width: 260px;
	height: 30px;
	left: 404px;
	top: 702px;
	text-align: center;
}

.spa {
	font-size: 18px;
	color: red;
}

#atnum {
	position: absolute;
	width: 270px;
	right: 180px;

}

#cor_num {
	color: blue;
}
</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<script type="text/javascript">

$(document).ready(function() {
	
	$('input').keydown(function() {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
		});
	
	var upwReg = /^[A-Za-z0-9]{8,}$/
	
	//#pw 검증
	var pwFlag = "true";
	$("#userpw_up").blur(function(e) {
		
		if(!upwReg.test($("#userpw_up").val())) {
			$("#pwMsg").html("8자 이상 영문/숫자로 입력");
			pwFlag = "false";
		} else {
			$("#pwMsg").html("");
			pwFlag = "true";
		
			
			$("#userpw_con").focus();
			
		}
		
		if($("#userpw_up").val() == $("#userpw_con").val()) {
			$("#cpwMsg").html("");
		}
	})
	
	var ckFlag = "true";
	
	$("#userpw_con").blur(function() {
			if($("#userpw_up").val() != $("#userpw_con").val()) {
				$("#cpwMsg").html("비밀번호 불일치");
				ckFlag = "false";
			} else {
				$("#cpwMsg").html("");
				ckFlag = "true";
			}
		})
	
	

var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i
//#email 검증
	$("#email").blur(function() {
		if(!emailReg.test($("#email").val())) {
			$("#emailMsg").html("이메일 양식이 맞지 않습니다")
			emFlag = "false";
		} else {
			$("#emailMsg").html("");
			emFlag = "true";
			$("#mailbtn").attr('disabled', false);
			$("#email").attr('readonly', true);
		}
	})

var numFlag = "true";
	
$("#mailbtn").click(function() {
	var email = $("#email").val();
			
			$.ajax({
				type : 'get',
				url : '/login/email',
				data : {email:email},
				success : function(data) {
					alert("인증메일이 발송되었습니다.");
						
					$("#atnbtn").click(function() {
						if($("#atnum").val() != data) {
							$("#cor_num").html("");
							$("#wro_num").html("인증번호가 일치하지 않습니다")
							numFlag = "false";
						} else if($("#atnum").val() == data) {
							$("#wro_num").html("")
							$("#cor_num").html("인증번호가 일치합니다");
							numFlag = "true";
						}
					})
				} //success end
						
				}) //ajax end
					
	}); //$("#mailbtn").click end
	
//#tel 검증
var telReg = /^\d{3}\d{3,4}\d{4}$/;

var telFlag = "true";
$("#tel").blur(function() {
	if(!telReg.test($("#tel").val())) {
		$("#telMsg").html("숫자 10,11자리 입력")
		telFlag = "false";
	} else {
		$("#telMsg").html("");
		telFlag = "true";
	}
})	

$("#btnup").click(function() {
	
	
	
	if( pwFlag == "false" ) {
		alert('비밀번호 양식이 틀렸습니다');
		$("#userpw_up").focus();
		return false;
	}
	
	if( ckFlag == "false" ) {
		alert('비밀번호를 확인해 주세요');
		$("#userpw_con").focus();
		return false;
	}
	
	if( numFlag == "false" ) {
		alert('인증번호를 확인해 주세요');
		$("#atnum").focus();
		return false;
	}
	
	if( telFlag == "false" ) {
		alert('전화번호를 확인해 주세요');
		$("#tel").focus();
		return false;
	}
	
	$("form").submit();
})


$(function aa() {
	//
   $('#addr_search').click(function() {
      execDaumPostcode();
   });
   function execDaumPostcode() {
      new daum.Postcode({
         oncomplete : function(data) {
            var fullAddr = '';
            var extraAddr = '';

            if (data.userSelectedType === 'R') {
               fullAddr = data.roadAddress;
            } else {
               fullAddr = data.jibunAddress;
            }

            if (data.userSelectedType === 'R') {

            	if (data.bname !== '') {
                  extraAddr += data.bname;
               }

            	if (data.buildingName !== '') {
                  extraAddr += (extraAddr !== '' ? ', '
                        + data.buildingName : data.buildingName);
               }

            	fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')'
                     : '');
            }

            document.getElementById('uAddress_zoneCode').value = data.zonecode;
            document.getElementById('uAddress_addr').value = fullAddr;

            document.getElementById('uAddress_detail').focus();
         }
      }).open();
   }
});


}) // $(document).ready(function() end
		
function uleave() {
	window.open("/mypage/leave","회원탈퇴","width=600, height=500");
	
}

		
		
</script>
<div id="wrapper">
<%@ include file="/WEB-INF/views/mypage/mypagemenu.jsp" %>
<div id="content" class="right rel_up">

<div class="abs_uphead">
<h1>회원정보 수정</h1>
</div>

<form action="/mypage/profile/update" method="post">

<table class="abs_upinfo">
<tr>
	<th class="abs_upinfo_th"><label for="userpw_up">비밀번호 변경</label></th>
	<td class="abs_upinfo_td"><input type="password" id="userpw_up" name="userpw_up" placeholder="새 비밀번호"/></td>
</tr>
<tr>
	<th class="abs_upinfo_th"><label for="userpw_con">비밀번호 확인</label></th>
	<td class="abs_upinfo_td"><input type="password" id="userpw_con" placeholder="비밀번호 확인"/></td>
</tr>
<tr>
	<th class="abs_upinfo_th"><label for="uAddress_zoneCode">주소</label></th>
	<td class="abs_upinfo_td"><input type="text" id="uAddress_zoneCode" name="uAddress_zoneCode" placeholder="우편번호" style="width: 200px" readonly="readonly"/></td>
</tr>
<tr>
	<td class="abs_upinfo_td">
	<input type="text" id="uAddress_addr" name="uAddress_addr" placeholder="주소" readonly="readonly"/>
	</td>
</tr>
<tr>
	<td class="abs_upinfo_td">
		<input type="text" id="uAddress_detail" name="uAddress_detail" placeholder="상세주소"/>
		</td>
</tr>
<tr>
	<th class="abs_upinfo_th"><label for="email">이메일</label></th>
	<td class="abs_upinfo_td"><input type="text" id="email" name="email" placeholder="새 이메일"/></td>
</tr>
<tr>
	<td class="abs_upinfo_td" style="right: 170px;"><input type="text" name="atnum" id="atnum"  placeholder="인증코드" /></td>
</tr>
<tr>
	<th class="abs_upinfo_th"><label for="tel">연락처</label></th>
	<td class="abs_upinfo_td"><input type="tel" id="tel" name="tel" placeholder="ex) 01xxxxxxxxx"/></td>
</tr>
</table>
<div class="abs_deltex">
	회원탈퇴를 원하시면 우측 회원탈퇴 버튼을 눌러주세요
</div>
<div class="abs_pwup"><span class="spa" id="pwMsg"></span></div>
<div class="abs_cpwup"><span class="spa" id="cpwMsg"></span></div>
<div class="abs_em"><span  class="spa" id="emailMsg"></span></div>
<div class="abs_numc"><span class="spa" id="cor_num"></span></div>
<div class="abs_numw"><span  class="spa" id="wro_num"></span></div>
<div class="abs_tel"><span class="spa" id="telMsg"></span></div>
<div class="abs_guide"><span class="spa" id="guide" style="color:#999;display:none;"></span></div>


<button class="abs_btnup" id="btnup">변경사항 저장</button>
</form>
<button class="abs_email_in" id="mailbtn" disabled="disabled" >전송</button>
<button class="abs_email_inco" id="atnbtn" >확인</button>
<button class="abs_userleave" onclick="uleave();">회원탈퇴</button>
<button class="abs_btncancle"onclick="location.href='/mypage'">취소</button>
<button class="abs_search"  id="addr_search"><img src="/resources/image/magnifying_glass.png"></button>
</div>
</div>
</body>
</html>