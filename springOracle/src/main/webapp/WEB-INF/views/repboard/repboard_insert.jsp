<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="parent_no" value="${requestScope.parent_no}"></c:set>

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/repboard_insert.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
<script>
	$(function() {
		console.log('${parent_no}');
		$("form#insertForm").submit(function() {
			var $data = "parent_no="+${parent_no}+"&"+ $("form").serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/repboard/insert",
				method : "post",
				data : $data,
				success : function(responseData) {
					var data = responseData.trim();
					if (data == '-1') {
						alert('게시글 작성에 실패 하였습니다.');
					} else {
						location.href="${pageContext.request.contextPath}/repboard/repboarddetail?no=" + data;
						/* $.ajax({
							url : "${pageContext.request.contextPath}/repboard/repboarddetail",
							method : "get",
							data : { "no" : data },
							success : function(responseData) {
								var $parentObj = $("section");
								if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
									$parentObj = $("body");
								}
								$parentObj.empty();
								var tmp = $parentObj.html(responseData).find("article")
								$parentObj.html(tmp);
							}
						}); */
					}
				}
			});
			return false;
		});

		$("input[name=cancel]").click(function() {
			if('${parent_no}'!=0){
				location.href="${pageContext.request.contextPath}/repboard/repboarddetail?no=${parent_no}"
			}else{
				location.href="${pageContext.request.contextPath}/repboard/repboardlist";
			}
			/* $.ajax({
				url : "${pageContext.request.contextPath}/repboard/repboardlist",
				method : "get",
				success : function(responseData) {
					var $parentObj = $("section");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					$parentObj.empty();
					var tmp = $parentObj.html(responseData).find("article")
					$parentObj.html(tmp);
				}
			}); */
			return false;
		});
	});
</script>
</head>

<body>
	<article>
		<form id="insertForm">
			<table>
				<tbody>
					<tr>
						<td>제목</td>
						<td>
							<input type="text" name="subject" placeholder="제목을 입력하세요" required="required">
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="password" placeholder="비밀번호를 입력하세요" required="required">
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<input type="text" name="content" placeholder="내용을 입력하세요" required="required">
						</td>
					</tr>
					<tr>
						<td>
							<input type="submit" name="insert" value="글 작성">
							<input type="button" name="cancel" value="취소">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</article>
</body>
</html>