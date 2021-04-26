<%@page import="dto.FindImg"%>
<%@page import="dto.FindBoard"%>
<%@page import="dto.Usertb"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%  Usertb u = (Usertb) request.getAttribute("param"); %>
<%	FindBoard b = (FindBoard) request.getAttribute("viewFindBoard"); %>
<%	List<FindImg> findImg = (List) request.getAttribute("findImg"); %>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<script type="text/javascript">
$(document).ready(function() {
	
	//목록버튼 동작
	$("#btnList").click(function() {
		$(location).attr("href", "/find/list");
	});
	
	//수정버튼 동작
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/find/update?FindNo=<%=b.getFindNo() %>");
	});
	//삭제버튼 동작
	$("#btnDelete").click(function() {		
		if( confirm("게시글을 삭제하시겠습니까?") ) {
			$(location).attr("href", "/find/delete?FindNo=<%=b.getFindNo() %>");
		}		
	});
	
});
</script>


<!-- 댓글 관련 -->
<script type="text/javascript">
/* 댓글목록 조회 */
$(document).ready(function() {
	commentlist();
	
   $(document).on('click', '#foldbtn', function() {
	      
	      $('.fold').css('display','block');
	      $('#foldbtn').css('display','none');
	   })
})
// $("#commentwrap").click(
/* 댓글 목록조회 */
function commentlist() {
	
	var findNo = $("#FindNo").val();
	
	$.ajax({
		type : 'get',
		url : '/find/commentlist',
		data : {'findNo' : findNo},
		dataType : 'json',
		success : function(data) {
			var jsontext = JSON.stringify(data);
			var commentlist = JSON.parse(jsontext);
			for(var i=0; i<commentlist.length; i++) {
				
				var html = '';
				
	            
	            if(commentlist[i].commentCnt != null) {
	               var commentCnt = commentlist[i].commentCnt;
	            }
	            
	            if(i > 4) {
	               html += "<div class='fold'>";
	            }
	            html += "<div class='commentwrap'>"
	            html += "<div class='commentImg'> <img src='"
	            if(commentlist[i].storedName == "basic.png" || commentlist[i].storedName == null) {
	               html += "/resources/image/basic.png"
	            } else {
	               html += "/userimgup/" + commentlist[i].storedName
	            }
	            html += " '/> </div>"
	            html += "<div class='commentNick'>" + commentlist[i].nick + "</div>"
	            html += "<div class='commentDate'>" + commentlist[i].commentDate + "</div>"
	            if( $("#userno").val() == commentlist[i].userNo) {
	            html += "<div class='commentBtn'>"
	            html += "<input type='button' class='combtn' onclick = 'commentUpdateTrans(" + commentlist[i].commentNo + ")' id='updatebtn" + commentlist[i].commentNo + "' value='수정'/>"
	            html += "<input type='button' class='combtn' onclick = 'commentDelete(" + commentlist[i].commentNo + ")' id='deletebtn" + commentlist[i].commentNo + "' value='삭제'/>"
	            html += "</div>"
	            }
				html += "<div class='commentText' id='comwrap" + commentlist[i].commentNo + "'>" 
				html += "<span class='commentText' id='commentText" + commentlist[i].commentNo + "'> " + commentlist[i].commentText + "</span>"
				html += "</div>"
	    	    if( i == commentlist.length-1) {
	               html += "</div>"
	            }
	            if( i == 4) {
	               html += "<input type='button' id='foldbtn' value='댓글 더보기'>"
	            }
				
				$("#commentwrap").append(html);
			}/* for문 끝 */
	         $("#commentCnt").html("");
	         $("#commentCnt").append(commentCnt);
			
		}/* success끝 */
		
	})/* ajax끝 */
	
}//click 이벤트 끝	
$(document).ready(function() {
/* 댓글 추가 */
$("#commentUpdatebtn").click(function() {
	
	
	var findNo = $("#FindNo").val();
	var comment = $("#comment").val();
	var nick = $("#nick").val();
	var userno = $("#userno").val();
	console.log(findNo);
	
	$.ajax({
		type : 'post',
		url : '/find/commentinsert',
		data : {'findNo' : findNo
				, 'comment' : comment
				, 'nick' : nick
				, 'userno' : userno},
		success : function() {
			$("#comment").val("");
			$("#commentwrap").html("");
			
			commentlist();
		}	//success
		
	})	//ajax
	
})//click
})//document
/* 댓글 삭제 */
function commentDelete(commentno) {
	
	$.ajax({
		type : 'post',
		url : '/find/commentdelete',
		data : {'commentno' : commentno},
		success : function() {
			
			$("#commentwrap").html("");
			
			commentlist();
		}
			
	})
}
/* 댓글 수정 */
function commentUpdateTrans(commentno) {
	
	var contentText = $('#commentText' + commentno).text();
	
	$('#updatebtn' + commentno).css('display', 'none');
	$('#deletebtn' + commentno).css('display', 'none');
	
	var html = '';
	
	html += "<input type='text' id='comupdate' value='" + contentText + "' style='width:300px; height:40px;'/>";
	html += "<input type='button' id='updateConfirm' onclick='commentUpdate(" + commentno + ")' value='수정'/>"
	html += "<input type='button' id='canclebtn' onclick='updatecancle()' value='취소'/>"
	
	$('#comwrap' + commentno).html(html)
	
	commentUpdateFocus();
}
/* 수정버튼 클릭 */
function commentUpdate(commentno) {
	
	var comment = $('#comupdate').val();
	
	$.ajax({
		type: 'post',
		url: '/find/commentupdate',
		data: { 'commentno' : commentno
				,'comment' : comment},
		success : function() {
			
			$("#commentwrap").html("");
			
			commentlist();
		}
	})
}
/* 취소버튼 클릭 */
function updatecancle() {
	
	$("#commentwrap").html("");
	
	commentlist();
}
</script>


