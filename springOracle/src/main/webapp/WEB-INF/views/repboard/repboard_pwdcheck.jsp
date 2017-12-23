<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="type" value="${requestScope.type}"></c:set>
<c:set var="no" value="${requestScope.no}"></c:set>

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/repboard_pwdcheck.css" type="text/css" rel="stylesheet" />
<script>
 $(function(){
	 

	//hidden태그 폼
	var formObj = $("form[role=form]");
	
	//ajax를 통해 받은 데이터를 load할 태그
	var $parentObj = $("section");
	if ($parentObj.length == 0) {
		$parentObj = $("body");
	}
   
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
   <%--  $("input[name=confirm]").click(function(){
       var $pwd = $('input[type=text]').val();
       console.log($pwd+" "+$boardno);
         $.ajax({url:'checkpassword.do',
                         method: 'post',
                         data: 'pwd='+$pwd+'&boardno='+$boardno,
                         success: function(responseData){
                         var data = responseData.trim();
                     	  if(data == '1'){
                          if('delete' == $checkOther){
                              if (confirm("정말 삭제하시겠습니까??") == true){    //확인
                                  $.ajax({
                                     url:'repboarddelete.do',
                                     method:'post',
                                     data:'boardno='+$boardno,
                                     success:function(responseData){
                                        if(data == '1'){
                                           alert('게시글이 삭제 되었습니다.');
                                 		  		$.ajax({ url: "repboardlist.do",
                                				  method: "post",
                                			 	 success: function(responseData){
                                					  var $parentObj = $("article");
                                					  if($parentObj.length == 0){ //article영역의 유무에 따라 출력
                                						  $parentObj = $("body");
                                					  }
                                				  //$parentObj.remove(); //객체 자체를 지워버리기
                                					  $parentObj.empty(); //객체는 있지만 기존내용 clear하고
                                					  $parentObj.html(responseData.trim()); //검색결과 출력
                                					  }
                                		  });
                                		  return false;
                                           location.href = '<%= contextPath %>'+"/repboardlist.do";
                                        }else if(data == '2'){
                                           alert('게시글 삭제에 실패했습니다.');
                                        }else{
                                           alert(data);
                                        }
                                     }
                                  });
                              }else{   //취소
                                  return;
                              }
                          }else if('modify' == $checkOther){
                        	  $.ajax({
                                  url:'selectdata.do',
                                  method:'post',
                                  data:'boardno='+$boardno,
                                  success:function(responseData){
                                      $parentObj.empty(); //객체는 있지만 기존내용 clear하고
                                      $parentObj.html(responseData.trim()); //검색결과 출력
                                  
                                  }
                               });
                          }else{
                             alert(data);
                          }
                          
                       }else if(data == '-1'){
                        alert('패스워드 불일치');
                       }else{
                        alert(data);
                       }
                       },
                       error: function(xhr, status, error){
                               console.log(xhr.status);
                       }
         });
         return false; 
    }); --%>

 }); 
</script>
</head>
<body>
	<form>
	<article>
		<table class="pwd-table">
			<tbody>
				<tr>
					<td colspan="2">
						<input type="password" name="pwd" placeholder="패스워드를 입력하세요">
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" name="confirm" value="확인">
					</td>
					<td>
						<input type="submit" name="cancel" value="취소">
					</td>
				</tr>
			</tbody>
		</table>
	</article>
	</form>
</body>
</html>