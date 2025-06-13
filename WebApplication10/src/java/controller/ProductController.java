/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ProductDAO;
import model.ProductDTO;
import utils.AuthUtils;

/**
 *
 * @author tungi
 */
@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    ProductDAO pdao = new ProductDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ""; // 
        try {
            String action = request.getParameter("action");
            //---- Xu ly cac action cua User -----
            if (action.equals("addProduct")) {
                url = handleProductAdding(request, response);
            } else if (action.equals("searchProduct")) {
                url = handleProductSearching(request, response);
            } else if (action.equals("changeProductStatus")) {
                url = handleProductStatusChanging(request, response);
            } else if (action.equals("editProduct")) {
                url = handleProductEditing(request, response);
            } else if (action.equals("updateProduct")) {
                url = handleProductUpdating(request, response);
            }

        } catch (Exception e) {
        } finally {
            System.out.println(url);
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private String handleProductAdding(HttpServletRequest request, HttpServletResponse response) {
        String checkError = "";
        String message = "";
        if (AuthUtils.isAdmin(request)) {

            // Lay thong tin
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String size = request.getParameter("size");
            String status = request.getParameter("status");

            double price_value = 0;
            try {
                price_value = Double.parseDouble(price);
            } catch (Exception e) {
            }

            boolean status_value = true;
            try {
                status_value = Boolean.parseBoolean(status);
            } catch (Exception e) {
            }

            // Kiem tra loi
            // Kiem tra san pham bi trung
            if (pdao.isProductExists(id)) {
                checkError = "This Product ID already exists. Can not add new product.";
            }
            if (price_value < 0) {
                checkError += "<br/>Price must be greater than zero!";
            }

            ProductDTO product = new ProductDTO(id, name, image, description, price_value, size, status_value);

            if (!pdao.create(product)) {
                checkError += "<br/> Can not add product!";
            };

            request.setAttribute("product", product);
        }
        if (checkError.isEmpty()) {
            message = "Add product successfully!";
        }
        request.setAttribute("checkError", checkError);
        request.setAttribute("message", message);
        return "productForm.jsp";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String handleProductSearching(HttpServletRequest request, HttpServletResponse response) {
        String keyword = request.getParameter("strKeyword");
        List<ProductDTO> list = pdao.getActiveProductsByName(keyword);
        request.setAttribute("list", list);
        request.setAttribute("keyword", keyword);
        return "welcome.jsp";
    }

    private String handleProductStatusChanging(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String productId = request.getParameter("productId");
            boolean check = pdao.updateProductStatus(productId, false);
        }
        return handleProductSearching(request, response);
    }

    private String handleProductEditing(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isAdmin(request)) {
            String productId = request.getParameter("productId");
            String keyword = request.getParameter("strKeyword");
            ProductDTO product = pdao.getProductByID(productId);
            if (product != null) {
                request.setAttribute("product", product);
                request.setAttribute("keyword", keyword);
                request.setAttribute("isEdit", true);
                return "productForm.jsp";
            } else {
                request.setAttribute("checkError", "Product not found!");
            }
        }
        return handleProductSearching(request, response);
    }

    private String handleProductUpdating(HttpServletRequest request, HttpServletResponse response) {
        String checkError = "";
        String message = "";
        String keyword = request.getParameter("strKeyword");

        if (AuthUtils.isAdmin(request)) {
            // Lấy thông tin từ form
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String size = request.getParameter("size");
            String status = request.getParameter("status");

            double price_value = 0;
            try {
                price_value = Double.parseDouble(price);
            } catch (Exception e) {
                checkError = "Invalid price format!";
            }

            boolean status_value = false;
            try {
                status_value = Boolean.parseBoolean(status);
            } catch (Exception e) {
            }

            // Kiểm tra lỗi
            if (price_value < 0) {
                checkError += "<br/>Price must be greater than zero!";
            }

            if (checkError.isEmpty()) {
                ProductDTO product = new ProductDTO(id, name, image, description, price_value, size, status_value);

                if (pdao.update(product)) {
                    message = "Update product successfully!";
                    // Quay về trang welcome với từ khóa tìm kiếm
                    return handleProductSearching(request, response);
                } else {
                    checkError = "Can not update product!";
                }
            }

            // Nếu có lỗi, hiển thị lại form với thông tin đã nhập
            ProductDTO product = new ProductDTO(id, name, image, description, price_value, size, status_value);
            request.setAttribute("product", product);
            request.setAttribute("isEdit", true);

        }
        request.setAttribute("checkError", checkError);
        request.setAttribute("message", message);
        request.setAttribute("keyword", keyword);
        return "productForm.jsp";
    }

}
