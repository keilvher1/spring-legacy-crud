package com.handong.internationalmedia.controller;

import com.handong.internationalmedia.dto.ArticleDto;
import com.handong.internationalmedia.dto.StudentDto;
import com.handong.internationalmedia.model.Category;
import com.handong.internationalmedia.service.ArticleService;
import com.handong.internationalmedia.service.CategoryService;
import com.handong.internationalmedia.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private StudentService studentService;
    
    @Autowired
    private ArticleService articleService;
    
    @Autowired
    private CategoryService categoryService;

    // Admin Dashboard
    @GetMapping
    public String dashboard(Model model) {
        // Statistics
        model.addAttribute("totalStudents", studentService.getTotalStudentCount());
        model.addAttribute("totalArticles", articleService.getTotalArticleCount());
        model.addAttribute("publishedArticles", articleService.getPublishedArticleCount());
        model.addAttribute("totalCategories", categoryService.getTotalCategoryCount());
        
        // Recent data
        List<StudentDto> recentStudents = studentService.getStudentsWithPaging(0, 5);
        model.addAttribute("recentStudents", recentStudents);
        
        List<ArticleDto> recentArticles = articleService.getArticlesWithPaging(0, 5);
        model.addAttribute("recentArticles", recentArticles);
        
        return "admin/dashboard";
    }

    // Student Management
    @GetMapping("/students")
    public String manageStudents(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "15") int size,
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
        
        return "admin/students";
    }

    // Article Management
    @GetMapping("/articles")
    public String manageArticles(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "15") int size,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String status,
            Model model) {
        
        List<ArticleDto> articles;
        int totalCount;
        
        if (search != null && !search.trim().isEmpty()) {
            articles = articleService.searchArticlesWithPaging(search, page, size);
            totalCount = articleService.getSearchResultCount(search);
            model.addAttribute("search", search);
        } else if (categoryId != null) {
            articles = articleService.getArticlesByCategoryWithPaging(categoryId, page, size);
            totalCount = articleService.getArticleCountByCategory(categoryId);
            model.addAttribute("categoryId", categoryId);
        } else if ("published".equals(status)) {
            articles = articleService.getPublishedArticlesWithPaging(page, size);
            totalCount = articleService.getPublishedArticleCount();
            model.addAttribute("status", status);
        } else {
            articles = articleService.getArticlesWithPaging(page, size);
            totalCount = articleService.getTotalArticleCount();
        }
        
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        model.addAttribute("articles", articles);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", size);
        
        // Get categories for filter
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        
        return "admin/articles";
    }

    // Show article create/edit form
    @GetMapping("/articles/new")
    public String showArticleCreateForm(Model model) {
        model.addAttribute("article", new ArticleDto());
        model.addAttribute("action", "create");
        
        List<Category> categories = categoryService.getActiveCategories();
        model.addAttribute("categories", categories);
        
        return "admin/article-form";
    }

    @GetMapping("/articles/{id}/edit")
    public String showArticleEditForm(@PathVariable Long id, Model model) {
        ArticleDto article = articleService.getArticleById(id);
        if (article == null) {
            return "error/404";
        }
        
        model.addAttribute("article", article);
        model.addAttribute("action", "edit");
        
        List<Category> categories = categoryService.getActiveCategories();
        model.addAttribute("categories", categories);
        
        return "admin/article-form";
    }

    // Handle article form submission
    @PostMapping("/articles")
    public String createArticle(@ModelAttribute ArticleDto article, 
                               RedirectAttributes redirectAttributes) {
        try {
            ArticleDto createdArticle = articleService.createArticle(article);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Article created successfully: " + createdArticle.getTitle());
            return "redirect:/admin/articles/" + createdArticle.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            redirectAttributes.addFlashAttribute("article", article);
            return "redirect:/admin/articles/new";
        }
    }

    @PostMapping("/articles/{id}")
    public String updateArticle(@PathVariable Long id, 
                               @ModelAttribute ArticleDto article,
                               RedirectAttributes redirectAttributes) {
        try {
            article.setId(id);
            ArticleDto updatedArticle = articleService.updateArticle(id, article);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Article updated successfully: " + updatedArticle.getTitle());
            return "redirect:/admin/articles/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            redirectAttributes.addFlashAttribute("article", article);
            return "redirect:/admin/articles/" + id + "/edit";
        }
    }

    // Article detail view
    @GetMapping("/articles/{id}")
    public String showArticle(@PathVariable Long id, Model model) {
        ArticleDto article = articleService.getArticleWithCategory(id);
        if (article == null) {
            return "error/404";
        }
        
        model.addAttribute("article", article);
        return "admin/article-detail";
    }

    // Publish/Unpublish article
    @PostMapping("/articles/{id}/publish")
    public String publishArticle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            articleService.publishArticle(id);
            redirectAttributes.addFlashAttribute("successMessage", "Article published successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/articles/" + id;
    }

    @PostMapping("/articles/{id}/unpublish")
    public String unpublishArticle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            articleService.unpublishArticle(id);
            redirectAttributes.addFlashAttribute("successMessage", "Article unpublished successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/articles/" + id;
    }

    // Feature/Unfeature article
    @PostMapping("/articles/{id}/feature")
    public String featureArticle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            articleService.featureArticle(id);
            redirectAttributes.addFlashAttribute("successMessage", "Article featured successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/articles/" + id;
    }

    @PostMapping("/articles/{id}/unfeature")
    public String unfeatureArticle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            articleService.unfeatureArticle(id);
            redirectAttributes.addFlashAttribute("successMessage", "Article unfeatured successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/articles/" + id;
    }

    // Delete article
    @PostMapping("/articles/{id}/delete")
    public String deleteArticle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            ArticleDto article = articleService.getArticleById(id);
            if (article == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Article not found");
                return "redirect:/admin/articles";
            }
            
            boolean deleted = articleService.deleteArticle(id);
            if (deleted) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Article deleted successfully: " + article.getTitle());
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete article");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        
        return "redirect:/admin/articles";
    }

    // Category Management
    @GetMapping("/categories")
    public String manageCategories(Model model) {
        List<Category> categories = categoryService.getCategoriesWithArticleCount();
        model.addAttribute("categories", categories);
        model.addAttribute("newCategory", new Category());
        
        return "admin/categories";
    }

    @PostMapping("/categories")
    public String createCategory(@ModelAttribute Category category, 
                                RedirectAttributes redirectAttributes) {
        try {
            Category createdCategory = categoryService.createCategory(category);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Category created successfully: " + createdCategory.getName());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        
        return "redirect:/admin/categories";
    }

    @PostMapping("/categories/{id}/delete")
    public String deleteCategory(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Category category = categoryService.getCategoryById(id);
            if (category == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Category not found");
                return "redirect:/admin/categories";
            }
            
            boolean deleted = categoryService.deleteCategory(id);
            if (deleted) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Category deleted successfully: " + category.getName());
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete category");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        
        return "redirect:/admin/categories";
    }

    @PostMapping("/categories/{id}/toggle-status")
    public String toggleCategoryStatus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Category category = categoryService.getCategoryById(id);
            if (category == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Category not found");
                return "redirect:/admin/categories";
            }
            
            categoryService.updateCategoryStatus(id, !category.isActive());
            String status = !category.isActive() ? "activated" : "deactivated";
            redirectAttributes.addFlashAttribute("successMessage", 
                "Category " + status + " successfully: " + category.getName());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        
        return "redirect:/admin/categories";
    }
}