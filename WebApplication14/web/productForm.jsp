<%-- 
    Document   : productForm
    Created on : Jun 6, 2025, 7:35:10 AM
    Author     : tungi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO"%>
<%@page import="model.ProductDTO"%>
<%@page import="utils.AuthUtils"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Form</title>
        <link rel="stylesheet" href="assets/css/product.css" />
    </head>
    <body>
        <%
            if(AuthUtils.isAdmin(request)){
                ProductDTO product = (ProductDTO) request.getAttribute("product");
                String checkError = (String) request.getAttribute("checkError");
                String message = (String) request.getAttribute("message");
                String keyword = (String) request.getAttribute("keyword");
                boolean isEdit = request.getAttribute("isEdit") != null;
        %>
        <div class="container">
            <h1><%=isEdit ? "Edit Product" : "Add New Product"%></h1>

            <% if(keyword != null && !keyword.isEmpty()) { %>
            <a href="ProductController?action=searchProduct&strKeyword=<%=keyword%>" class="back-link">
                ← Back to Product List
            </a>
            <% } else { %>
            <a href="welcome.jsp" class="back-link">
                ← Back to Dashboard
            </a>
            <% } %>

            <form action="MainController" method="post">
                <input type="hidden" name="action" value="<%=isEdit ? "updateProduct" : "addProduct"%>"/>

                <% if(keyword != null) { %>
                <input type="hidden" name="strKeyword" value="<%=keyword%>"/>
                <% } %>

                <div>
                    <label for="id">Product ID</label> 
                    <input type="text" name="id" id="id" required="required"
                           value="<%=product!=null?product.getId():""%>"
                           placeholder="Enter unique product ID"
                           <%=isEdit ? "readonly" : ""%>/>
                </div>
                <div>
                    <label for="name">Product Name</label> 
                    <input type="text" name="name" id="name" required="required"
                           value="<%=product!=null?product.getName():""%>"
                           placeholder="Enter product name"/>
                </div>
                <div>
                    <label for="image">Image URL</label> 
                    <input type="text" name="image" id="image"
                           value="<%=product!=null?product.getImage():""%>"
                           placeholder="Enter image URL or path"/>
                </div>
                <div>
                    <label for="description">Description</label> 
                    <textarea name="description" id="description" 
                              placeholder="Enter product description"><%=product!=null?product.getDescription():""%></textarea>
                </div>
                <div>
                    <label for="price">Price</label> 
                    <input type="number" name="price" id="price" min="0" step="0.01" required="required"
                           value="<%=product!=null?product.getPrice():""%>"
                           placeholder="0.00"/>
                </div>
                <div>
                    <label for="size">Size</label> 
                    <input type="text" name="size" id="size"
                           value="<%=product!=null?product.getSize():""%>"
                           placeholder="Enter size (S, M, L, XL, etc.)"/>
                </div>
                <div>
                    <label for="status">Product Status</label> 
                    <div class="checkbox-container">
                        <input type="checkbox" name="status" id="status" value="true"
                               <%=product!=null && product.isStatus()? " checked='checked' ":""%>/>
                        <label for="status">Active Product</label>
                    </div>
                </div>
                <div>
                    <input type="submit" value="<%=isEdit ? "Update Product" : "Add Product"%>"/>
                </div>
            </form>

            <% if(checkError != null || message != null) { %>
            <div class="message-container">
                <% if(checkError != null) { %>
                <div class="error-message"><%=checkError%></div>
                <% } %>
                <% if(message != null) { %>
                <div class="success-message"><%=message%></div>
                <% } %>
            </div>
            <% } %>
        </div>

        <%
        } else {
        %>
        <div class="access-denied">
            <%=AuthUtils.getAccessDeniedMessage(" product-form page ")%>
        </div>
        <%
        }
        %>
    </body>
</html>