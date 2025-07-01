<%-- 
    Document   : welcome.jsp
    Created on : May 23, 2025, 7:40:45 AM
    Author     : tungi
    Updated    : Jul 01, 2025 - Sử dụng modular components
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- Tạo các biến dùng nhiều lần -->
<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />
<c:set var="keyword" value="${requestScope.keyword}" />
<c:set var="productList" value="${requestScope.list}" />
<c:set var="hasKeyword" value="${not empty keyword}" />
<c:set var="hasProducts" value="${not empty productList}" />
<c:set var="productCount" value="${fn:length(productList)}" />
<c:set var="keywordParam" value="${hasKeyword ? keyword : ''}" />

<!-- Kiểm tra đăng nhập -->
<c:choose>
    <c:when test="${not isLoggedIn}">
        <c:redirect url="MainController"/>
    </c:when>
    <c:otherwise>
        <!-- Include Header với tham số -->
        <jsp:include page="header.jsp">
            <jsp:param name="pageTitle" value="Product Management - Dashboard" />
            <jsp:param name="additionalCSS" value="welcome.css" />
        </jsp:include>

        <!-- Page Content -->
        <div class="page-container">
            <!-- Page Header -->
            <div class="page-header">
                <div class="page-title-section">
                    <h1 class="page-title">
                        <i class="fas fa-tachometer-alt"></i>
                        Dashboard
                    </h1>
                    <p class="page-subtitle">Manage your products efficiently</p>
                </div>
                
                <!-- Quick Stats -->
                <div class="stats-section">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-box"></i>
                        </div>
                        <div class="stat-info">
                            <h3>${hasProducts ? productCount : 0}</h3>
                            <p>Products Found</p>
                        </div>
                    </div>
                    
                    <c:if test="${isAdmin}">
                        <div class="stat-card">
                            <div class="stat-icon admin">
                                <i class="fas fa-crown"></i>
                            </div>
                            <div class="stat-info">
                                <h3>Admin</h3>
                                <p>Full Access</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Main Content Area -->
            <div class="content-area">
                <!-- Search Section -->
                <div class="search-section">
                    <div class="search-header">
                        <h2>
                            <i class="fas fa-search"></i>
                            Product Search
                        </h2>
                        <p>Find products by name or keyword</p>
                    </div>
                    
                    <form action="ProductController" method="post" class="search-form">
                        <input type="hidden" name="action" value="searchProduct"/>
                        <div class="search-input-group">
                            <div class="search-icon">
                                <i class="fas fa-search"></i>
                            </div>
                            <input type="text" name="strKeyword" value="${fn:escapeXml(keywordParam)}" 
                                   class="search-input" placeholder="Enter product name or keyword..."
                                   autocomplete="off"/>
                            <button type="submit" class="search-btn">
                                <i class="fas fa-search"></i>
                                Search
                            </button>
                        </div>
                        
                        <c:if test="${hasKeyword}">
                            <div class="search-info">
                                <span class="search-keyword">
                                    Searching for: "<strong>${fn:escapeXml(keyword)}</strong>"
                                </span>
                                <a href="welcome.jsp" class="clear-search">
                                    <i class="fas fa-times"></i>
                                    Clear
                                </a>
                            </div>
                        </c:if>
                    </form>
                </div>

                <div class="action-section">
                    <div class="action-buttons">
                        <a href="ProductController?action=searchProduct&strKeyword=" class="btn btn-outline">
                            <i class="fas fa-list"></i>
                            View All Products
                        </a>
                        
                        <c:if test="${isAdmin}">
                            <a href="productForm.jsp" class="btn btn-primary">
                                <i class="fas fa-plus-circle"></i>
                                Add New Product
                            </a>
                        </c:if>
                    </div>
                </div>

                <div class="products-section">
                    <c:choose>
                        <c:when test="${hasProducts and productCount == 0}">
                            <div class="no-results">
                                <div class="no-results-icon">
                                    <i class="fas fa-search"></i>
                                </div>
                                <h3>No Products Found</h3>
                                <p>No products match the keyword "<strong>${fn:escapeXml(keyword)}</strong>"</p>
                                <div class="no-results-actions">
                                    <a href="welcome.jsp" class="btn btn-outline">
                                        <i class="fas fa-arrow-left"></i>
                                        Back to Dashboard
                                    </a>
                                    <c:if test="${isAdmin}">
                                        <a href="productForm.jsp" class="btn btn-primary">
                                            <i class="fas fa-plus"></i>
                                            Add New Product
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:when>
                        
                        <c:when test="${hasProducts and productCount > 0}">
                            <div class="products-header">
                                <h2>
                                    <i class="fas fa-box-open"></i>
                                    Products List
                                    <span class="product-count">(${productCount} items)</span>
                                </h2>
                            </div>
                            
                            <div class="table-container">
                                <div class="table-wrapper">
                                    <table class="products-table">
                                        <thead>
                                            <tr>
                                                <th><i class="fas fa-hashtag"></i> ID</th>
                                                <th><i class="fas fa-tag"></i> Name</th>
                                                <th><i class="fas fa-info-circle"></i> Description</th>
                                                <th><i class="fas fa-dollar-sign"></i> Price</th>
                                                <th><i class="fas fa-expand-arrows-alt"></i> Size</th>
                                                <th><i class="fas fa-toggle-on"></i> Status</th>
                                                <c:if test="${isAdmin}">
                                                    <th><i class="fas fa-cog"></i> Actions</th>
                                                </c:if>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${productList}" varStatus="status">
                                                <tr class="product-row ${status.index % 2 == 0 ? 'even' : 'odd'}">
                                                    <td class="product-id">${fn:escapeXml(product.id)}</td>
                                                    <td class="product-name">
                                                        <div class="name-cell">
                                                            <strong>${fn:escapeXml(product.name)}</strong>
                                                        </div>
                                                    </td>
                                                    <td class="product-description">
                                                        <div class="description-cell">
                                                            ${fn:escapeXml(product.description)}
                                                        </div>
                                                    </td>
                                                    <td class="product-price">
                                                        <span class="price-value">
                                                            <i class="fas fa-dong-sign"></i>
                                                            ${product.price}
                                                        </span>
                                                    </td>
                                                    <td class="product-size">
                                                        <span class="size-badge">${fn:escapeXml(product.size)}</span>
                                                    </td>
                                                    <td class="product-status">
                                                        <span class="status-badge ${product.status ? 'status-active' : 'status-inactive'}">
                                                            <i class="fas ${product.status ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                                            ${product.status ? 'Active' : 'Inactive'}
                                                        </span>
                                                    </td>
                                                    <c:if test="${isAdmin}">
                                                        <td class="product-actions">
                                                            <div class="action-buttons">
                                                                <!-- Edit Button -->
                                                                <form action="MainController" method="post" class="inline-form">
                                                                    <input type="hidden" name="action" value="editProduct"/>
                                                                    <input type="hidden" name="productId" value="${product.id}"/>
                                                                    <input type="hidden" name="strKeyword" value="${keywordParam}" />
                                                                    <button type="submit" class="btn btn-edit" title="Edit Product">
                                                                        <i class="fas fa-edit"></i>
                                                                    </button>
                                                                </form>

                                                                <!-- Delete Button -->
                                                                <form action="MainController" method="post" class="inline-form">
                                                                    <input type="hidden" name="action" value="changeProductStatus"/>
                                                                    <input type="hidden" name="productId" value="${product.id}"/>
                                                                    <input type="hidden" name="strKeyword" value="${keywordParam}" />
                                                                    <button type="submit" class="btn btn-delete" 
                                                                            title="Delete Product"
                                                                            onclick="return confirmDelete('${fn:escapeXml(product.name)}')">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </tbody>    
                                    </table>
                                </div>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="welcome-content">
                                <div class="welcome-card">
                                    <div class="welcome-icon">
                                        <i class="fas fa-box-open"></i>
                                    </div>
                                    <h2>Welcome to Product Management!</h2>
                                    <p>Start by searching for products or browse all available items.</p>
                                    
                                    <div class="welcome-actions">
                                        <a href="ProductController?action=searchProduct&strKeyword=" class="btn btn-primary">
                                            <i class="fas fa-list"></i>
                                            View All Products
                                        </a>
                                        <c:if test="${isAdmin}">
                                            <a href="productForm.jsp" class="btn btn-outline">
                                                <i class="fas fa-plus"></i>
                                                Add Product
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp">
            <jsp:param name="additionalJS" value="welcome.js" />
        </jsp:include>
    </c:otherwise>
</c:choose>