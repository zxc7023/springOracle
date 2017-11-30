<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.my.vo.Product"%>
<%@ page import="com.my.vo.OrderLine"%>
<%@ page import="com.my.vo.OrderInfo"%>
<%@ page import="java.util.List"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.type05 {
	width: 800px;
	text-align: center;
	margin: 50px auto;
}

.title {
	font-size: 17px;
	font-weight: bold;
	color: #fff;
	background: #4285f4;
}

.content {
	font-size: 15px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		var termButton = $(".term-select").find("input");
		termButton.click(function() {
			alert("눌림")
			return false;
		});

	});
</script>
</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>
	
	<div class="term-select">
		<input type="submit" name="btnTerm1D" value="오늘" id="btnTerm1D" class="button" />
		<input type="submit" name="btnTerm1W" value="1주일" id="btnTerm1W" class="button" />
		<input type="submit" name="btnTerm1M" value="1개월" id="btnTerm1M" class="button" />
		<input type="submit" name="btnTerm3M" value="3개월" id="btnTerm3M" class="button-on" />
		<input type="submit" name="btnTerm6M" value="6개월" id="btnTerm6M" class="button" />
	</div>

	<table class="type05">
		<colgroup>
			<col width="10%" />
			<col width="30%" />
			<col width="10%" />
			<col width="*" />
			<col width="10%" />
			<col width="5%" />
			<col width="10%" />
		</colgroup>
		<tr class="title">
			<td>주문번호</td>
			<td>주문일자</td>
			<td>상품번호</td>
			<td>상품명</td>
			<td>가격</td>
			<td>수량</td>
			<td>금액</td>
		</tr>
		<c:set var="cList" value="${requestScope.orderInfoList}" />
		<c:forEach var="orderInfo" items="${cList}" varStatus="status">
			<tr>
				<td rowspan="${fn:length(orderInfo.lines)}">${orderInfo.info_no }</td>
				<td rowspan="${fn:length(orderInfo.lines)}"><fmt:formatDate value="${orderInfo.info_date}"
						type="date" pattern="yyyy년 MM월 dd일 kk시 mm분" /></td>
				<c:forEach var="orderLine" items="${orderInfo.lines}" end="0">
					<td>${orderLine.line_p.prod_no }</td>
					<td>${orderLine.line_p.prod_name }</td>
					<td>${orderLine.line_p.prod_price }</td>
					<td>${orderLine.line_quantity}</td>
					<td>${orderLine.line_p.prod_price * orderLine.line_quantity}</td>
				</c:forEach>
			</tr>
			<c:forEach var="orderLine2" items="${orderInfo.lines}" begin="1">
				<tr>
					<td>${orderLine2.line_p.prod_no }</td>
					<td>${orderLine2.line_p.prod_name }</td>
					<td>${orderLine2.line_p.prod_price }</td>
					<td>${orderLine2.line_quantity}</td>
					<td>${orderLine2.line_p.prod_price * orderLine2.line_quantity}</td>
				</tr>
			</c:forEach>
		</c:forEach>
	</table>

</body>
</html>