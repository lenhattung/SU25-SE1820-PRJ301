<%-- 
    Document   : header.jsp
    Created on : Jul 01, 2025
    Author     : tungi
    Description: Header component chung cho toàn bộ ứng dụng
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${param.pageTitle != null ? param.pageTitle : 'Product Management System'}</title>
        
        <!-- CSS chung -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/menu.css" />
        <!-- CSS riêng cho từng trang -->
        <c:if test="${param.additionalCSS != null}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/${param.additionalCSS}" />
        </c:if>
        
        <!-- Font Awesome hoặc icon library -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <!-- Header navigation -->
        <header class="main-header">
            <div class="header-container">
                <div class="brand-section">
                    <h1 class="brand-title">
                        <i class="fas fa-shopping-cart"></i>
                        Product Management
                    </h1>
                </div>
                
                <!-- Navigation sẽ được include từ menu.jsp -->
                <jsp:include page="menu.jsp" />
                
                <!-- User panel sẽ được include từ userpanel.jsp -->
                <jsp:include page="userpanel.jsp" />
            </div>
        </header>
        
        <!-- Main content wrapper -->
        <main class="main-content">