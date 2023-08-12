<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	$(function(){
		$(".decide").click(function(){
			let itemArray = [];
			
			$('input[name="check"]:checked').each(function(){
				let item_ = {
						productId: $(this).val(),
						categoryId: $(this).parent().siblings(".categoryId").children().val(),
						count: $(this).parent().siblings(".count").children().val(),
						sumPrice: $(this).parent().siblings(".sumPrice").children().val(),
						sumMileage: $(this).parent().siblings(".sumMileage").children().val(),
				}
				itemArray.push(item_);
			});

			$.ajax({
				method: 'POST',
				url: '/order/confirm',
				traditional: true,
				data: JSON.stringify(itemArray),
				contentType: "application/json",
				dataType: 'json',
				success: function(data){
					
				}
			});

		});
	});
	
</script>
</head>
<body>
	<div>
		<h3>장바구니</h3>
		<div>
			<table border="1">
				<thead>
					<tr>
						<th>선택</th>
						<th>카테고리번호</th>
						<th>상품번호</th>
						<th>상품명</th>
						<th>상품사진</th>
						<th>주문수량</th>
						<th>가격</th>
						<th>마일리지</th>
						<th>가격합계</th>
						<th>마일리지합계</th>
						<th>관리</th>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${list.size() < 1}">
						<tr>
							<td colspan="10">등록 된 상품이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach var="item" items="${list}">
						<tr>
							<td class="productId"><input type="checkbox" name="check" value="${item.productId}"></td>
							<td class="categoryId" >${item.categoryId}<input type="hidden" value="${item.categoryId}"></td>
							<!-- <td>${item.productId}<input class="productId" type="hidden" value="${item.productId}"></td> -->
							<td>${item.productName}</td>
							<td><img src="/upload/files/${item.image}"></td>
							<td class="count"><input name="count" type="number" value="${item.count}"></td>
							<td>${item.price}</td>
							<td>${item.mileage}</td>
							<td class="sumPrice"><input type="number"></td>
							<td class="sumMileage"><input type="number"></td>
							<td><a href="delete/${item.productId}">삭제</a></td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</div>
		<div>
			<button class="decide">주문하기</button>
			<a href="..">처음으로</a>
		</div>
	</div>
</body>
</html>