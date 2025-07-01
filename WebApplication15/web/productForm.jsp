<%-- 
    Document   : productForm.jsp
    Created on : Jun 6, 2025, 7:35:10 AM
    Author     : tungi
    Updated    : Jul 01, 2025 - Sử dụng modular components
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO"%>
<%@page import="model.ProductDTO"%>
<%@page import="utils.AuthUtils"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
    // Kiểm tra quyền admin
    if(AuthUtils.isAdmin(request)){
        ProductDTO product = (ProductDTO) request.getAttribute("product");
        String checkError = (String) request.getAttribute("checkError");
        String message = (String) request.getAttribute("message");
        String keyword = (String) request.getAttribute("keyword");
        boolean isEdit = request.getAttribute("isEdit") != null;
        
        // Set attributes cho JSTL
        pageContext.setAttribute("product", product);
        pageContext.setAttribute("checkError", checkError);
        pageContext.setAttribute("message", message);
        pageContext.setAttribute("keyword", keyword);
        pageContext.setAttribute("isEdit", isEdit);
%>

<!-- Include Header -->
<%
    String pageTitle = isEdit ? "Edit Product" : "Add New Product";
%>

<!-- % @include file="header.jsp" %  -->
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="<%=pageTitle%>" />
    <jsp:param name="additionalCSS" value="product.css" />
</jsp:include>

<!-- Page Content -->
<div class="page-container">
    <!-- Breadcrumb Navigation -->
    <nav class="breadcrumb">
        <ol class="breadcrumb-list">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/welcome.jsp">
                    <i class="fas fa-home"></i>
                    Dashboard
                </a>
            </li>
            <c:if test="${not empty keyword}">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/ProductController?action=searchProduct&strKeyword=${fn:escapeXml(keyword)}">
                        Search Results
                    </a>
                </li>
            </c:if>
            <li class="breadcrumb-item active">
                <i class="fas ${isEdit ? 'fa-edit' : 'fa-plus'}"></i>
                ${isEdit ? "Edit Product" : "Add New Product"}
            </li>
        </ol>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="page-title-section">
            <h1 class="page-title">
                <i class="fas ${isEdit ? 'fa-edit' : 'fa-plus-circle'}"></i>
                ${isEdit ? "Edit Product" : "Add New Product"}
            </h1>
            <p class="page-subtitle">
                ${isEdit ? "Update product information" : "Create a new product in the system"}
            </p>
        </div>
        
        <!-- Back Navigation -->
        <div class="page-actions">
            <c:choose>
                <c:when test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/ProductController?action=searchProduct&strKeyword=${fn:escapeXml(keyword)}" 
                       class="btn btn-outline back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Back to Search Results
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/welcome.jsp" class="btn btn-outline back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Back to Dashboard
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Main Content -->
    <div class="content-area">
        <!-- Product Form -->
        <div class="form-container">
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/MainController" method="post" class="product-form">
                    <!-- Hidden fields -->
                    <input type="hidden" name="action" value="${isEdit ? 'updateProduct' : 'addProduct'}"/>
                    <c:if test="${not empty keyword}">
                        <input type="hidden" name="strKeyword" value="${fn:escapeXml(keyword)}"/>
                    </c:if>

                    <!-- Form Fields -->
                    <div class="form-section">
                        <h3 class="section-title">
                            <i class="fas fa-info-circle"></i>
                            Basic Information
                        </h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="id" class="form-label">
                                    <i class="fas fa-hashtag"></i>
                                    Product ID *
                                </label>
                                <input type="text" name="id" id="id" class="form-input" 
                                       value="${product != null ? fn:escapeXml(product.id) : ''}"
                                       placeholder="Enter unique product ID"
                                       ${isEdit ? 'readonly' : ''} required/>
                                <small class="form-help">
                                    ${isEdit ? 'Product ID cannot be changed' : 'Must be unique across all products'}
                                </small>
                            </div>
                            
                            <div class="form-group">
                                <label for="name" class="form-label">
                                    <i class="fas fa-tag"></i>
                                    Product Name *
                                </label>
                                <input type="text" name="name" id="name" class="form-input" 
                                       value="${product != null ? fn:escapeXml(product.name) : ''}"
                                       placeholder="Enter product name" required/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description" class="form-label">
                                <i class="fas fa-align-left"></i>
                                Description
                            </label>
                            <textarea name="description" id="description" class="form-textarea" 
                                      placeholder="Enter detailed product description">${product != null ? fn:escapeXml(product.description) : ''}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="image" class="form-label">
                                <i class="fas fa-image"></i>
                                Image URL
                            </label>
                            <input type="url" name="image" id="image" class="form-input" 
                                   value="${product != null ? fn:escapeXml(product.image) : ''}"
                                   placeholder="https://example.com/image.jpg"/>
                            <small class="form-help">Enter a valid URL for the product image</small>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">
                            <i class="fas fa-cog"></i>
                            Product Details
                        </h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="price" class="form-label">
                                    <i class="fas fa-dong-sign"></i>
                                    Price (VND) *
                                </label>
                                <input type="number" name="price" id="price" class="form-input" 
                                       min="0" step="0.01"
                                       value="${product != null ? product.price : ''}"
                                       placeholder="0.00" required/>
                            </div>
                            
                            <div class="form-group">
                                <label for="size" class="form-label">
                                    <i class="fas fa-expand-arrows-alt"></i>
                                    Size
                                </label>
                                <input type="text" name="size" id="size" class="form-input" 
                                       value="${product != null ? fn:escapeXml(product.size) : ''}"
                                       placeholder="S, M, L, XL, etc."/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-toggle-on"></i>
                                Product Status
                            </label>
                            <div class="checkbox-group">
                                <label class="checkbox-label">
                                    <input type="checkbox" name="status" id="status" value="true"
                                           ${product != null && product.status ? 'checked' : ''}/>
                                    <span class="checkbox-custom"></span>
                                    <span class="checkbox-text">
                                        <strong>Active Product</strong>
                                        <small>Make this product available for customers</small>
                                    </span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="button" onclick="resetForm()" class="btn btn-outline">
                            <i class="fas fa-undo"></i>
                            Reset
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas ${isEdit ? 'fa-save' : 'fa-plus'}"></i>
                            ${isEdit ? "Update Product" : "Add Product"}
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Messages Display -->
        <c:if test="${not empty checkError or not empty message}">
            <div class="messages-container">
                <c:if test="${not empty checkError}">
                    <div class="alert alert-error">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="alert-content">
                            <h4>Error</h4>
                            <p>${fn:escapeXml(checkError)}</p>
                        </div>
                        <button class="alert-close" onclick="this.parentElement.remove()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </c:if>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <div class="alert-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="alert-content">
                            <h4>Success</h4>
                            <p>${fn:escapeXml(message)}</p>
                        </div>
                        <button class="alert-close" onclick="this.parentElement.remove()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </c:if>
            </div>
        </c:if>
    </div>
</div>

<!-- Include Footer -->
<jsp:include page="footer.jsp">
    <jsp:param name="additionalJS" value="product-form.js" />
</jsp:include>

<script>
    // Form validation and interactions
    function resetForm() {
        if (confirm('Bạn có chắc chắn muốn reset form? Tất cả dữ liệu sẽ bị mất.')) {
            document.querySelector('.product-form').reset();
        }
    }
    
    // Auto-hide alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        });
        
        // Focus on first input
        const firstInput = document.querySelector('.form-input:not([readonly])');
        if (firstInput) firstInput.focus();
    });
    
    // Form validation
    document.querySelector('.product-form').addEventListener('submit', function(e) {
        const requiredFields = document.querySelectorAll('[required]');
        let isValid = true;
        
        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                field.classList.add('error');
                isValid = false;
            } else {
                field.classList.remove('error');
            }
        });
        
        if (!isValid) {
            e.preventDefault();
            alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
        }
    });
</script>

<%
    } else {
        // User không có quyền truy cập
%>
<!-- Include Header cho trang lỗi -->
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Access Denied" />
</jsp:include>

<div class="page-container">
    <div class="access-denied-container">
        <div class="access-denied-card">
            <div class="access-denied-icon">
                <i class="fas fa-lock"></i>
            </div>
            <h1>Access Denied</h1>
            <p><%=AuthUtils.getAccessDeniedMessage(" product-form page ")%></p>
            <div class="access-denied-actions">
                <a href="${pageContext.request.contextPath}/welcome.jsp" class="btn btn-primary">
                    <i class="fas fa-home"></i>
                    Go to Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/MainController?action=logout" class="btn btn-outline">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<%
    }
%>