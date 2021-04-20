<%@page import="dto.NoticeComment"%>
<%@page import="dto.NoticeFile"%>
<%@page import="java.util.List"%>
<%@page import="dto.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<% Notice view = (Notice) request.getAttribute("view"); %>
<% List<NoticeFile> file = (List) request.getAttribute("filelist"); %>

<script type="text/javascript">

function confirmDelete() {
	
	var con = confirm("정말 삭제하시겠습니까?");
	
	if(con == true) {
		location.href = "/notice/delete?noticeno=<%=view.getNoticeNo()%>"
	}
}

</script>

<style type="text/css">

.wrapBox {
	width : 1200px;
	margin : 0 auto;
	padding-left : 200px;
}

.content {
	width : 80%;
	height : 300px;
	margin-top: 30px; 
	border : 1px solid #A48654;
}

.right {
	padding-left: 500px;
	padding-bottom: 5px;
}

.line {
	border-top : 1px solid #ccc;
	width: 80%;
	margin-bottom: 10px;
	margin-top: 10px;
}

.wrapBox h1 {
	color : #EA9A56;
	text-transform: uppercase;
	font-weight: 500px;
	font-family: sans-serif;
	display: inline;

}

.manage { margin-left : 550px;}
.delete {margin-left : 10px;}
.writebtn {margin-left: 700px; margin-bottom: 50px;}

input[type = "button"] {
	border : none;
	background : none;
	text-align: center;
	padding: 5px 5px;
	outline: none;
	color: #000;
	border-radius: 24px;
	transition: 0.25s;
	cursor: pointer;
	margin-top : 20px;
 } 

.orange:hover {background: #FBE1AE;}
.red:hover {background: #FF6D6D;}

.imgbox {
	width: 1100px;
	margin: 0 auto;
	margin-top : 30px;
}

.imgbox img {
	width: 200px;
	height: 200px;
}

#lightbox {
  position: fixed;
  width:100%;
  height:100%;
  background-color:rgba(0,0,0,0.7);
  top:0;
  left:0;
  display:none;
}

#lightbox img {
  position:absolute;
  top:50%;
  left:50%;
  transform:translate(-50%, -50%);
  border:1px solid #eee;      
}

#comment {
width : 500px;
height : 70px;
}

.commentwrap {
	border-bottom: 1px solid #000;
}


</style>

<div class="wrapBox">



	<h1>Notice</h1>
<%-- 	<% if(session.getAttribute("manager") != null) { %> --%>
		<a href="/notice/update?noticeno=<%=view.getNoticeNo()%>"><input type="button" value="수정" class="manage orange"></a>
		<input type="button" value="삭제" class="red delete" onclick="confirmDelete();"/>
<%-- 	<% } %> --%>
	<div class="line"></div>
	
	<table>
		<tr>
			<th>제목 &nbsp; : &nbsp; </th>
			<td><%=view.getTitle() %></td>
		
			<th class="right">조회수 &nbsp; : &nbsp; </th>
			<td><%=view.getViews() %></td>
		</tr>
		
		<tr>
			<th>작성자 &nbsp; : &nbsp; </th>
			<td><%=view.getManagerId() %> 
			
			<th class="right">작성일 &nbsp; : &nbsp; </th>
			<td><%=view.getCreateDate() %></td>
		</tr>
		
	</table>
	
	<input type="hidden" id="noticeno" value="<%=view.getNoticeNo()%>">
	<input type="hidden" id="nick" value="<%=session.getAttribute("nick") %>">
	<input type="hidden" id="userno" value="<%=session.getAttribute("userno")%>">
	
	
	<div class="imgbox">
		<% for( int i=0; i<file.size(); i++) { %>
			<img src="<%=request.getContextPath()%>/upload/<%=file.get(i).getStoredName() %>"
				data-src="<%=request.getContextPath()%>/upload/<%=file.get(i).getStoredName() %>"
				 class="pic">
		<% } %>
		<br>
	</div>
	<div id="lightbox">
		<img alt="" src="" id="lightboxImage">
	</div>

	<div class="content">
	<%=view.getContent() %>
	</div>
	
	<a href="/notice/write"><input type="button" value="글쓰기" class="writebtn"/></a>
	<a href="/notice/list"><input type="button" value="목록" /></a>
	
	<h3>댓글</h3>
	
	<input type="text" id=comment name="comment" />
	<input type="button" id="commentUpdatebtn" value="댓글 등록"/>
	
	<div id="commentwrap">
	
	</div>
</div>


<script type="text/javascript"> 

/* 댓글목록 조회 */
$(document).ready(function() {
	commentlist();
})

/* .pic 인 이미지들의 배열 */
var pics = document.getElementsByClassName("pic");

/* 이미지에 클릭 이벤트 등록 */
for(var i=0; i<pics.length; i++) {
	pics[i].addEventListener("click", showPopup);
}

/* 클릭시 이미지저장경로와 display속성 부여 */
function showPopup() {
	var imageLocation = this.getAttribute("data-src");
	lightboxImage.setAttribute("src", imageLocation);
	lightbox.style.display = "block";
}

/* 팝업 클릭시 창닫음 */
lightbox.onclick = function() {
	lightbox.style.display = "none";
};


/* 댓글 목록조회 */
function commentlist() {
	
	var noticeno = $("#noticeno").val();
	
	$.ajax({
		type : 'get',
		url : '/notice/commentlist',
		data : {'noticeno' : noticeno},
		dataType : 'json',
		success : function(data) {
			var jsontext = JSON.stringify(data);
			var commentlist = JSON.parse(jsontext);

			for(var i=0; i<commentlist.length; i++) {
				
				var html = '';
				
				html += "<div class='commentwrap'> <span class='commnetNick'>"
				html += commentlist[i].nick
				html += "</span> <span class='commentDate'>"
				html += commentlist[i].commentDate
				html += "</span>"
				html += "<input type='button' onclick = 'commentUpdateTrans(" + commentlist[i].commentNo + ")' id='updatebtn" + commentlist[i].commentNo + "' value='수정'/>"
				html += "<input type='button' onclick = 'commentDelete(" + commentlist[i].commentNo + ")' id='deletebtn" + commentlist[i].commentNo + "' value='삭제'/>"
				html += "<br> <div id='comwrap" + commentlist[i].commentNo + "'> <span class='commentText' id='commentText" + commentlist[i].commentNo + "'> "
				html += commentlist[i].commentText
				html += "</span> </div>"
				
				$("#commentwrap").append(html);
			}
			
		}
	})
}	
	

/* 댓글 추가 */
$("#commentUpdatebtn").click(function() {
	
	var noticeno = $("#noticeno").val();
	var comment = $("#comment").val();
	var nick = $("#nick").val();
	var userno = $("#userno").val();
	
	$.ajax({
		type : 'post',
		url : '/notice/commentinsert',
		data : {'noticeno' : noticeno
				, 'comment' : comment
				, 'nick' : nick
				, 'userno' : userno},
		success : function() {
			$("#comment").val("");
			$("#commentwrap").html("");
			
			commentlist();
		}
		
	})
	
})

/* 댓글 삭제 */
function commentDelete(commentno) {
	
	$.ajax({
		type : 'post',
		url : '/notice/commentdelete',
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
		url: '/notice/commentupdate',
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


<%@ include file="/WEB-INF/views/layout/footer.jsp" %>


