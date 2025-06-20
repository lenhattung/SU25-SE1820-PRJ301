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
    </head>
    <body>
        <%
            if(AuthUtils.isAdmin(request)){
                ProductDTO product = (ProductDTO) request.getAttribute("product");
                String checkError = (String) request.getAttribute("checkError");
                String message = (String) request.getAttribute("message");
        %>
        <h1>Product Form</h1>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="addProduct"/>
            <div>
                <label for="id">ID*</label> 
                <input type="text" name="id" id="id" required="required"
                       value="<%=product!=null?product.getId():""%>"
                       />
            </div>
            <div>
                <label for="name">Name*</label> 
                <input type="text" name="name" id="name" required="required"
                       value="<%=product!=null?product.getName():""%>"/>
            </div>
            <div>
                <label for="image">Image</label> 
                <input type="text" name="image" id="image"
                       value="<%=product!=null?product.getImage():""%>"
                       />
            </div>
            <div>
                <label for="description">Description</label> 
                <textarea type="text" name="description" id="description">
                    <%=product!=null?product.getDescription():""%>
                </textarea>
            </div>
            <div>
                <label for="price">Price*</label> 
                <input type="number" name="price" id="price" min="0" step="0.01" required="required"
                       value="<%=product!=null?product.getPrice():""%>"
                       />
            </div>
            <div>
                <label for="size">Size</label> 
                <input type="text" name="size" id="size"
                       value="<%=product!=null?product.getSize():""%>"
                       />
            </div>
            <div>
                <label for="status">Status (Active Product)</label> 
                <input type="checkbox" name="status" id="status" value="true"
                       <%=product!=null && product.isStatus()? " checked='checked' ":""%>
                       
                       />
            </div>
            <div>
                <input type="submit" value="Add Product"/>
                <input type="reset" value="Reset"/>
            </div>
        </form>
        <%=checkError!=null?checkError:""%><br/>
        <%=message!=null?message:""%>
        
        <%
    }else{
        %>
        <%=AuthUtils.getAccessDeniedMessage(" profuct-form page ")%>
        <%
    }
        %>
    </body>
</html>
