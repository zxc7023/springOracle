<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="repboard" value="${requestScope.repboard}"></c:set>
<!DOCTYPE html>
<html>
<head>
<script>
 $(function(){
		//hidden태그 폼
		var formObj = $("form[role=form]");
		
		//ajax를 통해 받은 데이터를 load할 태그
		var $parentObj = $("section");
		if ($parentObj.length == 0) {
			$parentObj = $("body");
		}
	 
		 $("input[name=modify]").click(function(){
			 var updateBoardObj = $("form.updateBoard").serialize();
			 console.log(updateBoardObj);
		      $.ajax({
		    	  url:'${pageContext.request.contextPath}/repboard/modify',
		        	method: 'post',
		        	data: formObj.serialize() + "&" + updateBoardObj ,
		        	success: function(responseData){
		        		var affectedRowNum = responseData.trim();
		        		if(affectedRowNum == "1"){
		        	        $.ajax({
		        	        	url:'${pageContext.request.contextPath}/repboard/repboarddetail',
		        	        	method: 'get',
		        	        	data: formObj.serialize(),
		        	        	success: function(responseData){
		        	        		$parentObj.empty();
		        					var tmp = $parentObj.html(responseData.trim()).find("article");
		        					$parentObj.html(tmp);
		        	            },
		        	            error: function(xhr, status, error){
		        	            	console.log(xhr.status);
		        	            }
		        	        });
		        		}
		        		/* $parentObj.empty();
						var tmp = $parentObj.html(responseData.trim()).find("article");
						$parentObj.html(tmp); */
		            },
		            error: function(xhr, status, error){
		            	console.log(xhr.status);
		            }
		      });
			 return false;
		 });
		
		
	    $("input[name=cancel]").click(function(){
	        $.ajax({
	        	url:'${pageContext.request.contextPath}/repboard/repboarddetail',
	        	method: 'get',
	        	data: formObj.serialize(),
	        	success: function(responseData){
	        		$parentObj.empty();
					var tmp = $parentObj.html(responseData.trim()).find("article");
					$parentObj.html(tmp);
	            },
	            error: function(xhr, status, error){
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
		<form class="updateBoard">
			<table class="repboard">
				<tbody>
					<tr>
						<td colspan="2">
							<input type="text" name="subject" value="${repboard.subject}" required="required">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="text" name="content" value="${repboard.content}" required="required">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="password" name="password" placeholder="비밀번호" required="required">
						</td>
					</tr>
					<tr>
						<td style='width: 100px'>
							<input type='submit' name='modify' value='수정'>
						</td>
						<td style='width: 100px'>
							<input type='button' name='cancel' value='취소'>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</article>
</body>
</html>