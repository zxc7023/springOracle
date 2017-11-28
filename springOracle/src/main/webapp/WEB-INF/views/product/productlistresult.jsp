<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.my.vo.Product"%>
<%@ page import="com.my.dao.ProductDAOOracle"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<title>상품목록</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		var $parentObj = $("article");
		if ($parentObj.length == 0) {
			$parentObj = $("body");
		}
		$parentObj.on("click", "#btCart", function() {
			//지금존재하는 객체의 하위 객체의 아이디가 btCart인것의 click 이벤트처리
			$.ajax({
				url : '${pageContext.request.contextPath}/cart/addcart',
				method : 'post',
				data : $(this).parents("form").serialize(),
				success : function(responseData) {
					alert("장바구니에 넣었습니다.");
					$parentObj.empty();
					//location.href='productlist.do';
				}
			});
			console.log(no + ":" + name + ":" + price + ":" + quantity + " 가 장바구니에 담았습니다."); 
			$parentObj.off();
			return false;
		});
		$("table td>a").click(function() {
			$.ajax({
				url : 'productdetail',
				method : 'get',
				data : 'no=' + $(this).html().trim(),
				success : function(responseData) {
					$parentObj.empty();
					$parentObj.html(responseData)

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
		<section>
			<jsp:include page="../header.jsp"></jsp:include>
			<jsp:include page="productsearch.jsp"></jsp:include>

			<c:set var="list" value="${requestScope.list}" />

			<table class="tb_product">
				<thead>
					<tr>
						<th>번호</th>
						<td>이름</td>
						<td>가격</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${list}">
						<tr>
							<td><a href="#">${p.prod_no}</a></td>
							<td>${p.prod_name}</td>
							<td>${p.prod_price}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</section>
	</article>
</body>
</html>