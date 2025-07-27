package com.handong.internationalmedia.controller;

import com.handong.internationalmedia.dto.ArticleDto;
import com.handong.internationalmedia.model.Category;
import com.handong.internationalmedia.service.ArticleService;
import com.handong.internationalmedia.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private ArticleService articleService;
    
    @Autowired
    private CategoryService categoryService;

    @GetMapping("/")
    public String home(Model model) {
        // Get featured articles
        List<ArticleDto> featuredArticles = articleService.getFeaturedArticles();
        model.addAttribute("featuredArticles", featuredArticles);
        
        // Get recent articles
        List<ArticleDto> recentArticles = articleService.getRecentArticles(6);
        model.addAttribute("recentArticles", recentArticles);
        
        // Get popular articles
        List<ArticleDto> popularArticles = articleService.getPopularArticles(5);
        model.addAttribute("popularArticles", popularArticles);
        
        // Get active categories
        List<Category> categories = categoryService.getActiveCategories();
        model.addAttribute("categories", categories);
        
        // Statistics
        model.addAttribute("totalArticles", articleService.getPublishedArticleCount());
        model.addAttribute("totalCategories", categoryService.getActiveCategoryCount());
        
        return "index";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }

    @GetMapping("/articles")
    public String articles(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Long categoryId,
            Model model) {
        
        List<ArticleDto> articles;
        int totalCount;
        
        if (search != null && !search.trim().isEmpty()) {
            // Search articles
            articles = articleService.searchPublishedArticlesWithPaging(search, page, size);
            totalCount = articleService.getPublishedSearchResultCount(search);
            model.addAttribute("search", search);
        } else if (categoryId != null) {
            // Filter by category
            articles = articleService.getArticlesByCategoryWithPaging(categoryId, page, size);
            totalCount = articleService.getArticleCountByCategory(categoryId);
            
            Category category = categoryService.getCategoryById(categoryId);
            model.addAttribute("currentCategory", category);
            model.addAttribute("categoryId", categoryId);
        } else {
            // All published articles
            articles = articleService.getPublishedArticlesWithPaging(page, size);
            totalCount = articleService.getPublishedArticleCount();
        }
        
        // Calculate pagination
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        model.addAttribute("articles", articles);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", size);
        
        // Get categories for filter
        List<Category> categories = categoryService.getActiveCategories();
        model.addAttribute("categories", categories);
        
        return "articles/list";
    }

    @GetMapping("/articles/{id}")
    public String articleDetail(@PathVariable Long id, Model model) {
        ArticleDto article = articleService.getArticleWithCategory(id);
        if (article == null || !article.isPublished()) {
            return "error/404";
        }
        
        // Increment view count
        articleService.incrementViewCount(id);
        
        // Get updated article with incremented view count
        article = articleService.getArticleWithCategory(id);
        model.addAttribute("article", article);
        
        // Get related articles from same category
        if (article.getCategoryId() != null) {
            List<ArticleDto> relatedArticles = articleService.getArticlesByCategory(article.getCategoryId())
                    .stream()
                    .filter(a -> !a.getId().equals(id) && a.isPublished())
                    .limit(5)
                    .collect(java.util.stream.Collectors.toList());
            model.addAttribute("relatedArticles", relatedArticles);
        }
        
        return "articles/detail";
    }

    @GetMapping("/categories/{id}")
    public String categoryArticles(
            @PathVariable Long id,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {
        
        Category category = categoryService.getCategoryById(id);
        if (category == null || !category.isActive()) {
            return "error/404";
        }
        
        List<ArticleDto> articles = articleService.getArticlesByCategoryWithPaging(id, page, size);
        int totalCount = articleService.getArticleCountByCategory(id);
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        model.addAttribute("category", category);
        model.addAttribute("articles", articles);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", size);
        
        return "articles/category";
    }

    @GetMapping("/search")
    public String search(
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {
        
        if (keyword == null || keyword.trim().isEmpty()) {
            return "redirect:/articles";
        }
        
        List<ArticleDto> articles = articleService.searchPublishedArticlesWithPaging(keyword, page, size);
        int totalCount = articleService.getPublishedSearchResultCount(keyword);
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        model.addAttribute("keyword", keyword);
        model.addAttribute("articles", articles);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", size);
        
        return "articles/search";
    }
}