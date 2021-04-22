<%@page import="dto.NoticeFile"%>
<%@page import="java.util.List"%>
<%@page import="dto.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% Notice notice = (Notice) request.getAttribute("notice"); %>

<% List<NoticeFile> list = (List) request.getAttribute("list"); %>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
function submitContents( elClickedObj ) {
	
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	
	try {
		elClickedObj.form.submit();
	} catch(e) {}
	
}
</script>

<script type="text/javascript">
$(document).ready(function() {
	

	//수정버튼 동작
	$("#btnUpdate").click(function() {
		
		//스마트 에디터의 내용을 <textarea>에 적용하는 함수를 호출한다
		submitContents( $("#btnUpdate") )
		
		//<form> submit
		$("form").submit();
	});
	
	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
	
	
});

var fileArray = new Array();

function deletefile(item) { 
	let fileName = $('#' + item).text();
	
	$('#'+item).html("");
	$('#btn'+item).css('display','none');
	
	fileArray.push(fileName);
	
	$('#filelist').val(fileArray);
	
// 	$('#'+item).html("<input type='file' name='file' />")
	
	$('#fileupload').append($('#'+item).html("<input type='file' name='file' />"));
	
}

</script>

<style type="text/css">
#content {
	width: 98%;
	height : 300px;
	
}

#title {
	width : 400px;
}

input[type = "button"] {
	border : 0;
	background : none;
	margin: 40px auto;
	text-align: center;
	border : 2px solid #FFC091;
	padding: 14px 40px;
	outline: none;
	border-radius: 24px;
	transition: 0.25s;
	cursor: pointer;
}

.container h1 {
	color : #EA9A56;
	text-transform: uppercase;
	font-weight: 500px;
	font-family: sans-serif;
	display: inline;

}

</style>


<div class="container">

<div>
	<h1>NOTICE</h1>
	<hr>
</div>

<form action="/notice/update" method="post" enctype="multipart/form-data">

<table class="table table-bordered">
	<tr>
		<td class="info"><label for="title">제목</label></td>
		<td colspan="2"><input type="text" id="title" name="title" value="<%= notice.getTitle()%>"/></td>
	</tr>
	
	<tr>
		<td class="info"><label for="writer">작성자</label></td>
		<td><input type="text" id="writer" name="writer" value=<%=notice.getManagerId()%> readonly="readonly"/></td>
		<td>중요공지 <input type="checkbox" name="check" id="check"/></td>
	</tr>
	
	<tr>
		<td colspan="3"><textarea id="content" name="content"><%=notice.getContent() %></textarea></td>
	</tr>
</table>

<input type="hidden" value="<%=session.getAttribute("managerno")%>" name="managerno" />
<input type="hidden" id="filelist" name="filelist" />
<input type="hidden" id="noticeno" name="noticeno" value="<%=notice.getNoticeNo() %>" />

<% for( int i=list.size(); i<4; i++) { %>
<input type="file" name="file" />
<% } %>


<div id="fileupload">
<% for(int i=0; i<list.size(); i++) {%> 
<div id="fileitem<%=i%>">
	<span id="item<%=i %>"><%=list.get(i).getOriginName() %></span> <button type="button" id=btnitem<%=i %> onclick="deletefile('item<%=i %>');">X</button><br>
</div>
<% } %>
</div>

</form>

<div style="text-align: center;">
<input type="button" id="btnUpdate" value="수정" />
</div>

</div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content", //에디터가 적용될 <textarea>의 id를 입력
	sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
})
</script>

</body>
</html>