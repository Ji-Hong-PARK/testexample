<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<script>
	function submit(){
		const form = document.search;
		
		if(parseInt(form.minPrice.value) > parseInt(form.maxPrice.value)){
			alert("좌측에 더 작은 가격을 입력해주세요")
			form.minPrice.focus();
			return;
		}
		 
		if(form.keyword.value == ''){
			form.search.value = 0;
		}else{
			form.search.value = 1;
		}
		form.submit();
	}
	function sort0(){		
		const form = document.search;	
		form.sort.value = 0;
		submit();
	}
	function sort1(){		
		const form = document.search;	
		form.sort.value = 1;
		submit();
	}
	function sort2(){		
		const form = document.search;	
		form.sort.value = 2;
		submit();
	}
	function sort3(){		
		const form = document.search;	
		form.sort.value = 3;
		submit();
	}
</script>
</head>
<body>
	<div>
		<h3><a href=".">상품 목록</a></h3>
		<div>
			<form name="search">
				<div>
					<div>
						<input type="text" name="keyword" value="${pager.keyword}">						
					</div>
					<div>
						<!-- 확인을 위해 text타입을 지정했으나 나중에는 hidden으로 숨길 예정 -->
						<label>서치</label>
						<input type="text" name="search" value="${pager.search}">
						<label>소트</label>
						<input type="text" name="sort" value="${pager.sort}">					
					</div>
					<div>
						<label>가격</label>
						<input type="number" name="minPrice" value="${pager.minPrice}">
						<label>원 ~</label>
						<input type="number" name="maxPrice" value="${pager.maxPrice}">
						<label>원</label>
					</div>
				</div>
			</form>
			<div>
				<button onclick="submit()">검색</button>
			</div>
			<div>
				<button onclick="sort0()">최신상품순</button>
				<button onclick="sort1()">인기순</button>
				<button onclick="sort2()">높은가격순</button>
				<button onclick="sort3()">낮은가격순</button>
			</div>
		</div>		
		<div>
			<table border="1">
				<thead>
					<tr>
						<th>카테고리번호</th>
						<th>상품번호</th>
						<th>상품명</th>
						<th>상품사진</th>
						<th>가격</th>
						<th>마일리지</th>
						<th>재고</th>
						<th>등록일</th>
						<th>판매량</th>
						<th>장바구니담기</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${list.size() < 1}">
						<tr>
							<td colspan="11">등록 된 상품이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${item.categoryId}</td>
							<td>${item.productId}</td>
							<td><a href="view/${item.productId}">${item.productName}</a></td>
							<td><img src="/upload/files/${item.image}"></td>
							<td>${item.price}</td>
							<td>${item.mileage}</td>
							<td>${item.inventory}</td>
							<td><fmt:formatDate value="${item.productDate}" pattern="yyyy년 MM월 dd일"/></td>
							<td>${item.productSales}</td>
							<td><a href="../basket/add/${item.productId}">장바구니담기(임시)</a></td>
							<td><a href="delete/${item.productId}">삭제</a> <a href="update/${item.productId}">변경</a></td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="11">
							<div>
								<div><a href="?page=1&${pager.query}">처음</a></div>
								<div><a href="?page=${pager.prev}&${pager.query}">이전</a></div>
									<c:forEach var="page" items="${pager.list}">
										<div ${pager.page == page ? 'active' : '' }><a href="?page=${page}&${pager.query}">${page}</a></div>
									</c:forEach>
								<div><a href="?page=${pager.next}&${pager.query}">다음</a></div>
								<div><a href="?page=${pager.last}&${pager.query}">마지막</a></div>
							</div>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>
			<a href="add">등록</a>
			<a href="..">처음으로</a>
		</div>
	</div>
</body>
</html>