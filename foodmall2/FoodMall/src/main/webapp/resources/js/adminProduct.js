// productAdd 업로드 이미지 미리보기
document.getElementById("addUpload").onchange = function(){
	let reader = new FileReader();
	
	reader.onload = function(e) {
		document.getElementById("addPreview").src = e.target.result;
		document.getElementById("addPreview").style.width = '300px';
		document.getElementById("addPreview").style.height = '300px';
		$("#addPreview").show();
	};
	reader.readAsDataURL(this.files[0]);
};

// productUpdate 업로드 이미지
document.getElementById("updateUpload").onchange = function(){
	let reader = new FileReader();
	
	reader.onload = function(e) {
		document.getElementById("updatePreview").src = e.target.result;
		document.getElementById("updatePreview").style.width = '300px';
		document.getElementById("updatePreview").style.height = '300px';
	};
	reader.readAsDataURL(this.files[0]);
};

// 상품관리
function moveProduct(page){
	
	state.page = page;
	
	$.ajax({
		url: "/admin/product",
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(state),
		dataType: "json",
		success: function(data){
			
			$("tbody").remove();
			
			const tbody = $("<tbody>");

			for(let i=0; i<data.productList.length; i++){
				const tr = $("<tr>");
				
				tr.attr("data-productid", data.productList[i].productId);
				tr.attr("data-productname", data.productList[i].productName);    						
				tr.attr("data-categoryname", data.productList[i].categoryName);
				tr.attr("data-price", data.productList[i].price);
				tr.attr("data-mileage", data.productList[i].mileage);
				tr.attr("data-inventory", data.productList[i].inventory);
				tr.attr("data-productstate", data.productList[i].productState);
				tr.attr("data-productinfo", data.productList[i].productInfo);
				tr.attr("data-image", data.productList[i].image);

				
				tr.append($("<td>").text(data.productList[i].productId).addClass("productId") );
				tr.append($("<td>").text(data.productList[i].productName).addClass("productName") );
				tr.append($("<td>").text(data.productList[i].categoryName).addClass("categoryName") );
				tr.append($("<td>").text(data.productList[i].price).addClass("price") );
				tr.append($("<td>").text(data.productList[i].mileage).addClass("mileage") );
				tr.append($("<td>").text(data.productList[i].inventory).addClass("inventory") );
				tr.append($("<td>").text(data.productList[i].productSales).addClass("productSales") );
				
				if(data.productList[i].productState == 1){
					tr.append($("<td>").text("판매중").addClass("productState") );	
				}else if(data.productList[i].productState == 2){
					tr.append($("<td>").text("판매중단").addClass("productState") );
				}else if(data.productList[i].productState == 3){
					tr.append($("<td>").text("재고없음").addClass("productState") );
				}else if(data.productList[i].productState == 4){
					tr.append($("<td>").text("비활성화").addClass("productState") );
				}else{
					tr.append($("<td>").text(data.productList[i].productState).addClass("productState") );
				}
				
				
				const td = $("<td>");
				
				td.append( $("<button>").text("수정").addClass("productUpdate btn-sm btn-warning mx-1").attr("data-bs-target","#productModalUpdate").attr("data-bs-toggle", "modal") );
				tr.append(td);
				tbody.append(tr);
			}
			
			$("table").append(tbody);
			
			// 페이저
			$("tfoot").remove();
			
			const tfoot = $("<tfoot>");
			const td = $("<td>").attr("colspan", "9");
			
			const div = $("<div>").addClass("pagination pagination-sm justify-content-center")
			div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", "1").text("처음") ));
			div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", data.pager.prev).text("이전") ));
			
			for(let i=0; i<data.pager.list.length; i++){
				if(state.page == data.pager.list[i]){
					div.append($("<div>").addClass("page-item active").append( $("<a>").addClass("page-link").attr("data-page", data.pager.list[i]).text(data.pager.list[i]) ));	
				}else{
					div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", data.pager.list[i]).text(data.pager.list[i]) ));
				}
			}
			
			div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", data.pager.next).text("다음") ));
			div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", data.pager.last).text("마지막") ));
			
			td.append(div);
			
			tfoot.append($("<tr>").append(td) );
			
			$("table").append(tfoot);
		}
	})
	
	
}

