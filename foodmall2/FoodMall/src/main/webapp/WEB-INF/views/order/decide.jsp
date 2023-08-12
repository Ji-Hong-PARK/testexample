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
		<h3>주문하기</h3>
		<div>
			<table border="1" class="table">
				<thead>
					<tr>
						<th>카테고리</th>
						<th>상품번호</th>
						<th>상품사진</th>
						<th>상품명</th>
						<th>주문수량</th>
						<th>가격</th>
						<th>마일리지</th>
						<th>가격합계</th>
						<th>마일리지합계</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${orderList.size() < 1}">
						<tr>
							<td colspan="9">등록 된 상품이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach var="item" items="${orderList}">
						<tr class="orderList">
							<td class="categoryId" >${item.categoryId}<input type="hidden" value="${item.categoryId}"></td>
							<td class="productId" >${item.productId}<input type="hidden" value="${item.productId}"></td>
							<td><img src="/upload/files/${item.image}" style="weight:100px; height:100px;"></td>
							<td>${item.productName}</td>
							<td class="count"><input name="count" type="number" value=1></td>
							<td class="price">${item.price}</td>
							<td class="mileage">${item.mileage}</td>
							<td class="sumPrice"><input type="number" value="${item.price}" readonly></td>
							<td class="sumMileage"><input type="number" value="${item.mileage}" readonly></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div>
			<div>
				<input id="memberId" type="hidden" value="${sessionScope.member.memberId}">
			</div>
			<div>
				<p>사용가능 마일리지: ${sessionScope.member.memberMileage}</p>
			</div>
			<div>
				<label>사용 마일리지</label>
				<input id="useMileage" name="useMileage" type="number" value="0">
				<button id="mileageBtn" class="btn btn-outline-secondary btn-sm">적용하기</button>
			</div>
			<div>
				<label>배송지</label>
				<input id="destination" type="text">
			</div>
			<div>
				<label>결제수단</label>
				<div>
					<input type="radio" name="pay" value="card" id="card">
					<label for="card">신용카드</label>
				</div>
				<div>
					<input type="radio" name="pay" value="transfer" id="transfer">
					<label for="transfer">계좌이체</label>
				</div>
			</div>
			<div>
				<label>총 가격 합계</label>
				<input id="sumPriceLast" type="number" readonly>
			</div>
			<div>
				<label>적립예정 마일리지 합계</label>
				<input id="sumMileageLast" type="number" readonly>
			</div>
		</div>
		<div>
			<button class="order btn btn-primary">주문하기</button>
			<a href=".." class="btn btn-warning">처음으로</a>
		</div>
	</div>
	
	<!-- Footer-->
    <jsp:include page="../include/footer.jsp"></jsp:include>	
<script>
	let state = 1;

	function addDetail(orderId){
		let list = [];
		
		$(".orderList").each(function(){
			let item = {
					categoryId: $(this).children().siblings(".categoryId").children().val(),
					productId: $(this).children().siblings(".productId").children().val(),
					count: $(this).children().siblings(".count").children().val(),
					sumPrice: $(this).children().siblings(".sumPrice").children().val(),
					sumMileage: $(this).children().siblings(".sumMileage").children().val(),
					orderId: orderId
			}
			list.push(item);
		});
		
		$.ajax({
			method: "POST",
			url: "/order/addOrderDetail",
			traditional: true,
			data: JSON.stringify(list),
			contentType: "application/json",
			dataType: 'json',
			success: function(data){
				$.ajax({
					method: "POST",
					url: "/basket/count",
					dataType: "text",
					success: (function(count){
						
					})
				});
				let url = "/order/complete?orderId=" + data[0].orderId;
				location.href = url;
			}
		});
	}

	function sumItem(){
		let sumPriceLast = 0;
		let sumMileageLast = 0;

		$(".orderList").each(function(){
			sumPriceLast += Number($(this).children().siblings(".sumPrice").children().val());
			sumMileageLast += Number($(this).children().siblings(".sumMileage").children().val());
		})

		sumPriceLast -= $("input[name='useMileage']").val();
		
		$("#sumPriceLast").val(sumPriceLast);
		$("#sumMileageLast").val(sumMileageLast);
	}

	$(function(){
		sumItem();
		
		// 마일리지 확인
		$.ajax({
			method: "POST",
			url: "/member/mileage",
			dataType: "text",
			success: function(data){
				console.log(data);
			}
		});
		
		$("#mileageBtn").on("click", function(){
			const userMileage = ${sessionScope.member.memberMileage};
			const inputMileage = $("input[name='useMileage']").val();
			if(inputMileage > userMileage){
				alert("보유한 마일리지 보다 큰 값을 입력하셨습니다.");
				return false;
			}
			sumItem();
			state = 1;
		});
		
		$("input[name='useMileage']").on("change", function(){
			state = 0;
		});
		
		$("input[name='count']").on("change", function(){
			const count = $(this).val();
			const price = $(this).parent().siblings(".price").text();
			const mileage = $(this).parent().siblings(".mileage").text();

			$(this).parent().siblings(".sumPrice").children().val(count * price);
			$(this).parent().siblings(".sumMileage").children().val(count * mileage);
			sumItem();
		});

		$(".order").click(function(){
			if(state == 0){
				alert("마일리지를 사용하시려면 적용하기 버튼을 클릭해주세요.");
				return false;
			}
			
			let orderInfo = {
					memberId: $("#memberId").val(),
					destination: $("#destination").val(),
					pay: $('input[type="radio"]:checked').val(),
					sumPriceLast: $("#sumPriceLast").val(),
					sumMileageLast: $("#sumMileageLast").val(),
					useMileage: $("#useMileage").val()
			}
			
			
			$.ajax({
				method: "POST",
				url: "/order/addOrderInfo",
				data: JSON.stringify(orderInfo),
				contentType: "application/json",
				dataType: "json",
				success: function(data){
					addDetail(data.orderId);
				}
			});
			

		});
	});
	
</script>
</body>
</html>