<style type="text/css">
.container h1 {
	display: inline-block;
}
.container .complete {
	width : 500px;
	display : inline-block;
	position : relative;
}
.container .complete #completebtn {
	position : absolute;
	left : 800px;
}
.container .complete #completeMsg {
	position : absolute;
	left : 800px;
	color : red;
	width: 80px;
}

.head {
	text-align: center;
	font-size: 16px;
}

.head #findheader{
	border:1px solid; 
	float: left;
	width: 700px;
	margin: 10px 3px 10px 3px;
}
.head #findheader1{
	border:1px solid; 
	float: left;
	width: 200px;
	margin: 10px 3px 10px 3px;
}
#subimages{
	width: 148px;
	height: 97px;
	border-radius: 5px;
}
#mainimages{
	width: 398px;
	height: 307px;
	border-radius: 5px;
}
.mainimg{
	position: absolute;
	width: 400px;
	height: 310px;
	border: 1px solid #A48654;
	border-radius: 5px;
}
.subimg-grid {
	display: inline-grid;
	grid-template-rows: 100px 100px 100px;
	grid-row-gap: 3px;
	margin: 0 0 0 405px;
	width: 150px;
	height: 309px;
}
.subimg-grid div {
	border: 1px solid #A48654;
	border-radius: 5px;
}
#findinfo{
	width: 450px;
	float: right;
	margin: 2%;
}
#findinfo1{
	border:2px solid;
	margin: 10px 3px 10px 3px;
	padding: 2%;
	text-align: center;
}
#comment {
width : 500px;
height : 30px;
}
#button{
	float: right;
	margin: 0px 0 0px 50px;
}
#lightbox {
  position: fixed;
  width:100%;
  height:100%;
  background-color:rgba(0,0,0,0.7); 
  top:0%;
  left:0%;
  display:none;
}
#lightbox img {
  position:absolute; 
  top:50%;
  left:50%;
  transform:translate(-50%, -50%);
  border:1px solid #eee;      
}
#commentwrap .commentwrap .commentImg {
   width: 30px;
   height : 30px;
   margin-right : 10px;
   display : inline-block;
}
#commentwrap .commentwrap .commentImg img {
   width : 100%;
   height : 100%;
   object-fit : cover;
   border-radius: 50%;
}
#commentwrap .commentwrap .commentDate {
   left : 100px;
   display : inline-block;
}
#commentwrap .commentwrap .commentNick {
   display : inline-block;
}
#commentwrap .commentwrap .commentBtn {
   display : inline-block;
   left : 100px;
}
#commentwrap .fold {
   display : none;
}
#commentwrap #foldbtn {
   width : 800px;
   border : none;
   margin-top : 20px;
}

