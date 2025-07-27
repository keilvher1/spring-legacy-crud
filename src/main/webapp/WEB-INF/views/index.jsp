<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>International Media Academic Society</title>
    
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/">
                            <i class="bi bi-house"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/articles">
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
                    <input class="form-control me-2" type="search" name="keyword" placeholder="Search articles...">
                    <button class="btn btn-outline-light" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="bg-primary text-white py-5 mb-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-4 fw-bold mb-3">
                        <i class="bi bi-globe2"></i> International Media Academic Society
                    </h1>
                    <p class="lead mb-4">
                        Empowering students through innovative media and technology education. 
                        Explore our latest articles, connect with fellow students, and stay updated 
                        with the world of international media.
                    </p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/articles" class="btn btn-light btn-lg">
                            <i class="bi bi-newspaper"></i> Browse Articles
                        </a>
                        <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-light btn-lg">
                            <i class="bi bi-people"></i> View Students
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="bi bi-mortarboard-fill display-1"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Statistics Section -->
        <div class="row mb-5">
            <div class="col-md-4">
                <div class="card bg-primary text-white text-center">
                    <div class="card-body">
                        <i class="bi bi-newspaper display-4 mb-2"></i>
                        <h3 class="card-title">${totalArticles}</h3>
                        <p class="card-text">Published Articles</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-info text-white text-center">
                    <div class="card-body">
                        <i class="bi bi-tags-fill display-4 mb-2"></i>
                        <h3 class="card-title">${totalCategories}</h3>
                        <p class="card-text">Categories</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-success text-white text-center">
                    <div class="card-body">
                        <i class="bi bi-star-fill display-4 mb-2"></i>
                        <h3 class="card-title">Welcome!</h3>
                        <p class="card-text">Get Started</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Links Section -->
        <section class="mb-5">
            <h2 class="h3 mb-4">Quick Access</h2>
            <div class="list-group">
                <a href="${pageContext.request.contextPath}/students" class="list-group-item list-group-item-action">
                    <i class="bi bi-people"></i> Student Management - View and manage student records
                </a>
                <a href="${pageContext.request.contextPath}/articles" class="list-group-item list-group-item-action">
                    <i class="bi bi-newspaper"></i> Articles - Browse all published articles
                </a>
                <a href="${pageContext.request.contextPath}/admin" class="list-group-item list-group-item-action">
                    <i class="bi bi-speedometer2"></i> Admin Dashboard - Access administrative functions
                </a>
            </div>
        </section>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 International Media Academic Society. All rights reserved.</p>
            <p class="mb-0">Built with Spring Legacy Framework</p>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>