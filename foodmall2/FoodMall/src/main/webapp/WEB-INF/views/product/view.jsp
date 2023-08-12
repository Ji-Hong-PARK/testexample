<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
    	<!-- head -->
		<jsp:include page="../include/head.jsp"></jsp:include>
    </head>
    <style>
		#inventory{
			margin: 0;
		}
	</style>
    <body>
        <!-- Navigation-->
        <jsp:include page="../include/navigation.jsp"></jsp:include>
		<!-- Header-->
        <jsp:include page="../include/header.jsp"></jsp:include>
        <!-- Product section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="/upload/files/${item.image}" alt="..." /></div>
                    <div class="col-md-6">
                        <div class="small mb-1">상품코드: ${item.productId}</div>
                        <h1 class="display-5 fw-bolder">${item.productName}</h1>
                        <div class="fs-5 mb-5">
                            <!-- <span class="text-decoration-line-through"></span> 밑줄 -->
                            <span>${item.price}원</span>
                        </div>
                        <p class="lead">${item.productInfo}</p>
                        <div class="d-flex">
                            <p class="form-control text-center me-3" id="inventory" style="max-width: 8rem">
                            	재고: ${item.inventory}
                            </p>
                            <a id="basket" class="btn btn-outline-dark flex-shrink-0" type="button">
                                <i class="bi-cart-fill me-1"></i>
                                Add to cart
                                <input id="pid" type="hidden" value="${item.productId}">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- 최근 본 상품 section-->
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
       	
            <c:choose>
            	<c:when test="${viewList eq 'no-cookie'}">
            		<h2>최근 본 상품이 없습니다.</h2>
            	</c:when>

            	<c:otherwise>
	            	<c:if test="${viewList.size() < 1}">
	            		<h2>최근 본 상품이 없습니다.</h2>
	            	</c:if>
	                <h2 class="fw-bolder mb-4">최근 본 상품</h2>
	                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
	                
	                    <c:forEach var="viewItem" items="${viewList}">
							<div class="col mb-5">
		                        <div class="card h-100">
		                            <!-- Product image-->
		                            <img class="card-img-top" src="/upload/files/${viewItem.image}" alt="..." />
		                            <!-- Product details-->
		                            <div class="card-body p-4">
		                                <div class="text-center">
		                                    <!-- Product name-->
		                                    <h5 class="fw-bolder">${viewItem.productName}</h5>
		                                    <!-- Product price-->
		                                    ${viewItem.price}
		                                </div>
		                            </div>
		                            <!-- Product actions-->
		                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
		                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="/product/view/${viewItem.productId}">View options</a></div>
		                            </div>
		                        </div>
		                    </div>
	                    </c:forEach>
	                     
	                </div>
            	</c:otherwise>
            </c:choose>
  
            </div>
        </section>
        
		<!-- 장바구니 확인 Modal -->
		<div class="modal fade" id="basketModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">장바구니 확인창</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		        <button id="moveBasket" type="button" class="btn btn-primary">예</button>
		      </div>
		    </div>
		  </div>
		</div>       
        
		<!-- Footer-->
        <jsp:include page="../include/footer.jsp"></jsp:include>
		
		<script>
			let i = "${viewList}";			
		
        	$(function(){
        		$("#moveBasket").on("click", function(){
        			location.href="/basket";
        		});
        		
        		$("#basket").on("click", function(){
        			const member = '<%=session.getAttribute("member")%>';
        			
        			if(member == 'null'){
        				alert("장바구니는 로그인 후 이용 가능합니다.")
        				return false;
        			}
        			
        			let pid = $("#pid").val();
        			
        			$.ajax({
        				url: "/basket/add",
        				method: "POST",
        				data: JSON.stringify(pid),
        				contentType: "application/json",
        				dataType: "text",
        				success: function(data){
        					if(data == "exist"){
        						$(".modal-body").text("장바구니에 상품이 이미 있습니다. 장바구니로 이동하시겠습니까?");
        						$("#basketModal").modal("show");
        					}else if(data == "success"){
        						$.ajax({
        							method: "POST",
        							url: "/basket/count",
        							dataType: "text",
        							success: (function(count){
        								$("#cartCount").text(count);
        							})
        						});
        						
        						$(".modal-body").text("장바구니에 상품이 추가되었습니다. 장바구니로 이동하시겠습니까?");
        						$("#basketModal").modal("show");
        					}
        				}
        			});
        		});
        	});
        </script>
    </body>
</html>
