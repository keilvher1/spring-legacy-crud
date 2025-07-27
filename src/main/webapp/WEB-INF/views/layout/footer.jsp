<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    </main>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="bi bi-globe2"></i> International Media Academic Society</h5>
                    <p class="mb-0">Empowering students through media and technology education.</p>
                </div>
                <div class="col-md-3">
                    <h6>Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/" class="text-light text-decoration-none">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/articles" class="text-light text-decoration-none">Articles</a></li>
                        <li><a href="${pageContext.request.contextPath}/students" class="text-light text-decoration-none">Students</a></li>
                        <li><a href="${pageContext.request.contextPath}/about" class="text-light text-decoration-none">About</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6>Admin</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/admin" class="text-light text-decoration-none">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/students" class="text-light text-decoration-none">Manage Students</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/articles" class="text-light text-decoration-none">Manage Articles</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/categories" class="text-light text-decoration-none">Categories</a></li>
                    </ul>
                </div>
            </div>
            <hr class="my-3">
            <div class="row">
                <div class="col-md-8">
                    <p class="mb-0">&copy; 2025 International Media Academic Society. All rights reserved.</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <p class="mb-0">Built with Spring Legacy & MyBatis</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    
    <!-- Page-specific scripts -->
    <c:if test="${not empty pageScripts}">
        ${pageScripts}
    </c:if>
</body>
</html>