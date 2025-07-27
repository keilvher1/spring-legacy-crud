package com.handong.internationalmedia.service;

import com.handong.internationalmedia.dao.StudentDao;
import com.handong.internationalmedia.dto.StudentDto;
import com.handong.internationalmedia.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class StudentService {

    @Autowired
    private StudentDao studentDao;

    // Create
    public StudentDto createStudent(StudentDto studentDto) {
        validateStudentForCreate(studentDto);
        
        Student student = convertToEntity(studentDto);
        student.setCreatedAt(LocalDateTime.now());
        student.setUpdatedAt(LocalDateTime.now());
        
        studentDao.insertStudent(student);
        return convertToDto(student);
    }

    // Read
    @Transactional(readOnly = true)
    public StudentDto getStudentById(Long id) {
        Student student = studentDao.selectStudentById(id);
        return student != null ? convertToDto(student) : null;
    }

    @Transactional(readOnly = true)
    public List<StudentDto> getAllStudents() {
        List<Student> students = studentDao.selectAllStudents();
        return students.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<StudentDto> getStudentsWithPaging(int page, int size) {
        int offset = page * size;
        List<Student> students = studentDao.selectStudentsWithPaging(offset, size);
        return students.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public int getTotalStudentCount() {
        return studentDao.countAllStudents();
    }

    @Transactional(readOnly = true)
    public List<StudentDto> searchStudents(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllStudents();
        }
        
        List<Student> students = studentDao.searchStudents(keyword.trim());
        return students.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<StudentDto> searchStudentsWithPaging(String keyword, int page, int size) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getStudentsWithPaging(page, size);
        }
        
        int offset = page * size;
        List<Student> students = studentDao.searchStudentsWithPaging(keyword.trim(), offset, size);
        return students.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public int getSearchResultCount(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getTotalStudentCount();
        }
        return studentDao.countSearchResults(keyword.trim());
    }

    // Update
    public StudentDto updateStudent(Long id, StudentDto studentDto) {
        Student existingStudent = studentDao.selectStudentById(id);
        if (existingStudent == null) {
            throw new RuntimeException("Student not found with id: " + id);
        }

        validateStudentForUpdate(studentDto, id);

        existingStudent.setName(studentDto.getName());
        existingStudent.setEmail(studentDto.getEmail());
        existingStudent.setUpdatedAt(LocalDateTime.now());

        studentDao.updateStudent(existingStudent);
        return convertToDto(existingStudent);
    }

    public void updateStudentName(Long id, String name) {
        if (name == null || name.trim().isEmpty()) {
            throw new RuntimeException("Student name cannot be empty");
        }
        
        Student existingStudent = studentDao.selectStudentById(id);
        if (existingStudent == null) {
            throw new RuntimeException("Student not found with id: " + id);
        }

        studentDao.updateStudentName(id, name.trim());
    }

    public void updateStudentEmail(Long id, String email) {
        if (email == null || email.trim().isEmpty()) {
            throw new RuntimeException("Student email cannot be empty");
        }
        
        if (!isValidEmail(email)) {
            throw new RuntimeException("Invalid email format");
        }
        
        if (studentDao.existsByEmailAndNotId(email.trim(), id)) {
            throw new RuntimeException("Email already exists: " + email);
        }

        Student existingStudent = studentDao.selectStudentById(id);
        if (existingStudent == null) {
            throw new RuntimeException("Student not found with id: " + id);
        }

        studentDao.updateStudentEmail(id, email.trim());
    }

    // Delete
    public boolean deleteStudent(Long id) {
        Student existingStudent = studentDao.selectStudentById(id);
        if (existingStudent == null) {
            return false;
        }
        
        int deletedCount = studentDao.deleteStudentById(id);
        return deletedCount > 0;
    }

    public void deleteAllStudents() {
        studentDao.deleteAllStudents();
    }

    // Validation methods
    private void validateStudentForCreate(StudentDto studentDto) {
        if (studentDto == null) {
            throw new RuntimeException("Student data cannot be null");
        }
        
        if (studentDto.getName() == null || studentDto.getName().trim().isEmpty()) {
            throw new RuntimeException("Student name is required");
        }
        
        if (studentDto.getEmail() == null || studentDto.getEmail().trim().isEmpty()) {
            throw new RuntimeException("Student email is required");
        }
        
        if (!isValidEmail(studentDto.getEmail())) {
            throw new RuntimeException("Invalid email format");
        }
        
        if (studentDao.existsByEmail(studentDto.getEmail().trim())) {
            throw new RuntimeException("Email already exists: " + studentDto.getEmail());
        }
    }

    private void validateStudentForUpdate(StudentDto studentDto, Long id) {
        if (studentDto == null) {
            throw new RuntimeException("Student data cannot be null");
        }
        
        if (studentDto.getName() == null || studentDto.getName().trim().isEmpty()) {
            throw new RuntimeException("Student name is required");
        }
        
        if (studentDto.getEmail() == null || studentDto.getEmail().trim().isEmpty()) {
            throw new RuntimeException("Student email is required");
        }
        
        if (!isValidEmail(studentDto.getEmail())) {
            throw new RuntimeException("Invalid email format");
        }
        
        if (studentDao.existsByEmailAndNotId(studentDto.getEmail().trim(), id)) {
            throw new RuntimeException("Email already exists: " + studentDto.getEmail());
        }
    }

    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return email.trim().matches(emailRegex);
    }

    // Conversion methods
    private StudentDto convertToDto(Student student) {
        if (student == null) {
            return null;
        }
        
        return new StudentDto(
            student.getId(),
            student.getName(),
            student.getEmail(),
            student.getCreatedAt(),
            student.getUpdatedAt()
        );
    }

    private Student convertToEntity(StudentDto studentDto) {
        if (studentDto == null) {
            return null;
        }
        
        Student student = new Student();
        student.setId(studentDto.getId());
        student.setName(studentDto.getName() != null ? studentDto.getName().trim() : null);
        student.setEmail(studentDto.getEmail() != null ? studentDto.getEmail().trim() : null);
        student.setCreatedAt(studentDto.getCreatedAt());
        student.setUpdatedAt(studentDto.getUpdatedAt());
        
        return student;
    }
}