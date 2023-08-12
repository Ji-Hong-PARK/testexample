<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    	<!-- head -->
		<jsp:include page="../include/head.jsp"></jsp:include>
<style>
	#reset{
		text-decoration: none;
		color: black;
	}
</style>
<script>
$(function(){	
	$.ajax({
		method: "POST",
		url: "/basket/count",
		dataType: "text",
		success: (function(count){
			$("#cartCount").text(count);
		})
	});
	
	
	$(".pager").click(function(){		
		const page = $(this).data("page");
		
		$("input[name='page']").val(page);
		$("#frm").submit();
	});
	
	$("#search").click(function(){
		const keyword = $("#keyword").val();
		$("input[name='keyword']").val(keyword);
				
		const min = Number($("#min").val());
		const max = Number($("#max").val());
		console.log(min);
		console.log(max);
		
		if(min == 0 && max == 0){
			$("input[name='search2']").val(0);
			
			let aaa = $("input[name='search2']").val();
			console.log(aaa);
			$("#frm").submit();
			
			return false;
		}
		
		if(min < 0 || max < 0){
			alert("0보다 큰 가격을 입력해주세요.");
			$("#min").focus();
		}else if(min > max){
			alert("왼쪽에 더 작은 가격을 입력해주세요.");
			$("#min").focus();
		}else{
			$("input[name='min']").val(min);
			$("input[name='max']").val(max);
			$("input[name='search2']").val(1);
			$("input[name='page']").val(1);
			
			$("#frm").submit();
		}
	});
	
	$("input[name='btnradio']").click(function(){
		const sort = Number($(this).val());
		$("input[name='sort']").val(sort);
		
		$("#frm").submit();
	});
	
	$("#reset").click(function(){
		$("#keyword").val("");
		$("#min").val(0);
		$("#max").val(0);
		$("input[name='sort']").val(0);
		$("input[name='page']").val(1);
		$("input[name='search2']").val(0);
		
		$("#frm").submit();
	});
})
</script>
</head>
<body>
        <!-- Navigation-->
        <jsp:include page="../include/navigation.jsp"></jsp:include>
        <!-- Header-->
        <jsp:include page="../include/header.jsp"></jsp:include>
	<div class="container position-relative">
		<h3 class="px-4 px-lg-5 mt-5"><a href="#" id="reset">카테고리: ${categoryName}</a></h3>
		<div class="px-4 px-lg-5 mt-5 row">
			<div>
				<div class="input-group mb-3">
					<input id="keyword" type="text" class="form-control" placeholder="검색어" value="${pager.keyword}">
					<button class="btn btn-outline-secondary" type="button" id="search">검색</button>
				</div>
				<label class="form-label">가격대</label>
				<div class="input-group mb-3">
					<input id="min" type="number" class="form-control" placeholder="낮은가격" value="${pager.min}">
					<span class="input-group-text">원 ~</span>
					<input id="max" type="number" class="form-control" placeholder="높은가격" value="${pager.max}">
				</div>
			</div>
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				<input type="radio" class="btn-check" name="btnradio" id="sort0" autocomplete="off" value=0 ${pager.sort == 0 ? 'checked' : ''}>
				<label class="btn btn-outline-primary" for="sort0">최신상품순</label>
				<input type="radio" class="btn-check" name="btnradio" id="sort1" autocomplete="off" value=2 ${pager.sort == 2 ? 'checked' : ''}>
				<label class="btn btn-outline-primary" for="sort1">인기순</label>
				<input type="radio" class="btn-check" name="btnradio" id="sort2" autocomplete="off" value=4 ${pager.sort == 4 ? 'checked' : ''}>
				<label class="btn btn-outline-primary" for="sort2">높은가격순</label>
				<input type="radio" class="btn-check" name="btnradio" id="sort3" autocomplete="off" value=5 ${pager.sort == 5 ? 'checked' : ''}>
				<label class="btn btn-outline-primary" for="sort3">낮은가격순</label>
			</div>
		</div>		
        <!-- product Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div id="each" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    
                    <c:forEach var="item" items="${productList}">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <c:choose>
                            	<c:when test="${item.image != 'null'}">
                            		<a href="/product/view/${item.productId}"><img class="card-img-top" src="/upload/files/${item.image}" alt="..." /></a>	
                            	</c:when>
                            	<c:otherwise>
                            		<a href="/product/view/${item.productId}"><img class="card-img-top" src="/upload/files/no-image.jpg" alt="..." /></a>
                            	</c:otherwise>
                            </c:choose>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                   <h5 class="fw-bolder">${item.productName}</h5>
                                    <!-- Product price-->
                                    <p>${item.price}원</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
        </section>
		<nav aria-label="pagination" class="position-absolute bottom-0 start-50 translate-middle-x">
			<ul class="pagination">
				<li class="page-item"><a href="#" class="pager page-link" id="first" data-page=1>처음</a></li>
				<li class="page-item"><a href="#" class="pager page-link" id="prev" data-page="${pager.prev}">이전</a></li>
					<c:forEach var="page" items="${pager.list}">
						<li class="page-item ${pager.page == page ? 'active' : ''}"><a href="#" class="pager page-link" id="page" data-page="${page}">${page}</a></li>
					</c:forEach>
				<li class="page-item"><a href="#" class="pager page-link" id="next" href="#" data-page="${pager.next}">다음</a></li>
				<li class="page-item"><a href="#" class="pager page-link" id="last" href="#" data-page="${pager.last}">마지막</a></li>
			</ul>
		</nav>
	</div>
	<!-- Footer-->
	<jsp:include page="../include/footer.jsp"></jsp:include>
	
	<form id="frm" action="/category/${categoryId}" method="POST">
		<input type="hidden" name="page" value="${pager.page}">
		<input type="hidden" name="total" value="${pager.total}">
		<input type="hidden" name="search" value="${pager.search}">
		<input type="hidden" name="search2" value="${pager.search2}">
		<input type="hidden" name="keyword" value="${pager.keyword}">
		<input type="hidden" name="sort" value="${pager.sort}">
		<input type="hidden" name="min" value="${pager.min}">
		<input type="hidden" name="max" value="${pager.max}">
		<input type="hidden" name="prev" value="${pager.prev}">
		<input type="hidden" name="next" value="${pager.next}">
		<input type="hidden" name="last" value="${pager.last}">
	</form>
</body>
</html>