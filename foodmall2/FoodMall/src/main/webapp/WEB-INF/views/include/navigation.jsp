<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="http://localhost:8585/main">JINUFOOD</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="/main">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">About</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Category</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown" id="category-dropdown">
                                <li><a class="dropdown-item" href="/category/0">전체상품</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <!-- 카테고리 -->
                                <!-- footer에서 ajax로 받아와서 추가해줌 -->
                            </ul>
                        </li>
                    </ul>
                    <div class="d-flex">              	
                    	<c:if test="${sessionScope.member == null }">
                    		<a class="btn btn-outline-dark loginBtn" data-bs-toggle="modal" data-bs-target="#loginModal" data-bs-whatever="login">
	                            <i class="bi bi-person-check-fill"></i>
	                            로그인
                        	</a>
                        	<a class="btn btn-outline-dark join" href="/member/add">
	                            <i class="bi bi-person-plus-fill"></i>
	                            회원등록
                        	</a>
                        	<a class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#loginModal" data-bs-whatever="login">
	                            <i class="bi bi-basket2-fill me-1"></i>
	                            장바구니
	                            <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                        	</a>
                    	</c:if>
                    	<c:if test="${sessionScope.member != null }">
                    		<p style="margin:0.5rem;">${sessionScope.member.memberId}님 환영합니다!</p>
                    		<a class="btn btn-outline-dark" href="/order/list">
	                            <i class="bi bi-gift"></i>
	                            주문내역
                        	</a>
                    		<a class="btn btn-outline-dark" id="logout">
	                            <i class="bi bi-person-x-fill"></i>
	                            로그아웃
                        	</a>
                        	<a class="btn btn-outline-dark" href="/basket">
	                            <i class="bi bi-basket2-fill me-1"></i>
	                            장바구니
	                            <span id="cartCount" class="badge bg-dark text-white ms-1 rounded-pill">${sessionScope.basketCount}</span>
                        	</a>
                    	</c:if>
                    </div>
                </div>
            </div>
        </nav>