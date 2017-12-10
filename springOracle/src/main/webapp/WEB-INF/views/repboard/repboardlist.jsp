<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="boardList" value="${requestScope.boardList}"></c:set>
<c:set var="pageMaker" value="${requestScope.pageMaker}"></c:set>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>



<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<style type="text/css">
a {
	text-decoration: none;
	color: #333
}

a:hover {
	text-decoration: underline;
	color: #333
}

ul.pagination {
	width: 500px;
	margin: 0 auto;
}

ul.pagination li {
	float: left;
	margin-right: 3px;
}

li.active a {
	text-decoration: underline;
	color: blue;
}
</style>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>게시판</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		
		$("ul.pagination li a").click(function() {
			var $data = "page=" + $(this).attr("href");
			$.ajax({
				url : '${pageContext.request.contextPath}/repboard/repboardlist',
				method : 'get',
				data : $(this).attr("href"),
				success : function(responseData) {
					var $parentObj = $("section");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					$parentObj.empty();
					var tmp = $parentObj.html(responseData).find("article")
					$parentObj.html(tmp);

				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
				}
			});
			return false;
		});
/* 		$("tbody a").click(function() {
			$.ajax({
				url : '${pageContext.request.contextPath}/repboard/repboarddetail',
				method : 'get',
				data : $(this).attr("href"),
				success : function(responseData) {
					var $parentObj = $("section");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					$parentObj.empty();
					var tmp = $parentObj.html(responseData).find("article")
					$parentObj.html(tmp);

				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
				}
			});
			return false;
		}); */

	});
</script>
</head>

<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>

	<section>
		<article>
			<jsp:include page="rep_search.jsp"></jsp:include>

			<table style="margin: auto; border-collapse: collapse; border: 1px solid; width: 1000px">
				<colgroup>
					<col width="40%" />
					<col width="40%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<td>제목</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="repBoard" items="${boardList}" varStatus="status">
						<tr>
							<td>
								<a href="${pageContext.request.contextPath}/repboard/repboarddetail?no=${repBoard.no}"><input type="text" value="${repBoard.subject}"
										readonly="readonly" /></a>
							</td>
							<td>
								<fmt:formatDate value="${repBoard.registerDate}" type="both" pattern="HH:mm" />
								<c:if test=""></c:if>
							</td>
							<td>${toDay}</td>
							<td>${repBoard.viewCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<ul class="pagination">

				<c:if test="${pageMaker.prev}">
					<li><a
						href="page=${pageMaker.startPage - 1}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}">&laquo;</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>><a
						href="page=${idx}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}">${idx}</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a
						href="page=${pageMaker.endPage +1}&searchType=${pageMaker.cri.searchType}&keyword=${pageMaker.cri.keyword}">&raquo;</a></li>
				</c:if>
			</ul>
		</article>
	</section>
</body>
</html>