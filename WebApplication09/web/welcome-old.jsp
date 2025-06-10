<%-- 
    Document   : welcome.jsp
    Created on : May 23, 2025, 7:40:45 AM
    Author     : tungi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO"%>
<%@page import="utils.AuthUtils"%>
<%@page import="java.util.List"%>
<%@page import="model.ProductDTO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            table {
                border-collapse: collapse;
            }

            table, th, td {
                border: 1px solid black;
            }

            th, td {
                padding: 8px;
            }
        </style>
    </head>
    <body>
        <%
           UserDTO user = AuthUtils.getCurrentUser(request);
            if(!AuthUtils.isLoggedIn(request)){
                response.sendRedirect("MainController");
            }else{
            
                String keyword = (String) request.getAttribute("keyword");
        %>
        <h1>Welcome <%=user.getFullName()%> !</h1>
        <a href="MainController?action=logout">Logout</a>
        <hr/>
        Search by name: 
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="searchProduct"/>
            <input type="text" name="strKeyword" value="<%=keyword!=null?keyword:""%>"/>
            <input type="submit" value="Search"/>
        </form>
        <%
            List<ProductDTO> list = (List<ProductDTO>)request.getAttribute("list");
            
            if(list!=null && list.isEmpty()){
        %>
        No products have names that match the keyword!
        <%
    }else if(list!=null && !list.isEmpty()){
        %>
        <br/>
        <table>
            <thead>
            <th>
                Id
            </th>
            <th>
                Name
            </th>
            <th>
                Description
            </th>
            <th>
                Price
            </th>
            <th>
                Size
            </th>
            <th>
                Status
            </th>
        </thead>
        <tbody>
            <%
                for(ProductDTO p: list){
            %>
            <tr>
                <td>
                    <%=p.getId()%>
                </td>
                <td>
                    <%=p.getName()%>
                </td>
                <td>
                    <%=p.getDescription()%>
                </td>
                <td>
                    <%=p.getPrice()%>
                </td>
                <td>
                    <%=p.getSize()%>
                </td>
                <td>
                    <%=p.isStatus()%>
                </td>
            </tr>
            <%
            }
            %>
        </tbody>    
    </table>
    <%
}
    %>

    <%
        }
    %>
</body>
</html>
