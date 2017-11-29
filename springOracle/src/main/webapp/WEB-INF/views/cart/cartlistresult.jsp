<%@page import="java.util.Set"%>
<%@page import="com.my.vo.Product"%>
<%@page import="java.util.HashMap"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	boolean flag = false;
%>
<%
	if (session.getAttribute("loginInfo") != null) {
		flag = true;
	}
%>
<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		$("input[type=submit]").click(function() {
			$.ajax({
				url : '${pageContext.request.contextPath}/order/addorder',
				method : 'post',
				success : function(responseData) {
					<c:if test="${sessionScope.loginInfo==null}">
					alert("로그인 페이지로 이동합니다.");
					</c:if>
					alert(responseData);
					var $parentObj = $("body");
					var data = responseData.trim();
					$parentObj.empty(); //객체는 남기고 내용을 지우기
					$parentObj.html(data);
				}
			});
		});
	});
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<c:choose>
		<c:when test="${ empty sessionScope.cart}">
			<h3>장바구니가 비었습니다.</h3>
		</c:when>
		<c:otherwise>
			<c:set var="cart" value="${sessionScope.cart}" />
			<h1>장바구니</h1>
			<table>
				<tr>
					<td>상품번호</td>
					<td>상품명</td>
					<td>가격</td>
					<td>수량</td>
					<td>금액</td>
				</tr>

				<c:forEach var="c" items="${cart}">
					<c:set var="p" value="${c.key}" />
					<tr>
						<td>${p.prod_no}</td>
						<td>${p.prod_name}</td>
						<td><fmt:formatNumber value="${p.prod_price}" type="currency" /></td>
						<td>${c.value}</td>
						<td><fmt:formatNumber value="${p.prod_price * c.value}" type="currency" /></td>
					</tr>
				</c:forEach>

				<tr>
					<td colspan="5"><input type="submit" value="주문하기"></td>
				</tr>
			</table>
		</c:otherwise>
	</c:choose>
</body>
</html>