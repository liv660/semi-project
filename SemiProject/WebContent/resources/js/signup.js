$(document).ready(function() {
	
	
	var uidReg = /^[A-Za-z0-9]{8,}$/
	var upwReg = /^[A-Za-z0-9]{8,}$/
	var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i
	var telReg = /^\d{3}\d{3,4}\d{4}$/;
	var idFlag = "";
	var pwFlag = "";
	var ckFlag = "";
	var emFlag = "";
	var numFlag = "";
	var telFlag = "";
	var idchFlag = "";
	var nickchFlag = "";
	
		//#id 검증
		$("#id").keyup(function() {
			if( !uidReg.test( $("#id").val())) {
				$("#idMsg_cor").html("");
				$("#idMsg").html("8자 이상 영문/숫자로 입력");
				$("#idbtn").attr('disabled', true);
				idFlag = "false";
			} else {
				$("#idMsg").html("");
				idFlag = "true";
				$("#idbtn").attr('disabled', false);
			}
		})
		
		//#pw 검증
		$("#pw").keyup(function() {
		
			if(!upwReg.test($("#pw").val())) {
				$("#pwMsg").html("8자 이상 영문/숫자로 입력");
				pwFlag = "false";
			} else {
				$("#pwMsg").html("");
				pwFlag = "true";
			}
			
			if($("#pw").val() == $("#cpw").val()) {
				$("#cpwMsg").html("");
			}
		})
		
		//#cpw 검증
		$("#cpw").keyup(function() {
			if($("#pw").val() != $("#cpw").val()) {
				$("#cpwMsg").html("비밀번호 불일치");
				ckFlag = "false";
			} else {
				$("#cpwMsg").html("");
				ckFlag = "true";
			}
		})
		
		//#email 검증
		$("#email").keyup(function() {
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
		
		//#tel 검증
		$("#tel").keyup(function() {
			if(!telReg.test($("#tel").val())) {
				$("#telMsg").html("양식이 맞지 않습니다")
				telFlag = "false";
			} else {
				$("#telMsg").html("");
				telFlag = "true";
			}
		})		
	
		//입력 검증
		$("#submit").click(function() {
			if($("#id").val() == "" || idFlag == "false") {
				alert('ID를 확인해주세요');
				return false;		
			}
			
			if(idchFlag == "false") {
				alert('ID 중복검사를 해주세요');
				return false;		
			}
			
			if(pwFlag == "false" || $("#pw").val() == "") {
				alert('PW를 확인해주세요');
				return false;
			}
			
			if(ckFlag == "false" || $("#cpw").val() == "") {
				alert('비밀번호가 일치하지않습니다.');
				return false; 
			}
			
			if($("#nick").val() == "") {
				alert('닉네임을 입력해 주세요');
				return false;
			}
			
			if(nickchFlag == "false") {
				alert('닉네임 중복검사를 해주세요');
				return false;		
			}
	
			if($("#year").val() == "" || $("#month").val() == "" || $("#day").val() == "") {
				alert('생년월일을 입력해 주세요');
				return false;
			}
			
			if($("#name").val() == "") {
				alert('이름을 입력해 주세요');
				return false;
			}
			
			if(emFlag == "false" || $("#email").val() == "") {
				alert('이메일을 확인해 주세요');
				return false;
			}
			
			if(numFlag == "false" || $("#atnum").val() == "") {
				alert('인증번호를 확인해 주세요');
				return false;
			}
			
			if(telFlag == "false" || $("#tel").val() == "") {
				alert('전화번호를 입력해 주세요');
				return false;
			}
			
			if($("#postnum").val() == "" || $("#addr").val() == "" || $("#addrDetail").val() == "" ) {
				alert('주소를 입력해 주세요');
				return false;
			}

		})
		
		//이메일 인증번호 발송
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
			
		//아이디 중복검사
		$("#idbtn").click(function() {
			var id = $("#id").val();
			
				$.ajax({
					type: 'post',
					url: '/login/idcheck',
					data: {id:id},
					success : function(data) {
						if(data > 0) {
							$("#idMsg_cor").html("");
							$("#idMsg").html("중복된 아이디 입니다.");
							idchFlag = false;
						} else {
							$("#idMsg").html("");
							$("#idMsg_cor").html("사용가능한 아이디 입니다.");
							idchFlag = true;
						}
					}
				})
		}) //$("#idbtn").click end
		
		//닉네임 중복검사
		$("#nickbtn").click(function() {
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
		
	
}) //$(document).ready end

//주소검색 api
$(function aa() {
	   $('#search_addr_btn').click(function() {
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