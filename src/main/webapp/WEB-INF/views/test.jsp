<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Page</title>
</head>
<body>
    <h1>Spring Legacy CRUD Application</h1>
    <p>This is a test page to verify JSP is working correctly.</p>
    <ul>
        <li><a href="${pageContext.request.contextPath}/students">Students Management</a></li>
        <li><a href="${pageContext.request.contextPath}/articles">Articles</a></li>
        <li><a href="${pageContext.request.contextPath}/admin">Admin Panel</a></li>
    </ul>
</body>
</html>