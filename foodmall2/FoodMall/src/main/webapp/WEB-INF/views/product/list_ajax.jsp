<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    	<!-- head -->
		<jsp:include page="../include/head.jsp"></jsp:include>
<script>

	const state = {
		page: 1,
		perPage: 12,
		search: 0,
		keyword: "",
		sort: 0,
		minPrice: 0,
		maxPrice: 0,
		categoryId: ${categoryId}
	}
	
	function makeItem(data){
		const div1 = $("<div>").addClass("col mb-5");
		$("#each").append(div1);
		
		const div2 = $("<div>").addClass("card h-100");
		div1.append(div2);
		
		const a1 = $("<a>");
		const path = "/product/view/" + data.productId;
		a1.attr("href", path);
		
		const img = $("<img>");

		let imgPath = "/upload/files/"
		if(data.image === "null"){
			imgPath += "no-image.jpg";
		}else{
			 imgPath += data.image;	
		}
		img.attr("src", imgPath);
		img.addClass("card-img-top");
		a1.append(img);
		div2.append(a1);
		
		const div3 = $("<div>");
		div3.addClass("card-body p-4");
		div2.append(div3);
		
		const div4 = $("<div>");
		div4.addClass("text-center");
		div4.append($("<h5>").addClass("fw-bolder").text(data.productName));
		div3.append(div4);
		
		const div5 = $("<div>");
		div5.addClass("d-flex justify-content-center small text-warning mb-2");
		for(let i=0; i<5; i++){
			div5.append($("<div>").addClass("bi-star-fill"))
		}
		div4.append(div5);
		div4.append($("<p>").text(data.price + "원"));
	}
	
	function movePage(page){
		state.page = page;
		
		$.ajax({
			url: "/product/ajax",
			method: "POST",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify(state),
			success: (function(data){
				console.log(data);
				
				const list = data.productList;
				state.total = data.pager.total;
				
				$("#each").remove();
				
				const each = $("<div>").addClass("row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center");
				each.attr("id", "each");
				$("#container").append(each);
				
				for(let i=0; i<list.length; i++){
					const item = makeItem(list[i]);
					
					each.append(item);
				}
				
				$("#page-prev").data("page", data.pager.prev);
				$("#page-next").data("page", data.pager.next);
				$("#page-last").data("page", data.pager.last);
				
				$(".page-list").remove();
				const pageList = data.pager.list;
				for(let i=0; i<pageList.length; i++){
					const div = $("<div>").addClass("page-item page-list");
					if(data.pager.page === pageList[i]){
						div.addClass("active");
					}
					
					const p = $("<p>");
					p.addClass("page-link");
					p.text(pageList[i]);
					p.attr("data-page", pageList[i]);
					div.append(p);
					
					$("#page-next").parent().before(div);
				}
			})
		})
	}
	
	$(function(){
		
		$("#sort4").on("click", function(){
			state.search = 0;
			state.keyword = "";
			state.sort = $(this).val();
			state.minPrice = 0;
			state.maxPrice = 0;
			movePage(1);
			$("input[name='btnradio']").prop('checked', false);
		})
		
		$("#search").on("click", function(){
			const keyword = $("#keyword").val();
			const min = $("#min").val();
			const max = $("#max").val();
			
			if(min > max){
				alert("좌측에 더 작은 가격을 입력해주세요.");
				$("#min").val("");
				$("#min").focus();
				return;
			}
			
			state.keyword = keyword;
			state.minPrice = min;
			state.maxPrice = max;
			if(keyword === ''){
				console.log("키워드 없음")
			}else{
				state.search = 1;
				console.log(state.search);
			}

			movePage(1);
		})
		
		$("input[name='btnradio']").on("click", function(){
			state.sort = $(this).val();
			movePage(1);
		})
		
		$(".pagination").on("click", ".page-link", function(){
			const page = $(this).data("page");
			movePage(page);
		})
		
		movePage(1);
	})
</script>
</head>
<body>
        <!-- Navigation-->
        <jsp:include page="../include/navigation.jsp"></jsp:include>
        <!-- Header-->
        <jsp:include page="../include/header.jsp"></jsp:include>
	<div>
		<h3><a href=".">상품 목록</a></h3>
		<div class="container px-4 px-lg-5 mt-5">
			<div>
				<div class="input-group mb-3">
					<input id="keyword" type="text" class="form-control" placeholder="검색어">
					<button class="btn btn-outline-secondary" type="button" id="search">검색</button>
				</div>
				<label class="form-label">가격대</label>
				<div class="input-group mb-3">

					<input id="min" type="number" class="form-control" placeholder="낮은가격">
					<span class="input-group-text">원 ~</span>
					<input id="max" type="number" class="form-control" placeholder="높은가격">
				</div>
			</div>
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				<input type="radio" class="btn-check" name="btnradio" id="sort0" autocomplete="off" value=0 ${state.sort == 0 ? 'checked' : ''}>
				<label class="btn btn-outline-primary" for="sort0">최신상품순</label>
				<input type="radio" class="btn-check" name="btnradio" id="sort1" autocomplete="off" value=1 ${state.sort == 1 ? 'checked' : ''}>
				<label class="btn btn-outline-primary" for="sort1">인기순</label>
				<input type="radio" class="btn-check" name="btnradio" id="sort2" autocomplete="off" value=2 ${state.sort == 2 ? 'checked' : ''}>
				<label class="btn btn-outline-primary" for="sort2">높은가격순</label>
				<input type="radio" class="btn-check" name="btnradio" id="sort3" autocomplete="off" value=3 ${state.sort == 3 ? 'checked' : ''}>
				<label class="btn btn-outline-primary" for="sort3">낮은가격순</label>
				<input type="radio" class="btn-check" name="btnradio" id="sort4" autocomplete="off" value=0 >
				<label class="btn btn-outline-primary" for="sort4">검색조건 초기화</label>
			</div>
		</div>		
		<div>
			<!-- product Section-->
        	<jsp:include page="../include/productSection.jsp"></jsp:include>
		</div>
		<div>
			<tr>
				<td colspan="7">
					<div class="pagination pagination-sm justify-content-center">
						<div class="page-item"><p class="page-link" id="page-first" data-page="1">처음</p></div>
						<div class="page-item"><p class="page-link" id="page-prev">이전</p></div>
						<div class="page-item"></div>
						<div class="page-item"><p class="page-link" id="page-next">다음</p></div>
						<div class="page-item"><p class="page-link" id="page-last">마지막</p></div>
					</div>
				</td>
			</tr>
		</div>
	</div>
	<!-- Footer-->
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>