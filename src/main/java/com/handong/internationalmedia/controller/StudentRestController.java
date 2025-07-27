package com.handong.internationalmedia.controller;

import com.handong.internationalmedia.dto.StudentDto;
import com.handong.internationalmedia.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/students")
public class StudentRestController {

    @Autowired
    private StudentService studentService;

    // Get all students
    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllStudents(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String search) {
        
        try {
            List<StudentDto> students;
            int totalCount;
            
            if (search != null && !search.trim().isEmpty()) {
                students = studentService.searchStudentsWithPaging(search, page, size);
                totalCount = studentService.getSearchResultCount(search);
            } else {
                students = studentService.getStudentsWithPaging(page, size);
                totalCount = studentService.getTotalStudentCount();
            }
            
            Map<String, Object> response = new HashMap<>();
            response.put("students", students);
            response.put("currentPage", page);
            response.put("totalPages", (int) Math.ceil((double) totalCount / size));
            response.put("totalCount", totalCount);
            response.put("pageSize", size);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    // Get student by ID
    @GetMapping("/{id}")
    public ResponseEntity<StudentDto> getStudentById(@PathVariable Long id) {
        try {
            StudentDto student = studentService.getStudentById(id);
            if (student == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(student);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Create new student
    @PostMapping
    public ResponseEntity<StudentDto> createStudent(@RequestBody StudentDto student) {
        try {
            StudentDto createdStudent = studentService.createStudent(student);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdStudent);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }

    // Update student
    @PutMapping("/{id}")
    public ResponseEntity<StudentDto> updateStudent(@PathVariable Long id, 
                                                   @RequestBody StudentDto student) {
        try {
            StudentDto updatedStudent = studentService.updateStudent(id, student);
            return ResponseEntity.ok(updatedStudent);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }

    // Delete student
    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, String>> deleteStudent(@PathVariable Long id) {
        try {
            boolean deleted = studentService.deleteStudent(id);
            Map<String, String> response = new HashMap<>();
            
            if (deleted) {
                response.put("message", "Student deleted successfully");
                return ResponseEntity.ok(response);
            } else {
                response.put("error", "Student not found");
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    // Search students
    @GetMapping("/search")
    public ResponseEntity<Map<String, Object>> searchStudents(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        
        try {
            List<StudentDto> students = studentService.searchStudentsWithPaging(keyword, page, size);
            int totalCount = studentService.getSearchResultCount(keyword);
            
            Map<String, Object> response = new HashMap<>();
            response.put("students", students);
            response.put("keyword", keyword);
            response.put("currentPage", page);
            response.put("totalPages", (int) Math.ceil((double) totalCount / size));
            response.put("totalCount", totalCount);
            response.put("pageSize", size);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    // Update student name only
    @PatchMapping("/{id}/name")
    public ResponseEntity<Map<String, String>> updateStudentName(
            @PathVariable Long id, 
            @RequestBody Map<String, String> request) {
        try {
            String name = request.get("name");
            studentService.updateStudentName(id, name);
            
            Map<String, String> response = new HashMap<>();
            response.put("message", "Student name updated successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        }
    }

    // Update student email only
    @PatchMapping("/{id}/email")
    public ResponseEntity<Map<String, String>> updateStudentEmail(
            @PathVariable Long id, 
            @RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            studentService.updateStudentEmail(id, email);
            
            Map<String, String> response = new HashMap<>();
            response.put("message", "Student email updated successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        }
    }

    // Get statistics
    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getStudentStats() {
        try {
            Map<String, Object> stats = new HashMap<>();
            stats.put("totalStudents", studentService.getTotalStudentCount());
            
            return ResponseEntity.ok(stats);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
}