$(function(){
        		//product updateModal
        		$("#admin").on("click", "button.productUpdate", function(){        			
        			const product = $(this).parent().parent().data();
        			const tr = $(this).parent().parent();
        			$("#productModalUpdate select[name='categoryId']").children().remove();
        			
        			for(let i=0; i<categoryArray.length; i++){
        				if(categoryArray[i].categoryName == product.categoryname){
        					$("#productModalUpdate select[name='categoryId']").append($("<option>").attr("value", categoryArray[i].categoryId).text(categoryArray[i].categoryName).attr("selected", "true"));
        				}else{
        					$("#productModalUpdate select[name='categoryId']").append($("<option>").attr("value", categoryArray[i].categoryId).text(categoryArray[i].categoryName));
        				}        				
        			}
        			$("#productModalUpdate input[name=productId]").val(product.productid);
        			$("#productModalUpdate input[name=productName]").val(product.productname);
        			$("#productModalUpdate input[name=price]").val(product.price);
        			$("#productModalUpdate input[name=mileage]").val(product.mileage);
        			$("#productModalUpdate input[name=inventory]").val(product.inventory);
        			$("#productModalUpdate input[name=productInfo]").val(product.productinfo);
        			$("#productModalUpdate select[name='productState']").val(product.productstate);
        			$("#productModalUpdate input[name=image]").val(product.image);
        			
        			let url = "/upload/files/" + product.image;
        			$("#updatePreview").attr("src", url).attr("style", "width:300px; height:300px;");
        			
        			
        		});

				//UpdateModal submit        		
				$("#product-update-submit").on("click", function(){
    				const form = document.getElementById("productUpdateForm");
    				const formData = new FormData(form);
    				
    				$.ajax({
    					type: "POST",
    					url: "/admin/product/update",
    					enctype: "multipart/form-data",
    					data: formData,
    					async: true,
    					cache: false,
    					contentType: false,
    					processData: false,
    					success: function(data){
    						$("#productModalUpdate").modal("hide");
    						moveProduct(1);
    					}
    				});
    			});

        		//product addModal
        		$("#admin").on("click", "#addProduct", function(){        			        			
        			$("#productModal select[name='categoryId']").children().remove();
        			$("#addUpload").val("");
        			
        			for(let i=0; i<categoryArray.length; i++){
        				$("#productModal select[name='categoryId']").append($("<option>").attr("value", categoryArray[i].categoryId).text(categoryArray[i].categoryName));
        			}
        			
        		})
        		
				// AddModal submit
    			$("#product-add-submit").on("click", function(){
    				const form = document.getElementById("productForm");
    				const formData = new FormData(form);
    				
    				$.ajax({
    					type: "POST",
    					url: "/admin/product/add",
    					enctype: "multipart/form-data",
    					data: formData,
    					async: true,
    					cache: false,
    					contentType: false,
    					processData: false,
    					success: function(data){
    						$("#productModal").modal("hide");
							$("#productModal input").val("");
							$("#addPreview").hide();
    						moveProduct(1);
    					}
    				});
    			});

        		//프로덕트 검색 조건
        		$("#admin").on("click", "[data-search]", function(){
        			state.search = $(this).data("search");
        			$("#search").text($(this).text());
        		});
        		$("#admin").on("click", "[data-search2]", function(){
        			state.search2 = $(this).data("search2");
        			$("#search2").text($(this).text());
        		});
        		
        		//프로덕트 검색
        		$("#admin").on("click", "#productSearch", function(){
        			const keyword = $("#keyword").val();
        			const min = $("#min").val();
        			const max = $("#max").val();
        			

        			if((min == "" && max != "") || (min != "" && max == "") ){
        				alert("비교할 값을 모두 지우거나 채워주세요.");
        				return false;
        			}
        			if(min < 0 || max < 0){
        				alert("0 이상의 값을 입력해주세요.");
        				return false;
        			}
        			if(min > max){
        				alert("왼쪽에 더 작은 값을 입력해주세요.");
        				return false;
        			}
        			
        			// state
        			if(keyword != ""){
        				state.keyword = keyword;
        			}
        			if(min == "" && max == ""){
        				state.search2 = 0;
        			}
        			if(min >= 0 && max > 0){
        				state.min = min;
        				state.max = max;
        				if(state.search2 == 0){
        					state.search2 = 1;
        				}
        			}
        			        			
        			moveProduct(1);
        		});
        		
        		//프로덕트 정렬 sort
        		$("#admin").on("click", ".productSort", function(){
        			$(".sort").remove();
        			let str = $(this).text();

        			if(state.sort!=0 && str=='상품번호'){
        				state.sort = 0;
        				$(this).text("상품번호").append($("<i>").addClass("bi bi-sort-numeric-down-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=1 && str=='상품번호'){
        				state.sort = 1;
        				$(this).text("상품번호").append($("<i>").addClass("bi bi-sort-numeric-up-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=2 && str=='판매량'){
        				state.sort = 2;
        				$(this).text("판매량").append($("<i>").addClass("bi bi-sort-numeric-down-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=3 && str=='판매량'){
        				state.sort = 3;
        				$(this).text("판매량").append($("<i>").addClass("bi bi-sort-numeric-up-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=4 && str=='가격'){
        				state.sort = 4;
        				$(this).text("가격").append($("<i>").addClass("bi bi-sort-numeric-down-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=5 && str=='가격'){
        				state.sort = 5;
        				$(this).text("가격").append($("<i>").addClass("bi bi-sort-numeric-up-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=6 && str=='이름'){
        				state.sort = 6;
        				$(this).text("이름").append($("<i>").addClass("bi bi-sort-alpha-down sort"));
        				moveProduct(1);
        			}else if(state.sort!=7 && str=='이름'){
        				state.sort = 7;
        				$(this).text("이름").append($("<i>").addClass("bi bi-sort-alpha-up sort"));
        				moveProduct(1);
        			}else if(state.sort!=8 && str=='재고'){
        				state.sort = 8;
        				$(this).text("재고").append($("<i>").addClass("bi bi-sort-numeric-down-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=9 && str=='재고'){
        				state.sort = 9;
        				$(this).text("재고").append($("<i>").addClass("bi bi-sort-numeric-up-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=10 && str=='마일리지'){
        				state.sort = 10;
        				$(this).text("마일리지").append($("<i>").addClass("bi bi-sort-numeric-down-alt sort"));
        				moveProduct(1);
        			}else if(state.sort!=11 && str=='마일리지'){
        				state.sort = 11;
        				$(this).text("마일리지").append($("<i>").addClass("bi bi-sort-numeric-up-alt sort"));
        				moveProduct(1);
        			}
        			
        			
        		})
        		
        		
        		// 프로덕트 - 드롭다운 카테고리 선택
        		$("#admin").on("click", ".dropdown-categoryId", function(){        			
        			$(".dropdown-categoryId").removeClass("active");
        			
        			state.categoryId = $(this).data("categoryid");
        			moveProduct(1);
        			
        			$(this).addClass("active");
        			const name = $(this).text();
        			$(".product-category").text("카테고리: " + name);
        		});
        		
        		// 프로덕트 - 드롭다운 상태 선택
        		$("#admin").on("click", ".dropdown-state", function(){
        			$(".dropdown-state").removeClass("active");
        			
        			state.state = $(this).data("state");
        			moveProduct(1);
        			
        			$(this).addClass("active");
        			const name = $(this).text();
        			$(".product-state").text("상태: " + name);
        		});
        		
        		
        		// 메뉴 - 상품관리
        		$("#product").on("click", function(){
        			resetState();
        			state.menu = "product";
        			

					$("#adminContent").remove();        					
					const adminContent = $("<div>").attr("id","adminContent");        					
					$("#admin").append(adminContent);
					
					//검색창 키워드입력
					const search = $("<div>").addClass("input-group mb-3").css("margin-top", "10px");
					search.append($("<button>").attr("id","search").addClass("btn btn-outline-secondary dropdown-toggle").attr("type","button").attr("data-bs-toggle","dropdown").attr("aria-expanded","false").text("상품명") );
					search.append($("<input>").attr("id", "keyword").attr("type", "text").attr("aria-label","Text input with dropdown button").addClass("form-control") );
					search.append($("<button>").addClass("btn btn-outline-secondary").attr("type","button").attr("id","productSearch").text("검색") );
					const searchUl = $("<ul>").addClass("dropdown-menu dropdown-menu-end");
					searchUl.append($("<li>").append($("<a>").addClass("dropdown-item").attr("href","#").attr("data-search", "0").text("상품명") ) );
					searchUl.append($("<li>").append($("<a>").addClass("dropdown-item").attr("href","#").attr("data-search", "1").text("상품번호") ) );
					search.append(searchUl);
					
					adminContent.append(search);
					
					//검색창 그 외의 조건 (가격대 같은거)
					const search2 = $("<div>").addClass("input-group mb-3").css("margin-top", "10px");
					search2.append($("<button>").attr("id", "search2").addClass("btn btn-outline-secondary dropdown-toggle").attr("type","button").attr("data-bs-toggle","dropdown").attr("aria-expanded","false").text("가격") );
					search2.append($("<input>").attr("id", "min").addClass("form-control").attr("type","number") );
					search2.append($("<span>").addClass("input-group-text").text("~"));
					search2.append($("<input>").attr("id", "max").addClass("form-control").attr("type","number") );
					const searchUl2 = $("<ul>").addClass("dropdown-menu dropdown-menu-end");
					searchUl2.append($("<li>").append($("<a>").addClass("dropdown-item").attr("href","#").attr("data-search2", "1").text("가격") ) );
					searchUl2.append($("<li>").append($("<a>").addClass("dropdown-item").attr("href","#").attr("data-search2", "2").text("마일리지") ) );
					searchUl2.append($("<li>").append($("<a>").addClass("dropdown-item").attr("href","#").attr("data-search2", "3").text("재고") ) );
					searchUl2.append($("<li>").append($("<a>").addClass("dropdown-item").attr("href","#").attr("data-search2", "4").text("판매량") ) );
					search2.append(searchUl2);
					
					adminContent.append(search2);
					
					
					//테이블 헤드
					const table = $("<table>").addClass("table").attr("style", "width:100%");
					adminContent.append(table);

					const thead = $("<thead>");
					const tr = $("<tr>");
					tr.append($("<th>").addClass("productSort").text("상품번호"));
					tr.append($("<th>").addClass("productSort").text("상품명"));
					
					//tr.append($("<th>").text("카테고리"));
					const drop = $("<th>");
					let button = $("<button>").addClass("btn btn-secondary btn-sm dropdown-toggle product-category").attr("type", "button").attr("id", "dropdownMenuButton2").attr("aria-expanded","false").attr("data-bs-toggle", "dropdown").text("카테고리");
					const ul = $("<ul>").addClass("dropdown-menu dropdown-menu-dark").attr("aria-labelledby", "dropdownMenuButton2");
					
					ul.append($("<li>").append($("<a>").addClass("dropdown-item dropdown-categoryId").attr("href", "#").attr("data-categoryid", 0).text("전체") ) );
					if(state.categoryId < 1){
						button.text("카테고리");
					}
					// categoryArray는 footer의 스크립트에 있다.
					for(let i=0; i<categoryArray.length; i++){
						const a = $("<a>").addClass("dropdown-item dropdown-categoryId").attr("href", "#").attr("data-categoryid", categoryArray[i].categoryId).text(categoryArray[i].categoryName);
						
						ul.append($("<li>").append(a));
					}

					drop.append(button);
					drop.append(ul);
					tr.append(drop);
					
					tr.append($("<th>").addClass("productSort").text("가격"));
					tr.append($("<th>").addClass("productSort").text("마일리지"));
					tr.append($("<th>").addClass("productSort").text("재고"));
					tr.append($("<th>").addClass("productSort").text("판매량"));
					
					//tr.append($("<th>").text("상태"));
					const drop1 = $("<th>");
					let button1 = $("<button>").addClass("btn btn-secondary btn-sm dropdown-toggle product-state").attr("type", "button").attr("id", "dropdownMenuButton2").attr("aria-expanded","false").attr("data-bs-toggle", "dropdown").text("상태");
					const ul1 = $("<ul>").addClass("dropdown-menu dropdown-menu-dark").attr("aria-labelledby", "dropdownMenuButton2");
					ul1.append($("<li>").append($("<a>").addClass("dropdown-item dropdown-state").attr("href", "#").attr("data-state", "0").text("전체") ) );
					
					let a1 = $("<a>").addClass("dropdown-item dropdown-state").attr("href", "#").attr("data-state", "1").text("판매중");
					ul1.append($("<li>").append(a1));
					a1 = $("<a>").addClass("dropdown-item dropdown-state").attr("href", "#").attr("data-state", "2").text("판매중단");
					ul1.append($("<li>").append(a1));
					a1 = $("<a>").addClass("dropdown-item dropdown-state").attr("href", "#").attr("data-state", "3").text("재고없음");
					ul1.append($("<li>").append(a1));
					a1 = $("<a>").addClass("dropdown-item dropdown-state").attr("href", "#").attr("data-state", "4").text("비활성화");
					ul1.append($("<li>").append(a1));
					
 					if(state.state == ""){
						button1.text("상태")
					}else{
						button1.text(state.state);
					}
					drop1.append(button1);
					drop1.append(ul1);
					tr.append(drop1);
					
					tr.append($("<th>").text("관리"));
					
					table.append(thead.append(tr));
        			
        			
        			moveProduct(1);
        			
        			const addButton = $("<button>").text("추가").addClass("btn-sm btn-primary mx-1").attr("id","addProduct").attr("data-bs-target","#productModal").attr("data-bs-toggle", "modal");
					$("#adminContent").append(addButton);
        		})
})