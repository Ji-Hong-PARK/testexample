<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark" style="width: 280px;">
            <a href="/admin" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                <i class="bi bi-wrench"></i>
                <span class="fs-4">관리페이지</span>
            </a>
            <hr>
            <ul class="nav nav-pills flex-column mb-auto">
                <li class="nav-item">
                <a href="/admin" class="nav-link active" aria-current="page">
                    <i class="bi bi-house-door"></i>
                    홈
                </a>
                </li>
                <li>
                <a href="/admin/category" class="nav-link text-white">
                    <i class="bi bi-card-list"></i>
                    카테고리관리
                </a>
                </li>
                <li>
                <a href="/admin/product" class="nav-link text-white">
                    <i class="bi bi-box-seam"></i>
                    상품관리
                </a>
                </li>
                <li>
                <a href="/admin/order" class="nav-link text-white">
                    <i class="bi bi-table"></i>
                    주문관리
                </a>
                </li>
                <li>
                <a href="/admin/notice" class="nav-link text-white">
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
        </div>