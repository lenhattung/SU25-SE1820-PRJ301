<%-- 
    Document   : menu.jsp
    Created on : Jul 01, 2025
    Author     : tungi
    Description: Menu navigation component
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Kiểm tra trạng thái đăng nhập -->
<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />

<!-- Navigation Menu -->
<nav class="main-nav">
    <ul class="nav-menu">
        <c:choose>
            <c:when test="${isLoggedIn}">
                <!-- Menu cho user đã đăng nhập -->
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/ProductController?action=searchProduct&strKeyword=" class="nav-link">
                        <i class="fas fa-list"></i>
                        All Products
                    </a>
                </li>
                
                <!-- Menu chỉ dành cho Admin -->
                <c:if test="${isAdmin}">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/productForm.jsp" class="nav-link">
                            <i class="fas fa-plus-circle"></i>
                            Add Product
                        </a>
                    </li>
                    
                    
                </c:if>
                
                <!-- Search nhanh -->
                <li class="nav-item nav-search">
                    <form action="${pageContext.request.contextPath}/ProductController" method="post" class="quick-search-form">
                        <input type="hidden" name="action" value="searchProduct"/>
                        <div class="search-wrapper">
                            <input type="text" name="strKeyword" placeholder="Quick search..." class="quick-search-input"/>
                            <button type="submit" class="quick-search-btn">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </li>
                
            </c:when>
            <c:otherwise>
                <!-- Menu cho user chưa đăng nhập -->
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/MainController?action=login" class="nav-link">
                        <i class="fas fa-sign-in-alt"></i>
                        Login
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/MainController?action=register" class="nav-link">
                        <i class="fas fa-user-plus"></i>
                        Register
                    </a>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
    
    <!-- Mobile menu toggle -->
    <button class="mobile-menu-toggle" onclick="toggleMobileMenu()">
        <i class="fas fa-bars"></i>
    </button>
</nav>

<script>
    // Dropdown functionality
    function toggleDropdown(menuId) {
        const menu = document.getElementById(menuId);
        menu.classList.toggle('show');
        
        // Đóng dropdown khác khi click
        document.addEventListener('click', function(event) {
            if (!event.target.closest('.dropdown')) {
                document.querySelectorAll('.dropdown-menu').forEach(menu => {
                    menu.classList.remove('show');
                });
            }
        });
    }
    
    // Mobile menu functionality
    function toggleMobileMenu() {
        const navMenu = document.querySelector('.nav-menu');
        navMenu.classList.toggle('mobile-active');
    }
    
    // Highlight active menu item
    document.addEventListener('DOMContentLoaded', function() {
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav-link');
        
        navLinks.forEach(link => {
            if (link.href && currentPath.includes(link.getAttribute('href'))) {
                link.classList.add('active');
            }
        });
    });
</script>