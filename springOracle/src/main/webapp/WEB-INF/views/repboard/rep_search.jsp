<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="item" value="${param.searchItem}" />
<c:if test="${item == null}">
   ${item=subject}
</c:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {

		$("input[name=searchValue]").val('${param.searchValue}');
		$("option[value='${item}']").attr("selected", "true");

		$("div.searchDiv").find("input[type=button]").click(function() {
			$.ajax({
				url : "insert",
				success : function(responseData) {
					//console.log(responseData);
					var $parentObj = $("article");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					//$parentObj.remove(); //객체 자체를 지워버리기
					$parentObj.empty(); //객체는 있지만 기존내용 clear하고
					$parentObj.html(responseData.trim()); //검색결과 출력
				}
			});
			return false;
		});

		$("form").submit(function() {
			console.log($("form").serialize());
			$.ajax({
				url : "repboardlist",
				method : "get",
				data : $("form").serialize(),
				success : function(responseData) {
/* 					var $parentObj = $("article");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					} */
					var $parentObj = $("body");
					$parentObj.empty();
					$parentObj.html(responseData.trim());
				}
			});
			return false;
		});

	});
</script>
<style type="text/css">
form {
	width: 500px;
	margin: 0 auto;
}

select {
	height: 27px;
	vertical-align: middle;
}

input[type="search"] {
	height: 27px
}

input[type="submit"] {
	height: 27px
}

input[type="button"] {
	height: 27px
}
</style>


<div class="searchDiv">
	<form style="border-collapse: collapse; padding: 10px;">
		<select name="searchType">
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<option value="no">번호</option>
		</select>
		<input type="search" name="keyword" placeholder="검색어를 입력해주세요.">
		<input type="submit" value="검색">
		<input type="button" name="insert" value="게시글 쓰기" id="insert">
	</form>
</div>
