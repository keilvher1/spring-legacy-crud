<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.handong.internationalmedia.dto.StudentDto" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students - International Media Academic Society</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
                <i class="bi bi-globe2"></i> International Media
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="bi bi-house"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/articles">
                            <i class="bi bi-newspaper"></i> Articles
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/students">
                            <i class="bi bi-people"></i> Students
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

<div class="container mt-4">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="h2">
                <i class="bi bi-people-fill"></i> Students
            </h1>
            <p class="text-muted mb-0">Manage and view student information</p>
        </div>
        <a href="${pageContext.request.contextPath}/students/new" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> Add New Student
        </a>
    </div>

    <!-- Search and Filter -->
    <div class="card mb-4">
        <div class="card-body">
            <form method="get" action="${pageContext.request.contextPath}/students" class="row g-3">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" class="form-control" name="search" 
                               placeholder="Search by name or email..." 
                               value="<%=request.getParameter("search") != null ? request.getParameter("search") : ""%>">
                    </div>
                </div>
                <div class="col-md-2">
                    <select name="size" class="form-select">
                        <option value="10" <%="10".equals(request.getParameter("size")) ? "selected" : ""%>>10 per page</option>
                        <option value="25" <%="25".equals(request.getParameter("size")) ? "selected" : ""%>>25 per page</option>
                        <option value="50" <%="50".equals(request.getParameter("size")) ? "selected" : ""%>>50 per page</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-outline-primary w-100">
                        <i class="bi bi-search"></i> Search
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Results Info -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <%
                String search = request.getParameter("search");
                Integer totalCount = (Integer) request.getAttribute("totalCount");
                if (search != null && !search.trim().isEmpty()) {
            %>
                <span class="text-muted">
                    Found <%=totalCount != null ? totalCount : 0%> student(s) matching "<%=search%>"
                </span>
            <%
                } else {
            %>
                <span class="text-muted">
                    Showing <%=totalCount != null ? totalCount : 0%> student(s)
                </span>
            <%
                }
            %>
        </div>
        <% if (search != null && !search.trim().isEmpty()) { %>
            <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-x-circle"></i> Clear Search
            </a>
        <% } %>
    </div>

    <!-- Students Table -->
    <div class="card">
        <div class="card-body">
            <%
                @SuppressWarnings("unchecked")
                List<StudentDto> students = (List<StudentDto>) request.getAttribute("students");
                if (students != null && !students.isEmpty()) {
            %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Created</th>
                                <th scope="col">Updated</th>
                                <th scope="col" width="150">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (StudentDto student : students) {
                            %>
                                <tr>
                                    <td>
                                        <span class="badge bg-secondary"><%=student.getId()%></span>
                                    </td>
                                    <td>
                                        <strong><%=student.getName()%></strong>
                                    </td>
                                    <td>
                                        <a href="mailto:<%=student.getEmail()%>" class="text-decoration-none">
                                            <%=student.getEmail()%>
                                        </a>
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <%=student.getCreatedAt() != null ? student.getCreatedAt().format(DateTimeFormatter.ofPattern("MMM dd, yyyy")) : "N/A"%>
                                        </small>
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <%=student.getUpdatedAt() != null ? student.getUpdatedAt().format(DateTimeFormatter.ofPattern("MMM dd, yyyy")) : "N/A"%>
                                        </small>
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-sm" role="group">
                                            <a href="${pageContext.request.contextPath}/students/<%=student.getId()%>" 
                                               class="btn btn-outline-primary" title="View">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/students/<%=student.getId()%>/edit" 
                                               class="btn btn-outline-secondary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <form method="post" 
                                                  action="${pageContext.request.contextPath}/students/<%=student.getId()%>/delete" 
                                                  style="display: inline;"
                                                  onsubmit="return confirm('Are you sure you want to delete this student?');">
                                                <button type="submit" class="btn btn-outline-danger" title="Delete">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <%
                    Integer totalPages = (Integer) request.getAttribute("totalPages");
                    Integer currentPage = (Integer) request.getAttribute("currentPage");
                    if (totalPages != null && totalPages > 1) {
                %>
                    <nav aria-label="Students pagination" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <!-- Previous Page -->
                            <% if (currentPage > 0) { %>
                                <li class="page-item">
                                    <a class="page-link" 
                                       href="?page=<%=currentPage - 1%>&size=<%=request.getParameter("size") != null ? request.getParameter("size") : "10"%><%=search != null ? "&search=" + search : ""%>">
                                        <i class="bi bi-chevron-left"></i> Previous
                                    </a>
                                </li>
                            <% } %>

                            <!-- Page Numbers -->
                            <% 
                                int startPage = Math.max(0, currentPage - 2);
                                int endPage = Math.min(totalPages - 1, currentPage + 2);
                                for (int pageNum = startPage; pageNum <= endPage; pageNum++) { 
                            %>
                                <li class="page-item <%=pageNum == currentPage ? "active" : ""%>">
                                    <a class="page-link" 
                                       href="?page=<%=pageNum%>&size=<%=request.getParameter("size") != null ? request.getParameter("size") : "10"%><%=search != null ? "&search=" + search : ""%>">
                                        <%=pageNum + 1%>
                                    </a>
                                </li>
                            <% } %>

                            <!-- Next Page -->
                            <% if (currentPage < totalPages - 1) { %>
                                <li class="page-item">
                                    <a class="page-link" 
                                       href="?page=<%=currentPage + 1%>&size=<%=request.getParameter("size") != null ? request.getParameter("size") : "10"%><%=search != null ? "&search=" + search : ""%>">
                                        Next <i class="bi bi-chevron-right"></i>
                                    </a>
                                </li>
                            <% } %>
                        </ul>
                    </nav>
                <%
                    }
                %>
            <%
                } else {
            %>
                <div class="text-center py-5">
                    <i class="bi bi-people display-1 text-muted"></i>
                    <h3 class="mt-3 text-muted">No Students Found</h3>
                    <% if (search != null && !search.trim().isEmpty()) { %>
                        <p class="text-muted">
                            No students match your search criteria "<%=search%>".
                        </p>
                        <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left"></i> Back to All Students
                        </a>
                    <% } else { %>
                        <p class="text-muted">
                            Get started by adding your first student.
                        </p>
                        <a href="${pageContext.request.contextPath}/students/new" class="btn btn-primary">
                            <i class="bi bi-plus-circle"></i> Add First Student
                        </a>
                    <% } %>
                </div>
            <%
                }
            %>
        </div>
    </div>
</div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 International Media Academic Society. All rights reserved.</p>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>