<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MUNGHUBSHOP</title>
<style>


</style>
</head>
<body>
	<%@include file="../common/header.jsp" %>
	
	<div class="container px-4 px-lg-5 my-5">
		<form action="/pjtMungHub/update.sp" method="post" enctype="multipart/form-data">
			<input type="hidden" value="${p.productNo }" name="productNo">
			       <table align="center">
			       <tr>
			       		<td>
			       			<img class="card-img-top mb-5 mb-md-0" id="product1">
			       		</td>
			       </tr>
                    <tr>
                        <th><label for="title">상품명</label></th>
                        <td><input type="text" id="title" value="${p.productName }" class="form-control" name="productName" required></td>
                    </tr>
                    <tr>
                        <th><label for="price">가격</label></th>
                        <td><input type="text" id="price" value="${p.price }" class="form-control" name="price"></td>
                    </tr>
                     <tr>
                        <th><label for="discount">할인율</label></th>
                        <td><input type="text" id="discount" value="${p.discount }" class="form-control" name="discount"></td>
                    </tr>
                    <tr>
                        <th><label for="category">카테고리</label></th>
                        <td><select name="categoryNo">
                        <c:forEach items="${c}" var="cate">
                        	<option value="${cate.categoryNo }" <c:if test="${p.categoryNo eq cate.categoryNo}">selected="selected"</c:if>>${cate.categoryName }</option>
                        </c:forEach>
                        </select></td>
                    </tr>
                     <tr>
                        <th><label for="brandCode">브랜드</label></th>
                        <td><select name="brandCode">
                        	  <c:forEach items="${b}" var="brand">
                        	<option value="${brand.brandCode }" <c:if test="${p.brandCode eq brand.brandCode}">selected="selected"</c:if>>${brand.brandName }</option>
                        </c:forEach>
                        </select></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile" multiple>
                        </td>
                        <c:if test="${not empty atList }">
                        <c:forEach items="${atList }" var="at">
                        <tr>
                       <td>현재 업로드된 파일 : </td>
                        <td><a href="${at.filePath }${at.changeName}" download="${at.originName }">${at.originName }</a></td>
                        </tr> 
                        </c:forEach>
                        </c:if>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">초기화</button>
                </div>
            </form>
					
			
	</div>
	
	<script>
		$(function(){
			$("#product1").click(function(){
				$("#upfile").click();
			});
		});
		
		function loadImg(inputFile,num){
			if(inputFile.files.length==1){
				var reader = new FileReader();
				
				reader.readAsDataURL(inputFile.files[0]);
				
				reader.onload =function(e){
						$("#product1").attr("src",e.target.result);
					}
				}else{
					$("#product1").attr("src",null);
			}
		}
	</script>
</body>
</html>