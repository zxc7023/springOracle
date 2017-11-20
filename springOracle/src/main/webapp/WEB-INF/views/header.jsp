<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <link href="<%=request.getContextPath() %>/resources/index.css" type="text/css" rel="stylesheet"/> --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script>


$(function(){

   var $header = $("header");
   var $a = $header.find("a"); 
   $a.click(function(){
      var url = $(this).attr("href")
      $.ajax({ url: url,
         success: function(responseData){
            if(url=='logout.do'){
               location.href=responseData.trim();
            }else{
               $("article").empty(); //객체는 남기고 내용을 지우기
               $("article").html(responseData.trim());
               <%--console.log(responseData);
               console.log(url);--%>
            }
         }         
      });
      return false;
   });
   
   
});
</script>

<div class="menu">
	<h1>준기 홈페이지</h1>
	<ul>
		<li><a href="#">111111111</a></li>
		<li><a href="#">222222222</a></li>
		<li><a href="#">333333333</a></li>
		<li><a href="#">444444444</a></li>
		<li><a href="#">우재</a></li>
		<c:choose>
			<c:when test="${empty sessionScope.loginInfo}">
				<a href="signupform.jsp">가입</a>
				<a href="login.do">로그인</a>
			</c:when>
			<c:otherwise>
				<a href="logout.do">로그아웃</a>
				<a href="customerdetail.do">고객정보보기</a>
			</c:otherwise>
		</c:choose>
	</ul>
</div>