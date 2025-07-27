package com.handong.internationalmedia.dao;

import com.handong.internationalmedia.model.Category;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CategoryDao {
    
    // Create
    int insertCategory(Category category);
    
    // Read
    Category selectCategoryById(Long id);
    Category selectCategoryByName(@Param("name") String name);
    List<Category> selectAllCategories();
    List<Category> selectActiveCategories();
    List<Category> selectCategoriesOrderByDisplayOrder();
    int countAllCategories();
    int countActiveCategories();
    boolean existsByName(@Param("name") String name);
    boolean existsByNameAndNotId(@Param("name") String name, @Param("id") Long id);
    
    // Update
    int updateCategory(Category category);
    int updateCategoryName(@Param("id") Long id, @Param("name") String name);
    int updateCategoryDescription(@Param("id") Long id, @Param("description") String description);
    int updateCategoryDisplayOrder(@Param("id") Long id, @Param("displayOrder") Integer displayOrder);
    int updateCategoryStatus(@Param("id") Long id, @Param("isActive") Boolean isActive);
    
    // Delete
    int deleteCategoryById(Long id);
    int deleteAllCategories();
    
    // Business methods
    int getMaxDisplayOrder();
    List<Category> selectCategoriesWithArticleCount();
}