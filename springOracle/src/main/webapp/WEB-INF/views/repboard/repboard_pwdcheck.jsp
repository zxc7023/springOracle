<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="type" value="${requestScope.type}"></c:set>
<c:set var="no" value="${requestScope.no}"></c:set>

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/repboard_pwdcheck.css" type="text/css" rel="stylesheet" />
<script>
	$(function() {

		//hidden태그 폼
		var formObj = $("form[role=form]");

		//ajax를 통해 받은 데이터를 load할 태그
		var $parentObj = $("section");
		if ($parentObj.length == 0) {
			$parentObj = $("body");
		}

		$("input[name=confirm]").click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/repboard/checkpassword",
				method : 'post',
				data : $("form#pwdForm").serialize() + "&" + formObj.serialize() + "&type=" + "${type}",
				success : function(responseData) {
					var isChecked = responseData.trim();
					console.log(isChecked)
					if (isChecked=="-1") {
						$("form#pwdForm").next().removeAttr("style").addClass("pwd-invaild");
					}else if(isChecked=="1"){
						location.href="${pageContext.request.contextPath}/repboard/repboardlist?"+formObj.serialize();
					}else {
						$parentObj.empty();
						/* var tmp = $parentObj.html(isChecked).find("article") */
						$parentObj.html(isChecked);
					}

				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
				}

			});
			return false;
		});
		
		$("input[name=cancel]").click(function() {
			$.ajax({
				url : '${pageContext.request.contextPath}/repboard/repboarddetail',
				method : 'get',
				data : formObj.serialize(),
				success : function(responseData) {
					$parentObj.empty();
					var tmp = $parentObj.html(responseData.trim()).find("article");
					$parentObj.html(tmp);
				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
				}
			});
			return false;
		});
	});
</script>
</head>
<body>
	<article>
		<form id="pwdForm">
			<table class="pwd-table">
				<tbody>
					<tr>
						<td colspan="2">
							<input type="password" name="password" placeholder="패스워드를 입력하세요" required="required">
						</td>
					</tr>
				</tbody>
			</table>
			<input type="submit" name="confirm" value="확인">
			<input type="submit" name="cancel" value="취소">
			
		</form>
		<span style="display: none;">비밀 번호를 확인해 주세요.</span>
	</article>

</body>
</html>