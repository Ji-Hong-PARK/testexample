<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
    	<!-- head -->
		<jsp:include page="include/headAdmin.jsp"></jsp:include>
    </head>

    <body>
        <!-- Navigation-->
        <jsp:include page="include/navigation.jsp"></jsp:include>
        
        <!-- Header-->
        <header class="bg-dark py-5 mainheader">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">관리자용 페이지</h1>
                </div>
            </div>
        </header>
        
        <div id="admin">
        	<div id="adminContent" class="mt-5">
				<div class="row">
				  <div class="col-sm-4">
				    <div class="card">
				      <div class="card-body">
				        <h5 class="card-title">카테고리 관리</h5>
				        <p class="card-text">카테고리 추가, 이름 변경, 비활성화 등의 관리를 할 수 있습니다.</p>
				        <a href="#" class="btn btn-primary aside-menu">Go somewhere</a>
				      </div>
				    </div>
				  </div>
				  <div class="col-sm-4">
				    <div class="card">
				      <div class="card-body">
				        <h5 class="card-title">상품 관리</h5>
				        <p class="card-text">상품 추가 및 정보 수정을 할 수 있습니다.</p>
				        <a href="#" class="btn btn-primary aside-menu">Go somewhere</a>
				      </div>
				    </div>
				  </div>
				  <div class="col-sm-4">
				    <div class="card">
				      <div class="card-body">
				        <h5 class="card-title">주문 관리</h5>
				        <p class="card-text">요청 받은 주문을 처리 할 수 있습니다.</p>
				        <a href="#" class="btn btn-primary aside-menu">Go somewhere</a>
				      </div>
				    </div>
				  </div>
				</div>
        	</div>
        	
	        <!-- side -->
	        <aside class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark">
	            <a href="/admin" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
	                <i class="bi bi-wrench"></i>
	                <span class="fs-4">관리페이지</span>
	            </a>
	            <hr>
	            <ul class="nav nav-pills flex-column mb-auto">
	                <li class="nav-item">
	                <a href="/admin" class="nav-link text-white aside-menu active" aria-current="page" id="home">
	                    <i class="bi bi-house-door"></i>
	                    홈
	                </a>
	                </li>
	                <li>
	                <a href="#" class="nav-link text-white aside-menu" id="category">
	                    <i class="bi bi-card-list"></i>
	                    카테고리관리
	                </a>
	                </li>
	                <li>
	                <a href="#" class="nav-link text-white " id="product">
	                    <i class="bi bi-box-seam"></i>
	                    상품관리
	                </a>
	                </li>
	                <li>
	                <a href="#" class="nav-link text-white aside-menu" id="order">
	                    <i class="bi bi-table"></i>
	                    주문관리
	                </a>
	                </li>
	                <li>
	                <a href="#" class="nav-link text-white aside-menu" id="notice">
	                    <i class="bi bi-info-circle"></i>
	                    공지사항관리
	                </a>
	                </li>
	            </ul>
	            <hr>
	            <div class="dropdown">
	              <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
	                <!-- <img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2"> -->
	                <i class="bi bi-person-circle"></i>
	                <strong>admin</strong>
	              </a>
	              <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
	                <li><a class="dropdown-item" href="#">New project...</a></li>
	                <li><a class="dropdown-item" href="#">Settings</a></li>
	                <li><a class="dropdown-item" href="#">Profile</a></li>
	                <li><hr class="dropdown-divider"></li>
	                <li><a class="dropdown-item" href="#">Sign out</a></li>
	              </ul>
	            </div>
	        </aside>
        </div>
        


        <!-- Footer-->
        <jsp:include page="include/footer.jsp"></jsp:include>
        
        <!-- Category Modal -->
		<div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="categoryModalLabel">카테고리 수정</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="categoryForm">
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">카테고리번호</label>
								<input type="text" class="form-control" name="categoryId" readonly>
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">카테고리이름</label>
								<input type="text" class="form-control" name="categoryName">
							</div>
							<div class="mb-3">
								<p>카테고리 활성화 여부</p>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="categoryState" id="categorySY" value="Y">
									<label class="form-check-label" for="categorySY">
										Y
									</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="categoryState" id="categorySN" value="N">
									<label class="form-check-label" for="categorySN">
								    	N
									</label>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="category-update-submit">수정</button>
						<button type="button" class="btn btn-primary" id="category-add-submit">추가</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Product Modal Add -->
		<div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="productModalLabel">상품 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="productForm">										 
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">카테고리</label>
								<select name="categoryId">
								</select>
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상품명</label>
								<input type="text" class="form-control" name="productName">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">가격</label>
								<input type="number" class="form-control" name="price">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">마일리지</label>
								<input type="number" class="form-control" name="mileage">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">재고</label>
								<input type="number" class="form-control" name="inventory">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상품정보</label>
								<input type="text" class="form-control" name="productInfo">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상태</label>
								<select name="productState">
									<option value="1">판매중</option>
									<option value="2">판매중단</option>
									<option value="3">재고없음</option>
									<option value="4">비활성화</option>
								</select>
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상품이미지</label>
								<input type="file" class="form-control" id="addUpload" name="uploadFile" accept="image/jpeg, image/jpg, image/png">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">이미지 미리보기</label>
								<img src="" id="addPreview">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="product-add-submit">추가</button>
					</div>
				</div>
			</div>
		</div>
     
		<!-- Product Modal Update -->
		<div class="modal fade" id="productModalUpdate" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="productModalLabel">상품 수정</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="productUpdateForm">
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상품번호</label>
								<input type="text" class="form-control" name="productId" readonly>
							</div>											 
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">카테고리</label>
								<select name="categoryId">
								</select>
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상품명</label>
								<input type="text" class="form-control" name="productName">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">가격</label>
								<input type="number" class="form-control" name="price">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">마일리지</label>
								<input type="number" class="form-control" name="mileage">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">재고</label>
								<input type="number" class="form-control" name="inventory">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상품정보</label>
								<input type="text" class="form-control" name="productInfo">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상태</label>
								<select name="productState">
									<option value="1">판매중</option>
									<option value="2">판매중단</option>
									<option value="3">재고없음</option>
									<option value="4">비활성화</option>
								</select>
							</div>
							<div class="mb-3">
								<input type="hidden" class="form-control" name="image">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상품이미지</label>
								<input type="file" class="form-control" id="updateUpload" name="uploadFile" accept="image/jpeg, image/jpg, image/png">
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">이미지 미리보기</label>
								<img src="" id="updatePreview">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="product-update-submit">수정</button>
					</div>
				</div>
			</div>
		</div>
     
     
		<!-- order Modal Update -->
		<div class="modal fade" id="orderModal" tabindex="-1" aria-labelledby="orderModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="orderModalLabel">주문 관리</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="orderForm">
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">주문번호</label>
								<input type="text" class="form-control" name="orderId" readonly>
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">회원ID</label>
								<input type="text" class="form-control" name="memberId" readonly>
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">주문일</label>
								<input type="text" class="form-control" name="orderDate" readonly>
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">상태</label>
								<select name="orderState">
									<option value="0">접수중</option>
									<option value="1">접수완료</option>
									<option value="2">배송중</option>
									<option value="3">배송완료</option>
									<option value="4">주문취소</option>
									<option value="5">반품</option>
									<option value="6">기타</option>
								</select>
							</div>
							<div>
								<label for="recipient-name" class="col-form-label">주문한 상품 리스트</label>
								<table class="table" id="orderDetail">
									<thead>
										<tr>
											<th>상품번호</th>
											<th>상품명</th>
											<th>수량</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="order-submit">수정</button>
					</div>
				</div>
			</div>
		</div>
        
        <script>
        	const state = {
    			page: 1,
    			perPage: 10,
    			search: 0,
    			search2: 0,
    			keyword: "",
    			categoryId: 0,
    			state: 0,
    			menu: "home",
    			sort: 0,
    			min: 0,
    			max: 0
    		}
        	
        	function resetState(){
        		state.page = 1;
        		state.perPage = 10;
        		state.search = 0;
        		state.keyword = "";
        		state.categoryId = 0;
        		state.state = "";
        		state.sort = 0;
        	}      	

        	$(function(){
        		// aside 메뉴 액티브
          		$("aside .nav-link").on("click", function(){ 
        			$(".nav-link").removeClass("active");
        			$(this).addClass("active");				
        		});
        		 
        		
        		// 페이지 이동(페이저 클릭)
        		$("#admin").on("click", ".page-link", function(){
        			if(state.menu == 'product'){
        				moveProduct($(this).data("page"));
        			}else if(state.menu == 'order'){
        				moveOrder($(this).data("page"));
        			}
        		});
        		
        	});
        	
        </script>
        <script src="/resources/js/adminCategory.js"></script>
        <script src="/resources/js/adminProduct.js"></script>
        <script src="/resources/js/adminOrder.js"></script>
    </body>
</html>