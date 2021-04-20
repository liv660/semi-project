<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<!-- 스마트 에디터 2 -->
<script type="text/javascript"
	src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>


<!-- <form>태그의 submit을 수행하면 editor에 작성한 내용을 <textarea>에 반영 -->
<script type="text/javascript">
function submitContents( elClickedObj ) {
	
	//에디터의 내용을 #content에 반영한다
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	
	try {
		// <form>태그의 submit 수행
		elClickedObj.form.submit();
	} catch(e) {}
	
}
</script>

<%! int index = 0; %>

<script type="text/javascript">
$(document).ready(function() {
	
<%-- 	<% session.removeAttribute("reviewSort"); %> --%>
	
	//작성버튼
	$("#btnWrite").click(function() {
		
// 		index = $("#select option").index($("#select option:selected")) + 1;
// 		alert(index + '번째 선택');

// 		if(index == 1) {
<%-- 			<% session.setAttribute("reviewSort",  "1"); %>	 --%>
// 		}
// 		else if(index == 2) {
<%-- 			<% session.setAttribute("reviewSort",  "2"); %>	 --%>
// 		}
// 		else if(index == 3) {
<%-- 			<% session.setAttribute("reviewSort",  "3"); %>	 --%>
// 		}
		
		submitContents($("#btnWrite"))
		$("form").submit();
	});

	//취소버튼
	$("#btnCancel").click(function() {
		history.go(-1);
	});
	
});

</script>

<style type="text/css">
#content {
/* 	width: 100%; */
	width: 98%;
}

table {
	width: 1100px;
}

</style>

<div class="container">

<h3 style="text-align: center;">후기 작성</h3>
<hr>

<div>
<form action="/review/write" method="post" enctype="multipart/form-data">

<table>
<tr>
	<td class="info">분류</td>
	<td>
		<select name="review" id="select">
			<option value="1" selected="selected">스토어 후기</option>
			<option value="2">유기동물 찾아준 후기</option>
			<option value="3">반려동물 찾은 후기</option>
		</select>
	</td>
</tr>
<tr>
	<td class="info">제목</td>
	<td colspan="3"><input type="text" name="title" style="width:90%"/></td>
</tr>
<tr>
	<td class="info"  colspan="4">내용</td>
</tr>
<tr>
	<td colspan="4"><textarea class="form-control" 
			style="width: 95%; height: 300px;" name="content" id="content"></textarea></td>
</tr>
</table>

파일 업로드 <input type="file" name="file" />

</form>
</div>
<br>

<div class="text-center">	
	<button type="button" id="btnCancel" class="btn">취소</button>
	<button type="button" id="btnWrite" class="btn">작성</button>
</div>

</div>

<br><br>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content", // 에디터가 적용될 <textarea>의 id를 입력
	sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
})
</script>

</body>
</html>