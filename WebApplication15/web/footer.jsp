<%-- 
    Document   : footer.jsp
    Created on : Jul 01, 2025
    Author     : tungi
    Description: Footer component chung cho toàn bộ ứng dụng
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

        </main> <!-- Đóng main-content từ header -->
        
        <!-- Footer -->
        <footer class="main-footer">
            <div class="footer-container">
                <div class="footer-content">
                    <div class="footer-section">
                        <h3>Product Management System</h3>
                        <p>Quản lý sản phẩm hiệu quả và chuyên nghiệp</p>
                    </div>
                    
                    <div class="footer-section">
                        <h4>Quick Links</h4>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/welcome.jsp">Dashboard</a></li>
                            <c:if test="${sessionScope.user.roleID eq 'AD'}">
                                <li><a href="${pageContext.request.contextPath}/productForm.jsp">Add Product</a></li>
                            </c:if>
                        </ul>
                    </div>
                    
                    <div class="footer-section">
                        <h4>Support</h4>
                        <ul>
                            <li><a href="#" onclick="showHelp()">Help Center</a></li>
                            <li><a href="#" onclick="showContact()">Contact Us</a></li>
                        </ul>
                    </div>
                </div>
                
                <div class="footer-bottom">
                    <p>&copy; 2025 Product Management System. All rights reserved.</p>
                    <p>Developed by <strong>tungi</strong></p>
                </div>
            </div>
        </footer>

        <!-- JavaScript chung -->
        <script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
        
        <!-- JavaScript riêng cho từng trang -->
        <c:if test="${param.additionalJS != null}">
            <script src="${pageContext.request.contextPath}/assets/js/${param.additionalJS}"></script>
        </c:if>
        
        <!-- Inline JavaScript functions -->
        <script>
            function showHelp() {
                alert('Help Center - Liên hệ admin để được hỗ trợ!');
            }
            
            function showContact() {
                alert('Contact: admin@productmanagement.com');
            }
            
            // Confirmation dialogs
            function confirmDelete(productName) {
                return confirm('Bạn có chắc chắn muốn xóa sản phẩm "' + productName + '"?');
            }
            
            function confirmAction(message) {
                return confirm(message);
            }
        </script>
    </body>
</html>