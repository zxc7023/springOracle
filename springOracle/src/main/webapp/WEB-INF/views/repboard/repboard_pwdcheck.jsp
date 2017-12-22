<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String checkOther = (String) request.getAttribute("check");
%>
<%
	String BoardNumber = (String) request.getAttribute("boardno");
%>
<%
	String contextPath = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
 $(function(){
    var $parentObj = $("article");
    var $boardno = <%=BoardNumber%>;
    var $checkOther = '<%=checkOther%>';
    
    if($parentObj.length==0){
        $parentObj=$("body");
    }
    
    $("input[name=cancel]").click(function(){
        $.ajax({url:'repboarddetail.do',
                        method: 'get',
                        data: "no="+$boardno,
                        success: function(responseData){
                       //console.log(responseData);
                       var $parentObj = $("article");
                       if($parentObj.length == 0){ //article영역의 유무에 따라 출력
                          $parentObj = $("body");
                       }
                       //$parentObj.remove(); //객체 자체를 지워버리기
                       $parentObj.empty(); //객체는 있지만 기존내용 clear하고
                       $parentObj.html(responseData.trim()); //검색결과 출력
                    },
                    error: function(xhr, status, error){
                            console.log(xhr.status);
                    }
        });
        return false;
   });
    $("input[name=confirm]").click(function(){
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
                                           <%-- location.href = '<%= contextPath %>'+"/repboardlist.do"; --%>
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
    });

 }); 
</script>
</head>
<body>


	<section>
		<article>
			<table>
				<tbody>

					<tr>
						<td>패스워드를 입력하세요</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="pwd">
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
	</section>



</body>
</html>