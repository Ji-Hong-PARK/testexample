<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<!-- head -->
	<jsp:include page="../include/head.jsp"></jsp:include>
</head>
<body>
	<!-- Navigation-->
    <jsp:include page="../include/navigation.jsp"></jsp:include>
    <!-- Header-->
    <jsp:include page="../include/header.jsp"></jsp:include>

	<div class="container px-4 px-lg-5 mt-5">
		<h3>장바구니</h3>
		<div>
			<table border="1" class="table">
				<thead>
					<tr>
						<th>선택</th>
						<th>카테고리</th>
						<th>상품번호</th>
						<th>상품사진</th>
						<th>상품명</th>
						<th>가격</th>
						<th>마일리지</th>
						<th>관리</th>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${list.size() < 1}">
						<tr>
							<td colspan="8">등록 된 상품이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach var="item" items="${list}">
						<tr data-pid="${item.productId}">
							<td class="productId"><input type="checkbox" name="check" value="${item.productId}"></td>
							<td class="categoryId">${item.categoryName}<input type="hidden" value="${item.categoryId}"></td>
							<td>${item.productId}</td>
							<td class="image"><input type="hidden" value="${item.image}"><img src="/upload/files/${item.image}" style="height:100px; weight:100px;"></td>
							<td class="productName">${item.productName}<input type="hidden" value="${item.productName}"></td>
							<td class="price">${item.price}<input type="hidden" value="${item.price}"></td>
							<td class="mileage">${item.mileage}<input type="hidden" value="${item.mileage}"></td>
							<td><button class="delete btn btn-danger">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</div>
		<div>
			<button id="decide" class="btn btn-primary">주문하기</button>
			<button id="listDelete" class="btn btn-danger">선택삭제</button>
			<a href="/main" class="btn btn-secondary">처음으로</a>
		</div>
	</div> 
	
		<!-- 장바구니 확인 Modal -->
		<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">장바구니 확인창</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        선택한 상품을 주문하시겠습니까?
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		        <button id="confirmModalBtn" type="button" class="btn btn-primary">예</button>
		      </div>
		    </div>
		  </div>
		</div>	
	
		<!-- 삭제 확인 Modal -->
		<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">삭제 확인창</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        정말 선택한 상품을 삭제하시겠습니까?
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
		        <button id="deleteModalBtn" type="button" class="btn btn-primary">예</button>
		      </div>
		    </div>
		  </div>
		</div>	
		
		<!-- Footer-->
        <jsp:include page="../include/footer.jsp"></jsp:include>
		
<script>
	function check() {
		let count = 0;
		$('input[name="check"]:checked').each(function(){
			count ++;
		});
		if(count < 1){
			alert("상품을 선택해주세요.");
			return false;
		}else{
			return true;
		}
	}

	$(function(){	
		
		$(".delete").on("click", function(){
			let pid = $(this).parent().parent().data().pid;
			$("#deleteModal").modal("show");
			
			$("#deleteModalBtn").on("click", function(){
				$.ajax({
					method: "DELETE",
					url: "/basket/delete",
					data: JSON.stringify(pid),
					contentType: "application/json",
					dataType: "text",
					success: (function(data){
						$("tr[data-pid='" + data + "']").remove();
						$("#deleteModal").modal("hide");
						
						// 장바구니 카운트 ajax (세션반영)
						$.ajax({
							method: "POST",
							url: "/basket/count",
							dataType: "text",
							success: (function(count){
								$("#cartCount").text(count);
							})
						});
					})
				})
			})
		})
		
		
		$("#listDelete").on("click", function(){
			if(check()){
				$("#deleteModal").modal("show");
			}
			
			$("#deleteModalBtn").on("click", function(){
				let pidArray = [];
				
				$('input[name="check"]:checked').each(function(){
					let pid = $(this).val();
					pidArray.push(pid);
				});
				
				$.ajax({
					method: "DELETE",
					url: "/basket/listDelete",
					traditional: true,
					data: JSON.stringify(pidArray),
					contentType: "application/json",
					dataType: "text",
					success: (function(data){
						$.ajax({
							method: "POST",
							url: "/basket/count",
							dataType: "text",
							success: (function(count){
								
							})
						});
						location.reload(true);
					})
				});
			})
		});
		
		$("#decide").on("click", function(){
			if(check()){
				$("#confirmModal").modal("show");	
			}
		});
		
		$("#confirmModalBtn").on("click", function(){
			let itemArray = [];
			
			$('input[name="check"]:checked').each(function(){
				let item_ = {
						productId: $(this).val(),
						categoryId: $(this).parent().siblings(".categoryId").children().val(),
						productName: $(this).parent().siblings(".productName").children().val(),
						image: $(this).parent().siblings(".image").children().val(),
						price: $(this).parent().siblings(".price").children().val(),
						mileage: $(this).parent().siblings(".mileage").children().val()
				}
				itemArray.push(item_);
			});
			
			$.ajax({
				method: "POST",
				url: "/order/confirm",
				traditional: true,
				data: JSON.stringify(itemArray),
				contentType: "application/json",
				dataType: "text",
				success: (data, status) => {
					console.log(data);
					location.href = "/order/decide";
				},
				error: (jqXHR, status, error) => {
					console.log(error);
				}
			});
		});
		
		
		/*
		$(".decide").click(function(){
			let itemArray = [];
			
			$('input[name="check"]:checked').each(function(){
				let item_ = {
						productId: $(this).val(),
						categoryId: $(this).parent().siblings(".categoryId").children().val(),
						productName: $(this).parent().siblings(".productName").children().val(),
						image: $(this).parent().siblings(".image").children().val(),
						price: $(this).parent().siblings(".price").children().val(),
						mileage: $(this).parent().siblings(".mileage").children().val()
				}
				itemArray.push(item_);
			});
			
			$.ajax({
				method: "POST",
				url: "/order/confirm",
				traditional: true,
				data: JSON.stringify(itemArray),
				contentType: "application/json",
				dataType: "text",
				success: (data, status) => {
					console.log(data);
					location.href = "/order/decide";
				},
				error: (jqXHR, status, error) => {
					console.log(error);
				}
			});

		});
		*/
	});
	
</script>
</body>
</html>