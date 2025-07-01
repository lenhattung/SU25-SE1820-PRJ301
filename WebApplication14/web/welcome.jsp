<%-- 
    Document   : welcome.jsp
    Created on : May 23, 2025, 7:40:45 AM
    Author     : tungi
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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management</title>
        <link rel="stylesheet" href="assets/css/welcome.css" />
    </head>
    <body>
        <!-- Kiểm tra đăng nhập -->
        <c:choose>
            <c:when test="${not isLoggedIn}">
                <c:redirect url="MainController"/>
            </c:when>
            <c:otherwise>
                <div class="container">
                    <div class="header-section">
                        <h1>Welcome ${currentUser.fullName}!</h1>
                        <div>
                            <a href="MainController?action=logout" class="logout-btn">Logout</a>
                        </div>
                    </div>

                    <div class="search-section">
                        <label class="search-label">Search by name:</label>
                        <form action="ProductController" method="post" class="search-form">
                            <input type="hidden" name="action" value="searchProduct"/>
                            <input type="text" name="strKeyword" value="${keywordParam}" 
                                   class="search-input" placeholder="Enter product name..."/>
                            <input type="submit" value="Search" class="search-btn"/>
                        </form>
                    </div>

                    <!-- Hiển thị nút Add Product nếu là admin -->
                    <c:if test="${isAdmin}">
                        <a href="productForm.jsp" class="add-product-btn">Add New Product</a>
                    </c:if>

                    <!-- Xử lý danh sách sản phẩm -->
                    <c:choose>
                        <c:when test="${hasProducts and productCount == 0}">
                            <div class="no-results">
                                No products have names that match the keyword!
                            </div>
                        </c:when>
                        <c:when test="${hasProducts and productCount > 0}">
                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Price</th>
                                            <th>Size</th>
                                            <th>Status</th>
                                                <c:if test="${isAdmin}">
                                                <th>Action</th>
                                                </c:if>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>${product.description}</td>
                                                <td class="price">VND ${product.price}</td>
                                                <td>${product.size}</td>
                                                <td class="${product.status ? 'status-true' : 'status-false'}">
                                                    ${product.status ? 'Active' : 'Inactive'}
                                                </td>
                                                <c:if test="${isAdmin}">
                                                    <td>
                                                        <div class="action-buttons">
                                                            <form action="MainController" method="post">
                                                                <input type="hidden" name="action" value="editProduct"/>
                                                                <input type="hidden" name="productId" value="${product.id}"/>
                                                                <input type="hidden" name="strKeyword" value="${keywordParam}" />
                                                                <input type="submit" value="Edit" class="edit-btn" />
                                                            </form>

                                                            <form action="MainController" method="post" class="delete-form">
                                                                <input type="hidden" name="action" value="changeProductStatus"/>
                                                                <input type="hidden" name="productId" value="${product.id}"/>
                                                                <input type="hidden" name="strKeyword" value="${keywordParam}" />
                                                                <input type="submit" value="Delete" class="delete-btn"
                                                                       onclick="return confirm('Are you sure you want to delete this product?')"/>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </tbody>    
                                </table>
                            </div>
                        </c:when>
                    </c:choose>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>