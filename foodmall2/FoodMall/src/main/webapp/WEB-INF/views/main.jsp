<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
    	<!-- head -->
		<jsp:include page="include/head.jsp"></jsp:include>
    </head>

    <body>
        <!-- Navigation-->
        <jsp:include page="include/navigation.jsp"></jsp:include>
        <!-- Header-->
        <jsp:include page="include/header.jsp"></jsp:include>
        <!-- product Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
            <h3>JINU FOOD의 최신 상품</h3>
            <br>
                <div id="each" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:forEach var="item" items="${productList}">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <a href="product/view/${item.productId}"><img class="card-img-top" src="/upload/files/${item.image}" alt="..." /></a>
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
        <!-- Footer-->
        <jsp:include page="include/footer.jsp"></jsp:include>
        
    </body>
</html>