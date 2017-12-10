<%@page import="com.my.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="c" value="${requestScope.customer}"></c:set>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Referrer" content="origin">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="">
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/login_form.css" type="text/css"
	rel="stylesheet" />
<title>고객정보수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {

		$("input[name=modify]").click(function() {
			var $data = $("form").serialize(); 
			console.log($data);
			$.ajax({
			url : '${pageContext.request.contextPath}/customer/updatecustomer',
			method : 'post',
			data : $data,
			success : function(responseData) {
				var data = responseData.trim();
				if (data == '1') {
					alert("수정성공");
				} else if (data == '-1') {
					alert("수정실패");
				} else {
					alert(data);
				}
			}
			}); 
			return false;
		});

		$("input[name=delete]").click(function() {
			var $id = $("#customerID").text();
			alert($id);
			$.ajax({
				url : 'deletecustomer.do',
				method : 'post',
				data : 'id=' + $id,
				success : function(responseData) {
					var data = responseData.trim();
					if (data == '1') {
						alert("삭제하였습니다.");
						location.href = '${pageContext.request.contextPath}'
					} else if (data == '-1') {
						alert("삭제실패");
					} else {
						alert(data);
					}
				}
			});
			return false;
		});
	});
</script>
</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>
	<article>
		<form action="post">
			<table class="customerdetail-wrap">
				<thead>
					<tr>
						<th colspan="2">고객상세정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>ID</td>
						<td><input type="text" name="id" value="${c.id}" readonly="readonly"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="password" value="${c.password}" required /></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name" value="${c.name}" required /></td>
					</tr>
					<tr>
						<td><input type="submit" name="modify" value="수정" /></td>
						<td><input type="submit" name="delete" value="탈퇴" /></td>
					</tr>
				</tbody>
			</table>
		</form>
	</article>
</body>
</html>