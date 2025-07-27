<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.handong.internationalmedia.dto.StudentDto" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        String action = (String) request.getAttribute("action");
        String title = ("create".equals(action)) ? "Add New Student" : "Edit Student";
    %>
    <title><%=title%> - International Media Academic Society</title>
    
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
    <div class="d-flex align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary me-3">
            <i class="bi bi-arrow-left"></i> Back to Students
        </a>
        <div>
            <h1 class="h2 mb-0">
                <%
                    if ("create".equals(action)) {
                %>
                    <i class="bi bi-person-plus"></i> Add New Student
                <%
                    } else {
                %>
                    <i class="bi bi-person-gear"></i> Edit Student
                <%
                    }
                    
                    StudentDto student = (StudentDto) request.getAttribute("student");
                    if ("edit".equals(action) && student != null) {
                %>
                    <p class="text-muted mb-0">Student ID: <%=student.getId()%></p>
                <%
                    }
                %>
            </h1>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-person-vcard"></i> Student Information
                    </h5>
                </div>
                <div class="card-body">
                    <%
                        String formAction;
                        if ("create".equals(action)) {
                            formAction = request.getContextPath() + "/students";
                        } else {
                            formAction = request.getContextPath() + "/students/" + (student != null ? student.getId() : "");
                        }
                    %>
                    <form method="post" action="<%=formAction%>" novalidate>
                        
                        <!-- Name Field -->
                        <div class="mb-3">
                            <label for="name" class="form-label">
                                <i class="bi bi-person"></i> Full Name <span class="text-danger">*</span>
                            </label>
                            <%
                                String errorMessage = (String) request.getAttribute("errorMessage");
                                String nameValue = (student != null && student.getName() != null) ? student.getName() : "";
                                String nameClass = "form-control";
                                if (errorMessage != null && nameValue.isEmpty()) {
                                    nameClass += " is-invalid";
                                }
                            %>
                            <input type="text" 
                                   class="<%=nameClass%>" 
                                   id="name" 
                                   name="name" 
                                   value="<%=nameValue%>"
                                   placeholder="Enter student's full name"
                                   required>
                            <div class="form-text">
                                Enter the student's complete name as it appears in official records.
                            </div>
                        </div>

                        <!-- Email Field -->
                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="bi bi-envelope"></i> Email Address <span class="text-danger">*</span>
                            </label>
                            <%
                                String emailValue = (student != null && student.getEmail() != null) ? student.getEmail() : "";
                                String emailClass = "form-control";
                                if (errorMessage != null && emailValue.isEmpty()) {
                                    emailClass += " is-invalid";
                                }
                            %>
                            <input type="email" 
                                   class="<%=emailClass%>" 
                                   id="email" 
                                   name="email" 
                                   value="<%=emailValue%>"
                                   placeholder="student@example.com"
                                   required>
                            <div class="form-text">
                                This email will be used for all communications and must be unique.
                            </div>
                        </div>

                        <!-- Submit Buttons -->
                        <div class="d-flex justify-content-between pt-3">
                            <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">
                                <i class="bi bi-x-circle"></i> Cancel
                            </a>
                            
                            <div>
                                <% if ("edit".equals(action) && student != null) { %>
                                    <a href="${pageContext.request.contextPath}/students/<%=student.getId()%>" 
                                       class="btn btn-outline-primary me-2">
                                        <i class="bi bi-eye"></i> View
                                    </a>
                                <% } %>
                                <button type="submit" class="btn btn-primary">
                                    <% if ("create".equals(action)) { %>
                                        <i class="bi bi-plus-circle"></i> Create Student
                                    <% } else { %>
                                        <i class="bi bi-check-circle"></i> Update Student
                                    <% } %>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Additional Information Card (for edit mode) -->
            <% if ("edit".equals(action) && student != null && student.getCreatedAt() != null) { %>
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="bi bi-info-circle"></i> Additional Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <strong><i class="bi bi-calendar-plus"></i> Created:</strong>
                                <p class="text-muted mb-0">
                                    <%=student.getCreatedAt() != null ? student.getCreatedAt().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' HH:mm")) : "N/A"%>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <strong><i class="bi bi-calendar-check"></i> Last Updated:</strong>
                                <p class="text-muted mb-0">
                                    <%=student.getUpdatedAt() != null ? student.getUpdatedAt().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' HH:mm")) : "N/A"%>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>

            <!-- Delete Danger Zone (for edit mode) -->
            <% if ("edit".equals(action) && student != null) { %>
                <div class="card mt-4 border-danger">
                    <div class="card-header bg-danger text-white">
                        <h6 class="card-title mb-0">
                            <i class="bi bi-exclamation-triangle"></i> Danger Zone
                        </h6>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            Once you delete a student, there is no going back. This action cannot be undone.
                        </p>
                        <form method="post" 
                              action="${pageContext.request.contextPath}/students/<%=student.getId()%>/delete"
                              onsubmit="return confirm('Are you sure you want to delete this student? This action cannot be undone.');">
                            <button type="submit" class="btn btn-danger">
                                <i class="bi bi-trash"></i> Delete Student
                            </button>
                        </form>
                    </div>
                </div>
            <% } %>
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

<!-- Form Validation Script -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');
    const nameInput = document.getElementById('name');
    const emailInput = document.getElementById('email');
    
    // Real-time validation
    function validateField(field, validationFn, errorMessage) {
        field.addEventListener('blur', function() {
            if (!validationFn(field.value)) {
                field.classList.add('is-invalid');
                let feedback = field.parentNode.querySelector('.invalid-feedback');
                if (!feedback) {
                    feedback = document.createElement('div');
                    feedback.className = 'invalid-feedback';
                    field.parentNode.appendChild(feedback);
                }
                feedback.textContent = errorMessage;
            } else {
                field.classList.remove('is-invalid');
                const feedback = field.parentNode.querySelector('.invalid-feedback');
                if (feedback) {
                    feedback.remove();
                }
            }
        });
    }
    
    validateField(nameInput, 
        value => value.trim().length >= 2, 
        'Name must be at least 2 characters long'
    );
    
    validateField(emailInput, 
        value => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value), 
        'Please enter a valid email address'
    );
    
    // Form submission validation
    form.addEventListener('submit', function(e) {
        let isValid = true;
        
        if (nameInput.value.trim().length < 2) {
            nameInput.classList.add('is-invalid');
            isValid = false;
        }
        
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value)) {
            emailInput.classList.add('is-invalid');
            isValid = false;
        }
        
        if (!isValid) {
            e.preventDefault();
        }
    });
});
</script>
</body>
</html>