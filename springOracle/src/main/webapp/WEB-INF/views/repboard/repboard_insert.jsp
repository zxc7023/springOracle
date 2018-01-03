<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="parent_no" value="${requestScope.parent_no}"></c:set>

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/repboard_insert.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		$("form.insertForm").submit(function() {
			var $data = "parent_no=" + ${parent_no} +"&" + $(this).serialize();
			$.ajax({
				url : "${pageContext.request.contextPath}/repboard/insert",
				method : "post",
				data : $data,
				success : function(responseData) {
					var data = responseData.trim();
					if (data == '-1') {
						alert('게시글 작성에 실패 하였습니다.');
					} else {
						location.href = "${pageContext.request.contextPath}/repboard/repboarddetail?no=" + data;	
					}
				}
			});
			return false;
		});

		$("input[name=cancel]").click(function() {
			location.href = "${pageContext.request.contextPath}/repboard/repboardlist";
			return false;
		});
	});
</script>
</head>

<body>

	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>


	<section>
		<article>
			<form class="insertForm">
				<div class="group">   
					<input type="text" name="subject" required="required"/>
          			<span class="highlight"></span>
     				<span class="bar"></span>
      				<label>제목을 입력하세요</label>
       			 </div>
			
            		<div class="group">
					<input type="text" name="content" required="required"/>
             		<span class="highlight"></span>
      				<span class="bar"></span>
      				<label>내용을 입력하세요</label>
               </div>
        
        			<div class="group password_group">	
					<input type="password" name="password" required="required"/>
            			<span class="highlight"></span>
      				<span class="bar"></span>
      				<label>비밀번호를 입력하세요</label>
             	</div>
        
				<div class="insertForm_button">
					<input type="submit" name="insert" value="글 작성">
					<input type="button" name="cancel" value="취소">
       			 </div>
			</form>
		</article>
	</section>
</body>
</html>