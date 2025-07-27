<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.handong.internationalmedia.dto.ArticleDto" %>
<%@ page import="com.handong.internationalmedia.model.Category" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Articles - International Media Academic Society</title>
    
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/articles">
                            <i class="bi bi-newspaper"></i> Articles
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/students">
                            <i class="bi bi-people"></i> Students
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-gear"></i> Admin
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/students">
                                <i class="bi bi-people"></i> Manage Students
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/articles">
                                <i class="bi bi-newspaper"></i> Manage Articles
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="bi bi-tags"></i> Manage Categories
                            </a></li>
                        </ul>
                    </li>
                </ul>
                
                <!-- Search Form -->
                <form class="d-flex" method="get" action="${pageContext.request.contextPath}/search">
                    <input class="form-control me-2" type="search" name="keyword" placeholder="Search articles..." 
                           value="<%=request.getParameter("keyword") != null ? request.getParameter("keyword") : ""%>">
                    <button class="btn btn-outline-light" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h2">
                    <i class="bi bi-newspaper"></i> Articles
                </h1>
                <p class="text-muted mb-0">Browse and read published articles</p>
            </div>
        </div>

        <div class="row">
            <!-- Sidebar with Categories -->
            <div class="col-lg-3 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="bi bi-tags"></i> Categories</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/articles" 
                           class="list-group-item list-group-item-action <%=request.getParameter("categoryId") == null ? "active" : ""%>">
                            All Categories
                        </a>
                        <%
                            @SuppressWarnings("unchecked")
                            List<Category> categories = (List<Category>) request.getAttribute("categories");
                            if (categories != null) {
                                String categoryIdParam = request.getParameter("categoryId");
                                for (Category category : categories) {
                                    String activeClass = (categoryIdParam != null && categoryIdParam.equals(String.valueOf(category.getId()))) ? "active" : "";
                        %>
                                    <a href="${pageContext.request.contextPath}/articles?categoryId=<%=category.getId()%>" 
                                       class="list-group-item list-group-item-action <%=activeClass%>">
                                        <%=category.getName()%>
                                    </a>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>

            <!-- Articles List -->
            <div class="col-lg-9">
                <!-- Search Results Info -->
                <%
                    String search = request.getParameter("search");
                    if (search != null && !search.trim().isEmpty()) {
                %>
                    <div class="alert alert-info d-flex justify-content-between align-items-center">
                        <span>Found ${totalCount} articles matching "<%=search%>"</span>
                        <a href="${pageContext.request.contextPath}/articles" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-x-circle"></i> Clear Search
                        </a>
                    </div>
                <%
                    }
                    
                    Category currentCategory = (Category) request.getAttribute("currentCategory");
                    if (currentCategory != null) {
                %>
                    <div class="alert alert-info d-flex justify-content-between align-items-center">
                        <span>Showing articles in category: <strong><%=currentCategory.getName()%></strong></span>
                        <a href="${pageContext.request.contextPath}/articles" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-x-circle"></i> Show All
                        </a>
                    </div>
                <%
                    }
                %>

                <!-- Articles Grid -->
                <%
                    @SuppressWarnings("unchecked")
                    List<ArticleDto> articles = (List<ArticleDto>) request.getAttribute("articles");
                    if (articles != null && !articles.isEmpty()) {
                %>
                    <div class="row">
                        <%
                            for (ArticleDto article : articles) {
                        %>
                            <div class="col-md-6 mb-4">
                                <div class="card h-100 shadow-sm">
                                    <% if (article.getFeaturedImage() != null && !article.getFeaturedImage().isEmpty()) { %>
                                        <img src="<%=article.getFeaturedImage()%>" class="card-img-top" alt="<%=article.getTitle()%>" 
                                             style="height: 200px; object-fit: cover;">
                                    <% } %>
                                    <div class="card-body d-flex flex-column">
                                        <% if (article.isFeatured()) { %>
                                            <span class="badge bg-warning text-dark mb-2">
                                                <i class="bi bi-star-fill"></i> Featured
                                            </span>
                                        <% } %>
                                        <h5 class="card-title"><%=article.getTitle()%></h5>
                                        <% if (article.getSummary() != null && !article.getSummary().isEmpty()) { %>
                                            <p class="card-text text-muted"><%=article.getSummary()%></p>
                                        <% } %>
                                        <div class="mt-auto">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <small class="text-muted">
                                                    <i class="bi bi-person"></i> <%=article.getAuthor()%>
                                                </small>
                                                <small class="text-muted">
                                                    <i class="bi bi-calendar"></i> 
                                                    <%=article.getCreatedAt() != null ? article.getCreatedAt().format(DateTimeFormatter.ofPattern("MMM dd, yyyy")) : "N/A"%>
                                                </small>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <small class="text-muted">
                                                    <i class="bi bi-eye"></i> <%=article.getViewCount()%> views
                                                    <% if (article.getReadTime() != null && article.getReadTime() > 0) { %>
                                                        • <i class="bi bi-clock"></i> <%=article.getReadTime()%> min read
                                                    <% } %>
                                                </small>
                                                <a href="${pageContext.request.contextPath}/articles/<%=article.getId()%>" 
                                                   class="btn btn-sm btn-primary">
                                                    Read More <i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%
                            }
                        %>
                    </div>

                    <!-- Simple Pagination -->
                    <%
                        Integer totalPages = (Integer) request.getAttribute("totalPages");
                        Integer currentPage = (Integer) request.getAttribute("currentPage");
                        if (totalPages != null && totalPages > 1) {
                    %>
                        <nav aria-label="Articles pagination" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <% if (currentPage > 0) { %>
                                    <li class="page-item">
                                        <a class="page-link" href="?page=<%=currentPage - 1%>">
                                            <i class="bi bi-chevron-left"></i> Previous
                                        </a>
                                    </li>
                                <% } %>

                                <% for (int i = 0; i < totalPages; i++) { %>
                                    <li class="page-item <%=i == currentPage ? "active" : ""%>">
                                        <a class="page-link" href="?page=<%=i%>">
                                            <%=i + 1%>
                                        </a>
                                    </li>
                                <% } %>

                                <% if (currentPage < totalPages - 1) { %>
                                    <li class="page-item">
                                        <a class="page-link" href="?page=<%=currentPage + 1%>">
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
                        <i class="bi bi-newspaper display-1 text-muted"></i>
                        <h3 class="mt-3 text-muted">No Articles Found</h3>
                        <% if (search != null && !search.trim().isEmpty()) { %>
                            <p class="text-muted">No articles match your search criteria.</p>
                            <a href="${pageContext.request.contextPath}/articles" class="btn btn-outline-primary">
                                <i class="bi bi-arrow-left"></i> Back to All Articles
                            </a>
                        <% } else { %>
                            <p class="text-muted">No articles have been published yet.</p>
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