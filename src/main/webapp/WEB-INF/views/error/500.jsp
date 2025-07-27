<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Error - International Media Academic Society</title>
    
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
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 text-center">
                <div class="error-template">
                    <h1 class="display-1 text-danger">
                        <i class="bi bi-exclamation-circle"></i>
                    </h1>
                    <h1 class="display-4">500</h1>
                    <div class="error-details mb-4">
                        <h3>Internal Server Error</h3>
                        <p class="text-muted">Something went wrong on our end. We're working to fix this issue. Please try again later.</p>
                    </div>
                    <div class="error-actions">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg me-2">
                            <i class="bi bi-house"></i> Take Me Home
                        </a>
                        <a href="javascript:history.back()" class="btn btn-outline-secondary btn-lg">
                            <i class="bi bi-arrow-left"></i> Go Back
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5 position-absolute bottom-0 w-100">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 International Media Academic Society. All rights reserved.</p>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>