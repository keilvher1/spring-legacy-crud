package com.handong.internationalmedia.service;

import com.handong.internationalmedia.dao.CategoryDao;
import com.handong.internationalmedia.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class CategoryService {

    @Autowired
    private CategoryDao categoryDao;

    // Create
    public Category createCategory(Category category) {
        validateCategoryForCreate(category);
        
        // Set display order if not provided
        if (category.getDisplayOrder() == null) {
            int maxOrder = categoryDao.getMaxDisplayOrder();
            category.setDisplayOrder(maxOrder + 1);
        }
        
        // Set default values
        if (category.getIsActive() == null) {
            category.setIsActive(true);
        }
        
        category.setCreatedAt(LocalDateTime.now());
        category.setUpdatedAt(LocalDateTime.now());
        
        categoryDao.insertCategory(category);
        return category;
    }

    // Read
    @Transactional(readOnly = true)
    public Category getCategoryById(Long id) {
        return categoryDao.selectCategoryById(id);
    }

    @Transactional(readOnly = true)
    public Category getCategoryByName(String name) {
        return categoryDao.selectCategoryByName(name);
    }

    @Transactional(readOnly = true)
    public List<Category> getAllCategories() {
        return categoryDao.selectAllCategories();
    }

    @Transactional(readOnly = true)
    public List<Category> getActiveCategories() {
        return categoryDao.selectActiveCategories();
    }

    @Transactional(readOnly = true)
    public List<Category> getCategoriesOrderByDisplayOrder() {
        return categoryDao.selectCategoriesOrderByDisplayOrder();
    }

    @Transactional(readOnly = true)
    public List<Category> getCategoriesWithArticleCount() {
        return categoryDao.selectCategoriesWithArticleCount();
    }

    @Transactional(readOnly = true)
    public int getTotalCategoryCount() {
        return categoryDao.countAllCategories();
    }

    @Transactional(readOnly = true)
    public int getActiveCategoryCount() {
        return categoryDao.countActiveCategories();
    }

    // Update
    public Category updateCategory(Long id, Category categoryData) {
        Category existingCategory = categoryDao.selectCategoryById(id);
        if (existingCategory == null) {
            throw new RuntimeException("Category not found with id: " + id);
        }

        validateCategoryForUpdate(categoryData, id);

        existingCategory.setName(categoryData.getName());
        existingCategory.setDescription(categoryData.getDescription());
        existingCategory.setDisplayOrder(categoryData.getDisplayOrder());
        existingCategory.setIsActive(categoryData.getIsActive());
        existingCategory.setUpdatedAt(LocalDateTime.now());

        categoryDao.updateCategory(existingCategory);
        return existingCategory;
    }

    public void updateCategoryName(Long id, String name) {
        if (name == null || name.trim().isEmpty()) {
            throw new RuntimeException("Category name cannot be empty");
        }
        
        Category existingCategory = categoryDao.selectCategoryById(id);
        if (existingCategory == null) {
            throw new RuntimeException("Category not found with id: " + id);
        }
        
        if (categoryDao.existsByNameAndNotId(name.trim(), id)) {
            throw new RuntimeException("Category name already exists: " + name);
        }

        categoryDao.updateCategoryName(id, name.trim());
    }

    public void updateCategoryDescription(Long id, String description) {
        Category existingCategory = categoryDao.selectCategoryById(id);
        if (existingCategory == null) {
            throw new RuntimeException("Category not found with id: " + id);
        }

        categoryDao.updateCategoryDescription(id, description);
    }

    public void updateCategoryDisplayOrder(Long id, Integer displayOrder) {
        if (displayOrder == null || displayOrder < 0) {
            throw new RuntimeException("Display order must be a non-negative number");
        }
        
        Category existingCategory = categoryDao.selectCategoryById(id);
        if (existingCategory == null) {
            throw new RuntimeException("Category not found with id: " + id);
        }

        categoryDao.updateCategoryDisplayOrder(id, displayOrder);
    }

    public void updateCategoryStatus(Long id, Boolean isActive) {
        Category existingCategory = categoryDao.selectCategoryById(id);
        if (existingCategory == null) {
            throw new RuntimeException("Category not found with id: " + id);
        }

        categoryDao.updateCategoryStatus(id, isActive != null ? isActive : false);
    }

    public void activateCategory(Long id) {
        updateCategoryStatus(id, true);
    }

    public void deactivateCategory(Long id) {
        updateCategoryStatus(id, false);
    }

    // Delete
    public boolean deleteCategory(Long id) {
        Category existingCategory = categoryDao.selectCategoryById(id);
        if (existingCategory == null) {
            return false;
        }
        
        // TODO: Check if category has articles and handle appropriately
        // For now, we'll allow deletion (cascading should be handled at DB level)
        
        int deletedCount = categoryDao.deleteCategoryById(id);
        return deletedCount > 0;
    }

    public void deleteAllCategories() {
        categoryDao.deleteAllCategories();
    }

    // Business methods
    public void reorderCategories(List<Long> categoryIds) {
        if (categoryIds == null || categoryIds.isEmpty()) {
            return;
        }
        
        for (int i = 0; i < categoryIds.size(); i++) {
            Long categoryId = categoryIds.get(i);
            Category category = categoryDao.selectCategoryById(categoryId);
            if (category != null) {
                categoryDao.updateCategoryDisplayOrder(categoryId, i + 1);
            }
        }
    }

    public int getNextDisplayOrder() {
        return categoryDao.getMaxDisplayOrder() + 1;
    }

    // Validation methods
    private void validateCategoryForCreate(Category category) {
        if (category == null) {
            throw new RuntimeException("Category data cannot be null");
        }
        
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            throw new RuntimeException("Category name is required");
        }
        
        if (categoryDao.existsByName(category.getName().trim())) {
            throw new RuntimeException("Category name already exists: " + category.getName());
        }
        
        if (category.getDisplayOrder() != null && category.getDisplayOrder() < 0) {
            throw new RuntimeException("Display order must be a non-negative number");
        }
    }

    private void validateCategoryForUpdate(Category category, Long id) {
        if (category == null) {
            throw new RuntimeException("Category data cannot be null");
        }
        
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            throw new RuntimeException("Category name is required");
        }
        
        if (categoryDao.existsByNameAndNotId(category.getName().trim(), id)) {
            throw new RuntimeException("Category name already exists: " + category.getName());
        }
        
        if (category.getDisplayOrder() != null && category.getDisplayOrder() < 0) {
            throw new RuntimeException("Display order must be a non-negative number");
        }
    }
}