#btnUpdate:hover{color: white;}
#btnList:hover{color: white;}
#btnDelete:hover{color: red;}
#commentUpdatebtn:hover{color: #A48654;}
</style>

<div class="container">

<h1>반려동물 찾기</h1>
<%	if(session.getAttribute("login") == null || !(boolean)session.getAttribute("login")) { %>
<div style="height: 250px; padding: 100px 0;">
	<h3 style="text-align: center">로그인이 필요합니다.</h3>
</div>
<% } else {  %>
<div class="complete">
<% if( ((Integer)session.getAttribute("userno")) == b.getUserNo() && b.getFind_complete() == null) { %>
<input type="button" id="completebtn" value="완료" onclick="complete();">
<% } %>

<% if(b.getFind_complete() != null) {%>
<span id='completeMsg'>찾기 완료</span>
<% } %>
</div>


<hr>

<input type ="hidden" name ="FindNo" id ="FindNo" value="<%=request.getParameter("FindNo") %>" />
<input type="hidden" id="nick" value="<%=session.getAttribute("nick") %>">
<input type="hidden" id="userno" value="<%=session.getAttribute("userno")%>">
	
<div class="head">

<div id="findheader"><%=b.getTitle() %></div>
<div id="findheader1"><%=request.getAttribute("nick") %></div>
<div id="findheader1"><%=b.getCreateDate() %></div>

</div>

<div id="findinfo">		
	<div id="findinfo1">반려동물 종류 : <%=b.getPetKinds() %></div>
	<div id="findinfo1">반려동물 이름 : <%=b.getPetName() %></div>
	<div id="findinfo1">반려동물 나이 : <%=b.getPetAge() %></div>
	<div id="findinfo1">잃어버린 위치 : <%=b.getLoc() %></div>
	<div id="findinfo1">이메일 : <%=request.getAttribute("email") %></div>
</div>



<%-- <%	if( findImg != null ) { %> --%>
<% int i = findImg.size(); %>
	<%	if(i <= 0) {%>	
	
	<div id="mainimg" class="mainimg"></div>
	<div class="subimg-grid">
		<div id="subimg1"></div>
		<div id="subimg2"></div>
		<div id="subimg3"></div>
	</div>

	<%}	if(i < 2 && i > 0) {%>
	
	<div id="mainimg" class="mainimg"><img src="/upload/<%=findImg.get(0).getStoredImg() %>" id="mainimages" class="subimages"/></div>
	<div class="subimg-grid">
<!-- 		<div id="subimg1"></div> -->
<!-- 		<div id="subimg2"></div> -->
<!-- 		<div id="subimg3"></div> -->
	</div>

	<%}	if(i < 3 && i > 1) {%>

	<div id="mainimg" class="mainimg"><img src="/upload/<%=findImg.get(0).getStoredImg() %>" id="mainimages" class="subimages"/></div>
	<div class="subimg-grid">
		<div id="subimg1"><img src="/upload/<%=findImg.get(1).getStoredImg() %>" id="subimages" class="subimages" /></div>
<!-- 		<div id="subimg2"></div> -->
<!-- 		<div id="subimg3"></div> -->
	</div>

	<%}	if(i < 4 && i > 2) {%>
		
	<div id="mainimg" class="mainimg"><img src="/upload/<%=findImg.get(0).getStoredImg() %>" id="mainimages" class="subimages"/></div>
	<div class="subimg-grid">
		<div id="subimg1"><img src="/upload/<%=findImg.get(1).getStoredImg() %>" id="subimages" class="subimages" /></div>
		<div id="subimg2"><img src="/upload/<%=findImg.get(2).getStoredImg() %>" id="subimages" class="subimages" /></div>
<!-- 		<div id="subimg3"></div> -->
	</div>	

	<%}	if(i < 5 && i > 3) {%>
	<div id="mainimg" class="mainimg"><img src="/upload/<%=findImg.get(0).getStoredImg() %>" id="mainimages" class="subimages"/></div>
	<div class="subimg-grid">
		<div id="subimg1"><img src="/upload/<%=findImg.get(1).getStoredImg() %>"  id="subimages" class="subimages" /></div>
		<div id="subimg2"><img src="/upload/<%=findImg.get(2).getStoredImg() %>"  id="subimages" class="subimages" /></div>
		<div id="subimg3"><img src="/upload/<%=findImg.get(3).getStoredImg() %>"  id="subimages" class="subimages" /></div>
	</div>	

	<% } %><!-- if문 끝 -->

<div id="lightbox">
	<img alt="" src="" id="lightboxImage" />
</div>

<div style="width: 1100px; height: 300px; border: 1px solid; margin: 10px 0 10px 0;">
<!-- <p style="width: 1100px; height: 300px; border: 1px solid; margin: 10px 0 10px 0; ">123</p> -->
<p ><%=b.getContent() %></p>
</div>


	

<div class="text-left">	
<%	if( request.getAttribute("nick").equals(session.getAttribute("nick")) ) { %>
	<button id="btnUpdate" class="btn" style="background-color:#FFC091;">글수정</button>
	<button id="btnDelete" class="btn">글삭제</button>
<%	} %>
</div>
<hr>

<div style="height: 100px;">
	<h3>댓글<span id="commentCnt"></span></h3>
	
	<input type="text" id=comment name="comment" />
	<input type="button" class="btn" id="commentUpdatebtn" value="댓글 등록"/>
	
	<div id="commentwrap">
<!-- 	<h1>댓글목록</h1> -->
	</div>
</div>

<div class="text-center" style="height: 50px;">	
	<button id="btnList" class="btn" style="background-color:#EA9A56;">목록</button>
</div>
</div>
<% } %>
<script type="text/javascript">
/* .pic 인 이미지들의 배열 */
var pics = document.getElementsByClassName("subimages");
/* 이미지에 클릭 이벤트 등록 */
for(var i=0; i<pics.length; i++) {
   pics[i].addEventListener("click", showPopup);
}
/* 클릭시 이미지저장경로와 display속성 부여 */
function showPopup() {
   var imageLocation = this.getAttribute("src");
   lightboxImage.setAttribute("src", imageLocation);
   lightbox.style.display = "block";
}
/* 팝업 클릭시 창닫음 */
lightbox.onclick = function() {
	lightbox.style.display = "none";
};
function complete() {
	var con = confirm("정말 완료 하시겠습니까? \n완료 이후에는 변경할 수 없습니다.")
	if(con == true) {
		$.ajax({
			
			type : 'get'
			, url : '/find/complete'
			, data : { 'findno' : $('#FindNo').val()}
			, success : function() {
			
				var html = '';
				
				html += "<span id='completeMsg'>찾기 완료</span>"
				
				
				$('.complete').html(html);
				
				
			}
		
		})
		
	}
	
}
	
	
</script>



<%@ include file="/WEB-INF/views/layout/footer.jsp" %>








<!-- 	<div class="imgbox"> -->
<%-- 		<% for( int i=0; i<file.size(); i++) { %> --%>
<%-- 			<img src="<%=request.getContextPath()%>/upload/<%=file.get(i).getStoredName() %>" --%>
<%-- 				data-src="<%=request.getContextPath()%>/upload/<%=file.get(i).getStoredName() %>" --%>
<!-- 				 class="pic"> -->
<%-- 		<% } %> --%>
<!-- 		<br> -->
<!-- 	</div> -->
<!-- 	<div id="lightbox"> -->
<!-- 		<img alt="" src="" id="lightboxImage"> -->
<!-- 	</div> -->







>>>>>>> Stashed changes
