<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="${student.name} - Student Details" />
<c:set var="currentPage" value="students" />

<jsp:include page="../layout/header.jsp" />

<div class="container">
    <!-- Page Header -->
    <div class="d-flex align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary me-3">
            <i class="bi bi-arrow-left"></i> Back to Students
        </a>
        <div class="flex-grow-1">
            <h1 class="h2 mb-0">
                <i class="bi bi-person-circle"></i> ${student.name}
            </h1>
            <p class="text-muted mb-0">Student ID: ${student.id}</p>
        </div>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/students/${student.id}/edit" 
               class="btn btn-primary">
                <i class="bi bi-pencil"></i> Edit
            </a>
            <button type="button" class="btn btn-outline-danger" 
                    data-bs-toggle="modal" data-bs-target="#deleteModal">
                <i class="bi bi-trash"></i> Delete
            </button>
        </div>
    </div>

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
                                <p class="h5 mb-0">${student.name}</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label class="form-label text-muted">
                                    <i class="bi bi-envelope"></i> Email Address
                                </label>
                                <p class="h6 mb-0">
                                    <a href="mailto:${student.email}" class="text-decoration-none">
                                        ${student.email}
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
                                    <fmt:formatDate value="${student.createdAt}" pattern="MMMM dd, yyyy" />
                                    <br>
                                    <small class="text-muted">
                                        at <fmt:formatDate value="${student.createdAt}" pattern="HH:mm" />
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
                                    <fmt:formatDate value="${student.updatedAt}" pattern="MMMM dd, yyyy" />
                                    <br>
                                    <small class="text-muted">
                                        at <fmt:formatDate value="${student.updatedAt}" pattern="HH:mm" />
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
                        <a href="mailto:${student.email}" class="btn btn-outline-primary">
                            <i class="bi bi-envelope"></i> Send Email
                        </a>
                        <a href="${pageContext.request.contextPath}/students/${student.id}/edit" 
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
                            <c:set var="daysDiff" value="${(now.time - student.createdAt.time) / (1000 * 60 * 60 * 24)}" />
                            ${Math.round(daysDiff)}
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
                                    <fmt:formatDate value="${student.updatedAt}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                </p>
                            </div>
                        </div>
                        <div class="timeline-item">
                            <div class="timeline-marker bg-primary"></div>
                            <div class="timeline-content">
                                <h6 class="timeline-title">Student Registered</h6>
                                <p class="timeline-text text-muted small">
                                    <fmt:formatDate value="${student.createdAt}" pattern="MMM dd, yyyy 'at' HH:mm" />
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
                    <strong>${student.name}</strong> will be permanently removed from the system.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form method="post" action="${pageContext.request.contextPath}/students/${student.id}/delete" 
                      style="display: inline;">
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-trash"></i> Delete Student
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

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
    // Create a simple CSV export
    const studentData = {
        id: '${student.id}',
        name: '${student.name}',
        email: '${student.email}',
        createdAt: '<fmt:formatDate value="${student.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />',
        updatedAt: '<fmt:formatDate value="${student.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" />'
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
}
</script>

<jsp:include page="../layout/footer.jsp" />