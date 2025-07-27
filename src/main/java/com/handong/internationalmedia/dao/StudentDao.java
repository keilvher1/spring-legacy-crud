package com.handong.internationalmedia.dao;

import com.handong.internationalmedia.model.Student;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StudentDao {
    
    // Create
    int insertStudent(Student student);
    
    // Read
    Student selectStudentById(Long id);
    List<Student> selectAllStudents();
    List<Student> selectStudentsByName(@Param("name") String name);
    List<Student> selectStudentsByEmail(@Param("email") String email);
    List<Student> selectStudentsWithPaging(@Param("offset") int offset, @Param("limit") int limit);
    int countAllStudents();
    int countStudentsByName(@Param("name") String name);
    boolean existsByEmail(@Param("email") String email);
    boolean existsByEmailAndNotId(@Param("email") String email, @Param("id") Long id);
    
    // Update
    int updateStudent(Student student);
    int updateStudentName(@Param("id") Long id, @Param("name") String name);
    int updateStudentEmail(@Param("id") Long id, @Param("email") String email);
    
    // Delete
    int deleteStudentById(Long id);
    int deleteAllStudents();
    
    // Search
    List<Student> searchStudents(@Param("keyword") String keyword);
    List<Student> searchStudentsWithPaging(@Param("keyword") String keyword, 
                                          @Param("offset") int offset, 
                                          @Param("limit") int limit);
    int countSearchResults(@Param("keyword") String keyword);
}