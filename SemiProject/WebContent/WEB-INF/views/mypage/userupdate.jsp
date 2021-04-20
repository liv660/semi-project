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
	right: 170px;
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

span {
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function user_DaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('user_postcode').value = data.zonecode;
                document.getElementById("user_roadAddress").value = roadAddr;
                document.getElementById("user_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("user_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("user_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

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
	<th class="abs_upinfo_th"><label for="user_postcode">주소</label></th>
	<td class="abs_upinfo_td"><input type="text" id="user_postcode" name="user_postcode" placeholder="우편번호"/></td>
</tr>
<tr>
	<td class="abs_upinfo_td">
	<input type="text" id="user_roadAddress" name="user_roadAddress" placeholder="도로명주소"/>
	<input type="text" id="user_jibunAddress" name="user_jibunAddress" placeholder="지번주소"/>
	</td>
</tr>
<tr>
	<td class="abs_upinfo_td">
		<input type="text" id="user_detailAddress" name="user_detailAddress" placeholder="상세주소"/>
		<input type="text" id="user_extraAddress" name="user_extraAddress" placeholder="참고항목"/>
		</td>
</tr>
<tr>
	<th class="abs_upinfo_th"><label for="email">이메일</label></th>
	<td class="abs_upinfo_td"><input type="text" id="email" name="email" placeholder="새 이메일"/></td>
</tr>
<tr>
	<td class="abs_upinfo_td"><input type="text" name="atnum" id="atnum" placeholder="인증코드" /></td>
</tr>
<tr>
	<th class="abs_upinfo_th"><label for="tel">연락처</label></th>
	<td class="abs_upinfo_td"><input type="tel" id="tel" name="tel" placeholder="ex) 01xxxxxxxxx"/></td>
</tr>
</table>
<div class="abs_deltex">
	회원탈퇴를 원하시면 우측 회원탈퇴 버튼을 눌러주세요
</div>
<div class="abs_pwup"><span id="pwMsg"></span></div>
<div class="abs_cpwup"><span id="cpwMsg"></span></div>
<div class="abs_em"><span id="emailMsg"></span></div>
<div class="abs_numc"><span id="cor_num"></span></div>
<div class="abs_numw"><span id="wro_num"></span></div>
<div class="abs_tel"><span id="telMsg"></span></div>
<div class="abs_guide"><span id="guide" style="color:#999;display:none;"></span></div>


<button class="abs_btnup" id="btnup">변경사항 저장</button>
</form>
<button class="abs_email_in" id="mailbtn" disabled="disabled" >전송</button>
<button class="abs_email_inco" id="atnbtn" >확인</button>
<button class="abs_userleave" onclick="uleave();">회원탈퇴</button>
<button class="abs_btncancle"onclick="location.href='/mypage'">취소</button>
<button class="abs_search" onclick="user_DaumPostcode();"><img src="/file/magnifying_glass.png"></button>
</div>
</div>
</body>
</html>