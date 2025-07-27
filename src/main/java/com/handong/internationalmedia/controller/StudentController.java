package com.handong.internationalmedia.controller;

import com.handong.internationalmedia.dto.StudentDto;
import com.handong.internationalmedia.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/students")
public class StudentController {

    @Autowired
    private StudentService studentService;

    // List all students
    @GetMapping
    public String listStudents(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String search,
            Model model) {
        
        List<StudentDto> students;
        int totalCount;
        
        if (search != null && !search.trim().isEmpty()) {
            students = studentService.searchStudentsWithPaging(search, page, size);
            totalCount = studentService.getSearchResultCount(search);
            model.addAttribute("search", search);
        } else {
            students = studentService.getStudentsWithPaging(page, size);
            totalCount = studentService.getTotalStudentCount();
        }
        
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        model.addAttribute("students", students);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", size);
        
        return "students/list";
    }

    // Show student details
    @GetMapping("/{id}")
    public String showStudent(@PathVariable Long id, Model model) {
        StudentDto student = studentService.getStudentById(id);
        if (student == null) {
            return "error/404";
        }
        
        model.addAttribute("student", student);
        return "students/detail";
    }

    // Show create form
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("student", new StudentDto());
        model.addAttribute("action", "create");
        return "students/form";
    }

    // Handle create form submission
    @PostMapping
    public String createStudent(@ModelAttribute StudentDto student, 
                               RedirectAttributes redirectAttributes) {
        try {
            StudentDto createdStudent = studentService.createStudent(student);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Student created successfully: " + createdStudent.getName());
            return "redirect:/students/" + createdStudent.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            redirectAttributes.addFlashAttribute("student", student);
            return "redirect:/students/new";
        }
    }

    // Show edit form
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        StudentDto student = studentService.getStudentById(id);
        if (student == null) {
            return "error/404";
        }
        
        model.addAttribute("student", student);
        model.addAttribute("action", "edit");
        return "students/form";
    }

    // Handle edit form submission
    @PostMapping("/{id}")
    public String updateStudent(@PathVariable Long id, 
                               @ModelAttribute StudentDto student,
                               RedirectAttributes redirectAttributes) {
        try {
            student.setId(id);
            StudentDto updatedStudent = studentService.updateStudent(id, student);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Student updated successfully: " + updatedStudent.getName());
            return "redirect:/students/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            redirectAttributes.addFlashAttribute("student", student);
            return "redirect:/students/" + id + "/edit";
        }
    }

    // Handle delete
    @PostMapping("/{id}/delete")
    public String deleteStudent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            StudentDto student = studentService.getStudentById(id);
            if (student == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Student not found");
                return "redirect:/students";
            }
            
            boolean deleted = studentService.deleteStudent(id);
            if (deleted) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Student deleted successfully: " + student.getName());
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete student");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        
        return "redirect:/students";
    }

    // Search students
    @GetMapping("/search")
    public String searchStudents(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {
        
        if (keyword == null || keyword.trim().isEmpty()) {
            return "redirect:/students";
        }
        
        List<StudentDto> students = studentService.searchStudentsWithPaging(keyword, page, size);
        int totalCount = studentService.getSearchResultCount(keyword);
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        model.addAttribute("students", students);
        model.addAttribute("search", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", size);
        
        return "students/list";
    }

    // Bulk delete (optional)
    @PostMapping("/bulk-delete")
    public String bulkDeleteStudents(@RequestParam("studentIds") List<Long> studentIds,
                                    RedirectAttributes redirectAttributes) {
        try {
            int deletedCount = 0;
            for (Long id : studentIds) {
                if (studentService.deleteStudent(id)) {
                    deletedCount++;
                }
            }
            
            redirectAttributes.addFlashAttribute("successMessage", 
                deletedCount + " student(s) deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        
        return "redirect:/students";
    }
}