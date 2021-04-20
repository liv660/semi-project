<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<!-- 스마트에디터 2 -->
<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
 
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

<script type="text/javascript">
$(document).ready(function() {
	
	$("#submit").click(function() {
		
		submitContents( $("#submit") )
		
		$("form").submit();
	});
	
	$("#cancel").click(function() {
		history.go(-1);
	});
});


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

p {margin-bottom : 0px;}

.deleteFile {margin-right : 10px;}
</style>


<div class="container">

<div>
	<h1>NOTICE</h1>
	<hr>
</div>

<form action="/notice/write" method="post" enctype="multipart/form-data">

<table class="table table-bordered">
	<tr>
		<td class="info"><label for="title">제목</label></td>
		<td colspan="2"><input type="text" id="title" name="title" /></td>
	</tr>
	
	<tr>
		<td class="info"><label for="writer">작성자</label></td>
		<td><input type="text" id="writer" name="writer" value=<%=session.getAttribute("userid") %> readonly="readonly"/></td>
		<td>중요공지 <input type="checkbox" name="check" id="check"/></td>
	
	</tr>
	
	<tr>
		<td colspan="3"><textarea id="content" name="content"></textarea></td>
	</tr>
</table>

<input type="hidden" value="<%=session.getAttribute("managerno")%>">
<input type="file" id="multi-add" class="btn-add" multiple style="display: none;" name="file">
<button type="button" class="btn-add" id="file_add">파일추가</button>
<table id="file_table">
</table>
총 크기 : <span id="totSize"> </span>

</form>

<div id="LoadImg"></div>


<div style="text-align: center;">
<input type="button" id="submit" value="글쓰기" />
</div>

</div>

<script type="text/javascript">
	var $fileListArr = new Array();
	 var $totSize = 0;
	 var $keyNum = 0;
	 var $limit = 0;
	 var $fileCount = 0;
	 
	$("#file_add").on('click', function() {
		$('#multi-add').click();
	});

	$("#multi-add").on('change',function(){

		var files = $(this)[0].files;
		var fileArr = new Array(); 

		fileArr = $fileListArr; 
	
		$limit = $totSize;

		/* 파일 사이즈 체크 해주는 부분 */ 
		for(var i = 0 ; i < files.length ; i++){
			$limit = $limit + files[i].size;
			if($limit > 10*1024*1024){
				alert("첨부파일 용량은 10MB를 넘길수 없습니다.");
				return false;
			}
		}

		/* 파일의 갯수 체크하는 부분 과 파일의 이름과 사이즈 버튼 출력 */
		for(var i = 0 ; i < files.length ; i++){
			$fileCount++; // 파일 카운트 
			if($fileCount >4) {
				alert('첨부파일은 최대 4개 입니다.');
				break;
			}

			 $('#file_table').append("<tr id=file"+ $keyNum +"><td class='txt-c'><button type='button' class='deleteFile' >&#8861;</button></td>"+
						+ "&nbsp;" + "<td>"+ files[i].name +"</td>"+
						"<td id='fileSize "+ $keyNum +"'><p class=file"+ $keyNum +">"+ " : " + Math.floor(files[i].size / 1000) +" KB</p></td>"+
						"</tr>");
			 $keyNum++;  
			 fileArr.push(files[i]);
			 $totSize = $totSize + files[i].size; 
		}

		$fileListArr = new Array();
		$fileListArr = fileArr;
		$('#totSize').text(""); 
		$('#totSize').text(Math.floor($totSize/1000) + "KB");
	}); 
	
	$(document).on("click" , '.deleteFile', function(){
		//삭제할 파일의 아이디
		var DeleteID = $(this).parent().parent().attr('id');

		//삭제하려는 파일의 크기값(텍스트)
		var DeleteFileSize = $(this).parent().next().next().children('p').text(); 

		//삭제하는 파일의 크기값(바이트) 
		var fileSizeByteArr = new  Array();
		fileSizeByteArr = DeleteFileSize.split(' ');
		var fileSize = Number(fileSizeByteArr[0]) * 1000;

		var DeleteArrNum = DeleteID.substring(DeleteID.length , DeleteID.length -1); 

		var fileArr = $fileListArr;

		fileArr.splice(DeleteArrNum , 1);
		$keyNum = 0
		$fileListArr = new Array();
		$('#file_table').children().remove();
		$totSize = 0;

		for(var i = 0 ; i < fileArr.length ; i++){

			 $('#file_table').append("<tr id=file"+ $keyNum +"><td class='txt-c'><button type='button' class='deleteFile' >&#8861;</button></td>"+
						"<td>"+ fileArr[i].name +"</td>"+
						"<td id='fileSize "+ $keyNum +"'><p class=file"+ $keyNum +">"+ " : " + Math.floor(fileArr[i].size / 1000) +" KB</p></td>"+
						"</tr>");
			 $keyNum++;
			 $fileListArr.push(fileArr[i]);
			 $totSize = $totSize + fileArr[i].size;
		}

		// 삭제된거만큼 총 용량 적용
		$limit = $totSize;
		$('#totSize').text("");
		$('#totSize').text(Math.floor($totSize/1024));
 		$fileCount--; // 파일 개수 1개 차감
	});

</script>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
})
</script>


<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

