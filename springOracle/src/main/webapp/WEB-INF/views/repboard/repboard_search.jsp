<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="item" value="${param.searchType}" />
<c:if test="${item == null}">
   ${item=subject}
</c:if>
<link href="<%=request.getContextPath()%>/resources/repboardlist.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {

		$("input[name=keyword]").val('${param.keyword}');
		$("option[value='${item}']").attr("selected", "true");

 		$("div.searchDiv").find("input[type=button]").click(function() {
 			location.href="${pageContext.request.contextPath}/repboard/insert";
			/* $.ajax({
				url : "${pageContext.request.contextPath}/repboard/insert",
				success : function(responseData) {
					var $parentObj = $("section");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					$parentObj.empty();
					$parentObj.html(responseData);
				}
			}); */
			return false;
		}); 

		$("form").submit(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/repboard/repboardlist",
				method : "get",
				data : $("form").serialize(),
				success : function(responseData) {
					var $parentObj = $("section");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					$parentObj.empty();
					var tmp = $parentObj.html(responseData).find("article")
					$parentObj.html(tmp);
				}
			});
			return false;
		});

	});
</script>
<div class="searchDiv">
	<form style="border-collapse: collapse; padding: 10px;">
		<select name="searchType">
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<option value="no">번호</option>
		</select>
		<input type="search" name="keyword" placeholder="검색어를 입력해주세요.">
		<input type="submit" value="검색">
	</form>
	
		<input type="button" name="insert" value="글작성" id="insert">
</div>
