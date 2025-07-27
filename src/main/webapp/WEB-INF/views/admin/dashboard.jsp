<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - International Media Academic Society</title>
    
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/students">
                            <i class="bi bi-people"></i> Students
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-gear"></i> Admin
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/admin">
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
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h2">
                    <i class="bi bi-speedometer2"></i> Admin Dashboard
                </h1>
                <p class="text-muted mb-0">Manage your International Media Academic Society</p>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Total Students
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    ${totalStudents != null ? totalStudents : 0}
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="bi bi-people display-4 text-primary"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-success shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                    Published Articles
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    ${totalArticles != null ? totalArticles : 0}
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="bi bi-newspaper display-4 text-success"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-info shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                    Categories
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    ${totalCategories != null ? totalCategories : 0}
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="bi bi-tags display-4 text-info"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-warning shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                    Featured Articles
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    ${featuredArticles != null ? featuredArticles : 0}
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="bi bi-star display-4 text-warning"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4">
            <div class="col-lg-6 mb-4">
                <div class="card shadow">
                    <div class="card-header">
                        <h6 class="m-0 font-weight-bold text-primary">
                            <i class="bi bi-lightning"></i> Quick Actions
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <a href="${pageContext.request.contextPath}/students/new" class="btn btn-primary btn-block">
                                    <i class="bi bi-person-plus"></i> Add New Student
                                </a>
                            </div>
                            <div class="col-md-6 mb-3">
                                <a href="${pageContext.request.contextPath}/admin/articles/new" class="btn btn-success btn-block">
                                    <i class="bi bi-plus-circle"></i> Create Article
                                </a>
                            </div>
                            <div class="col-md-6 mb-3">
                                <a href="${pageContext.request.contextPath}/admin/categories/new" class="btn btn-info btn-block">
                                    <i class="bi bi-tag"></i> Add Category
                                </a>
                            </div>
                            <div class="col-md-6 mb-3">
                                <a href="${pageContext.request.contextPath}/admin/backup" class="btn btn-secondary btn-block">
                                    <i class="bi bi-download"></i> Backup Data
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 mb-4">
                <div class="card shadow">
                    <div class="card-header">
                        <h6 class="m-0 font-weight-bold text-primary">
                            <i class="bi bi-bar-chart"></i> System Status
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <span>Database Connection</span>
                                <span class="badge bg-success">Connected</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <span>Application Status</span>
                                <span class="badge bg-success">Running</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <span>Last Backup</span>
                                <span class="text-muted">Never</span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <span>Server Uptime</span>
                                <span class="text-success">Online</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Management Links -->
        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="card shadow h-100">
                    <div class="card-header">
                        <h6 class="m-0 font-weight-bold text-primary">
                            <i class="bi bi-people"></i> Student Management
                        </h6>
                    </div>
                    <div class="card-body">
                        <p class="card-text">Manage student registrations, profiles, and academic records.</p>
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/students" class="btn btn-primary">
                                <i class="bi bi-list"></i> View All Students
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-outline-primary">
                                <i class="bi bi-gear"></i> Advanced Management
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 mb-4">
                <div class="card shadow h-100">
                    <div class="card-header">
                        <h6 class="m-0 font-weight-bold text-success">
                            <i class="bi bi-newspaper"></i> Article Management
                        </h6>
                    </div>
                    <div class="card-body">
                        <p class="card-text">Create, edit, and publish articles for the academic society.</p>
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/articles" class="btn btn-success">
                                <i class="bi bi-list"></i> View All Articles
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/articles" class="btn btn-outline-success">
                                <i class="bi bi-gear"></i> Manage Articles
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 mb-4">
                <div class="card shadow h-100">
                    <div class="card-header">
                        <h6 class="m-0 font-weight-bold text-info">
                            <i class="bi bi-tags"></i> Category Management
                        </h6>
                    </div>
                    <div class="card-body">
                        <p class="card-text">Organize articles by creating and managing categories.</p>
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-info">
                                <i class="bi bi-list"></i> View Categories
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/categories/new" class="btn btn-outline-info">
                                <i class="bi bi-plus"></i> Add Category
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 International Media Academic Society. All rights reserved.</p>
            <p class="mb-0">Admin Dashboard</p>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .border-left-primary {
            border-left: 0.25rem solid #4e73df !important;
        }
        .border-left-success {
            border-left: 0.25rem solid #1cc88a !important;
        }
        .border-left-info {
            border-left: 0.25rem solid #36b9cc !important;
        }
        .border-left-warning {
            border-left: 0.25rem solid #f6c23e !important;
        }
        .text-xs {
            font-size: 0.7rem;
        }
        .btn-block {
            width: 100%;
        }
    </style>
</body>
</html>