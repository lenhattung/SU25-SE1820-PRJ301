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
import model.UserDAO;
import model.UserDTO;

/**
 *
 * @author tungi
 */
@WebServlet(name = "MainController", urlPatterns = {"", "/", "/MainController"})
public class MainController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";

    private boolean isUserAction(String action) {
        return "login".equals(action)
                || "logout".equals(action)
                || "register".equals(action)
                || "updateProfile".equals(action)
                || "viewProfile".equals(action)
                || "changePassword".equals(action);
    }

    private boolean isProductAction(String action) {
        return "listProducts".equals(action)
                || "addProduct".equals(action)
                || "updateProduct".equals(action)
                || "editProduct".equals(action)
                || "deleteProduct".equals(action)
                || "searchProduct".equals(action)
                || "changeProductStatus".equals(action);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE; // url => location di den sau khi xu ly
        try {
            String action = request.getParameter("action");
            //---- Xu ly cac action cua User -----
            if (isUserAction(action)) {
                url = "/UserController";
            } else if (isProductAction(action)) {
                url = "/ProductController";
            }
        } catch (Exception e) {
        } finally {
            System.out.println(url);
            request.getRequestDispatcher(url).forward(request, response);
        }
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

}
