<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.handong.internationalmedia.dto.StudentDto" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        StudentDto student = (StudentDto) request.getAttribute("student");
        String studentName = (student != null && student.getName() != null) ? student.getName() : "Student";
    %>
    <title><%=studentName%> - Student Details</title>
    
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
            </div>
        </div>
    </nav>

<div class="container mt-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary me-3">
            <i class="bi bi-arrow-left"></i> Back to Students
        </a>
        <div class="flex-grow-1">
            <h1 class="h2 mb-0">
                <i class="bi bi-person-circle"></i> <%=student != null ? student.getName() : "Unknown Student"%>
            </h1>
            <p class="text-muted mb-0">Student ID: <%=student != null ? student.getId() : "N/A"%></p>
        </div>
        <div class="btn-group">
            <% if (student != null) { %>
                <a href="${pageContext.request.contextPath}/students/<%=student.getId()%>/edit" 
                   class="btn btn-primary">
                    <i class="bi bi-pencil"></i> Edit
                </a>
                <button type="button" class="btn btn-outline-danger" 
                        data-bs-toggle="modal" data-bs-target="#deleteModal">
                    <i class="bi bi-trash"></i> Delete
                </button>
            <% } %>
        </div>
    </div>

    <% if (student != null) { %>
        <div class="row">
            <!-- Main Student Information -->
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-person-vcard"></i> Student Information
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label class="form-label text-muted">
                                        <i class="bi bi-person"></i> Full Name
                                    </label>
                                    <p class="h5 mb-0"><%=student.getName()%></p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-4">
                                    <label class="form-label text-muted">
                                        <i class="bi bi-envelope"></i> Email Address
                                    </label>
                                    <p class="h6 mb-0">
                                        <a href="mailto:<%=student.getEmail()%>" class="text-decoration-none">
                                            <%=student.getEmail()%>
                                        </a>
                                    </p>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label text-muted">
                                        <i class="bi bi-calendar-plus"></i> Registration Date
                                    </label>
                                    <p class="mb-0">
                                        <%=student.getCreatedAt() != null ? student.getCreatedAt().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy")) : "N/A"%>
                                        <br>
                                        <small class="text-muted">
                                            at <%=student.getCreatedAt() != null ? student.getCreatedAt().format(DateTimeFormatter.ofPattern("HH:mm")) : "N/A"%>
                                        </small>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label text-muted">
                                        <i class="bi bi-calendar-check"></i> Last Updated
                                    </label>
                                    <p class="mb-0">
                                        <%=student.getUpdatedAt() != null ? student.getUpdatedAt().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy")) : "N/A"%>
                                        <br>
                                        <small class="text-muted">
                                            at <%=student.getUpdatedAt() != null ? student.getUpdatedAt().format(DateTimeFormatter.ofPattern("HH:mm")) : "N/A"%>
                                        </small>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Actions Card -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="bi bi-gear"></i> Actions
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="d-flex flex-wrap gap-2">
                            <a href="mailto:<%=student.getEmail()%>" class="btn btn-outline-primary">
                                <i class="bi bi-envelope"></i> Send Email
                            </a>
                            <a href="${pageContext.request.contextPath}/students/<%=student.getId()%>/edit" 
                               class="btn btn-outline-secondary">
                                <i class="bi bi-pencil"></i> Edit Details
                            </a>
                            <button type="button" class="btn btn-outline-info" onclick="printStudent()">
                                <i class="bi bi-printer"></i> Print
                            </button>
                            <button type="button" class="btn btn-outline-success" onclick="exportStudent()">
                                <i class="bi bi-download"></i> Export
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Quick Stats -->
                <div class="card">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="bi bi-graph-up"></i> Quick Stats
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span>Days Registered:</span>
                            <span class="badge bg-primary">
                                <%
                                    if (student.getCreatedAt() != null) {
                                        long daysDiff = java.time.temporal.ChronoUnit.DAYS.between(student.getCreatedAt().toLocalDate(), java.time.LocalDate.now());
                                        out.print(daysDiff);
                                    } else {
                                        out.print("N/A");
                                    }
                                %>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span>Profile Status:</span>
                            <span class="badge bg-success">Active</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <span>Email Verified:</span>
                            <span class="badge bg-info">Yes</span>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="bi bi-clock-history"></i> Recent Activity
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="timeline">
                            <div class="timeline-item">
                                <div class="timeline-marker bg-success"></div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Profile Updated</h6>
                                    <p class="timeline-text text-muted small">
                                        <%=student.getUpdatedAt() != null ? student.getUpdatedAt().format(DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' HH:mm")) : "N/A"%>
                                    </p>
                                </div>
                            </div>
                            <div class="timeline-item">
                                <div class="timeline-marker bg-primary"></div>
                                <div class="timeline-content">
                                    <h6 class="timeline-title">Student Registered</h6>
                                    <p class="timeline-text text-muted small">
                                        <%=student.getCreatedAt() != null ? student.getCreatedAt().format(DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' HH:mm")) : "N/A"%>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navigation -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="bi bi-list-ul"></i> Quick Navigation
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <a href="${pageContext.request.contextPath}/students" 
                               class="list-group-item list-group-item-action">
                                <i class="bi bi-people"></i> All Students
                            </a>
                            <a href="${pageContext.request.contextPath}/students/new" 
                               class="list-group-item list-group-item-action">
                                <i class="bi bi-person-plus"></i> Add New Student
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/students" 
                               class="list-group-item list-group-item-action">
                                <i class="bi bi-gear"></i> Admin Panel
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-exclamation-triangle text-danger"></i> Confirm Deletion
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this student?</p>
                        <div class="alert alert-warning">
                            <strong>Warning:</strong> This action cannot be undone. The student record for 
                            <strong><%=student.getName()%></strong> will be permanently removed from the system.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form method="post" action="${pageContext.request.contextPath}/students/<%=student.getId()%>/delete" 
                              style="display: inline;">
                            <button type="submit" class="btn btn-danger">
                                <i class="bi bi-trash"></i> Delete Student
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    <% } else { %>
        <div class="alert alert-danger">
            <h4>Student Not Found</h4>
            <p>The requested student could not be found.</p>
            <a href="${pageContext.request.contextPath}/students" class="btn btn-primary">
                <i class="bi bi-arrow-left"></i> Back to Students
            </a>
        </div>
    <% } %>
</div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 International Media Academic Society. All rights reserved.</p>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom Styles -->
<style>
.timeline {
    position: relative;
    padding-left: 30px;
}

.timeline::before {
    content: '';
    position: absolute;
    left: 15px;
    top: 0;
    bottom: 0;
    width: 2px;
    background: #e9ecef;
}

.timeline-item {
    position: relative;
    margin-bottom: 20px;
}

.timeline-marker {
    position: absolute;
    left: -35px;
    top: 5px;
    width: 12px;
    height: 12px;
    border-radius: 50%;
    border: 2px solid #fff;
    box-shadow: 0 0 0 2px #e9ecef;
}

.timeline-title {
    font-size: 0.875rem;
    margin-bottom: 2px;
}

.timeline-text {
    margin-bottom: 0;
}
</style>

<!-- JavaScript Functions -->
<script>
function printStudent() {
    window.print();
}

function exportStudent() {
    <% if (student != null) { %>
        // Create a simple CSV export
        const studentData = {
            id: '<%=student.getId()%>',
            name: '<%=student.getName()%>',
            email: '<%=student.getEmail()%>',
            createdAt: '<%=student.getCreatedAt() != null ? student.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : ""%>',
            updatedAt: '<%=student.getUpdatedAt() != null ? student.getUpdatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : ""%>'
        };
        
        const csv = 'ID,Name,Email,Created,Updated\n' + 
                    studentData.id + ',"' + studentData.name + '","' + 
                    studentData.email + '",' + studentData.createdAt + ',' + 
                    studentData.updatedAt;
        
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'student-' + studentData.id + '-' + studentData.name.replace(/[^a-zA-Z0-9]/g, '-') + '.csv';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        window.URL.revokeObjectURL(url);
    <% } %>
}
</script>
</body>
</html>