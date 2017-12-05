<%@page import="com.my.vo.RepBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="boardList" value="${requestScope.boardList}"></c:set>
<c:set var="item" value="${param.searchItem}" />
<c:set var="cri" value="${requestScope.cri}"></c:set>
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
</style>
<meta http-equiv="Content-Type" content="text/html;   charset=UTF-8">
<title>게시판</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		$("ul.pagination li a").click(function() {
			var $data = "page=" + $(this).attr("href");
			$.ajax({
				url : '${pageContext.request.contextPath}/repboard/repboardlist',
				method : 'get',
				data : $data,
				success : function(responseData) {
					var $parentObj = $("body");
					/* 					var $parentObj = $("article");
					 if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
					 $parentObj = $("body");
					 } */
					//$parentObj.remove(); //객체 자체를 지워버리기 
					$parentObj.empty(); //객체는 있지만 기존내용 clear하고
					$parentObj.html(responseData.trim()); //검색결과 출력
				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
				}
			});
			return false;
		});
	});
</script>
<style type="text/css">
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
					<col width="10%" />
					<col width="30%" />
					<col width="40%" />
					<col width="10%" />
				</colgroup>
				<thead>
					<tr>
						<th>글번호</th>
						<td>제목</td>
						<td>등록일</td>
						<td>조회수</td>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="repBoard" items="${boardList}" varStatus="status">
						<tr>
							<td>${repBoard.no}</td>
							<td>${repBoard.subject}</td>
							<td>
								<fmt:formatDate value="${repBoard.registerDate}" type="date" pattern="yyyy-MM-dd kk:mm:ss" />
							</td>
							<td>${repBoard.viewCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<ul class="pagination">

				<c:if test="${pageMaker.prev}">
					<li><a href="${pageMaker.startPage - 1}">&laquo;</a></li>
				</c:if>

				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>><a href="${idx}">${idx}</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="${pageMaker.endPage +1}">&raquo;</a></li>
				</c:if>

			</ul>

		</article>
	</section>

</body>
</html>