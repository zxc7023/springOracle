<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
<script>
	$(function() {
		$("form#insertForm").submit(function() {
 			$.ajax({
				url : "insert",
				method : "post",
				data : $("form").serialize(),
				success : function(responseData) {
					var data = responseData.trim();
					if (data == '1') {
						alert('게시글 작성이 완료 되었습니다.');
 						$.ajax({
							url : "repboardlist",
							method : "get",
							success : function(responseData) {
								$parentObj = $("body");
/* 								var $parentObj = $("article");
								if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
									$parentObj = $("body");
								} */
								//$parentObj.remove(); //객체 자체를 지워버리기
								$parentObj.empty(); //객체는 있지만 기존내용 clear하고
								$parentObj.html(responseData.trim()); //검색결과 출력
							}
						}); 
					} else if (data == '-1') {
						alert('게시글 작성에 실패 하였습니다.');
					} else {
						alert(data);
					}
				} 
			});
			return false;
		});

		$("input[name=cancel]").click(function() {
			$.ajax({
				url : "repboardlist",
				method : "get",
				success : function(responseData) {
					/* var $parentObj = $("article");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					} */
					$parentObj = $("body");
					$parentObj.empty(); //객체는 있지만 기존내용 clear하고
					$parentObj.html(responseData.trim()); //검색결과 출력
				}
			});
			return false;
		});
	});
</script>
</head>

<body>
	<form id="insertForm">
		<table style="border: 1px solid red">
			<tbody>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="subject"  placeholder="제목을 입력하세요" required="required">
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
</body>
</html>