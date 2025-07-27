package com.handong.internationalmedia.service;

import com.handong.internationalmedia.dao.ArticleDao;
import com.handong.internationalmedia.dao.CategoryDao;
import com.handong.internationalmedia.dto.ArticleDto;
import com.handong.internationalmedia.model.Article;
import com.handong.internationalmedia.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ArticleService {

    @Autowired
    private ArticleDao articleDao;
    
    @Autowired
    private CategoryDao categoryDao;

    // Create
    public ArticleDto createArticle(ArticleDto articleDto) {
        validateArticleForCreate(articleDto);
        
        Article article = convertToEntity(articleDto);
        
        // Set default values
        if (article.getViewCount() == null) {
            article.setViewCount(0L);
        }
        if (article.getIsFeatured() == null) {
            article.setIsFeatured(false);
        }
        if (article.getIsPublished() == null) {
            article.setIsPublished(false);
        }
        
        article.setCreatedAt(LocalDateTime.now());
        article.setUpdatedAt(LocalDateTime.now());
        
        articleDao.insertArticle(article);
        return convertToDto(article);
    }

    // Read
    @Transactional(readOnly = true)
    public ArticleDto getArticleById(Long id) {
        Article article = articleDao.selectArticleById(id);
        return article != null ? convertToDto(article) : null;
    }

    @Transactional(readOnly = true)
    public ArticleDto getArticleWithCategory(Long id) {
        Article article = articleDao.selectArticleWithCategory(id);
        return article != null ? convertToDto(article) : null;
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getAllArticles() {
        List<Article> articles = articleDao.selectAllArticles();
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getAllArticlesWithCategory() {
        List<Article> articles = articleDao.selectAllArticlesWithCategory();
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getPublishedArticles() {
        List<Article> articles = articleDao.selectPublishedArticles();
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getFeaturedArticles() {
        List<Article> articles = articleDao.selectFeaturedArticles();
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getArticlesByCategory(Long categoryId) {
        List<Article> articles = articleDao.selectArticlesByCategory(categoryId);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getArticlesByAuthor(String author) {
        List<Article> articles = articleDao.selectArticlesByAuthor(author);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getArticlesWithPaging(int page, int size) {
        int offset = page * size;
        List<Article> articles = articleDao.selectArticlesWithPaging(offset, size);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getPublishedArticlesWithPaging(int page, int size) {
        int offset = page * size;
        List<Article> articles = articleDao.selectPublishedArticlesWithPaging(offset, size);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getArticlesByCategoryWithPaging(Long categoryId, int page, int size) {
        int offset = page * size;
        List<Article> articles = articleDao.selectArticlesByCategoryWithPaging(categoryId, offset, size);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    // Count methods
    @Transactional(readOnly = true)
    public int getTotalArticleCount() {
        return articleDao.countAllArticles();
    }

    @Transactional(readOnly = true)
    public int getPublishedArticleCount() {
        return articleDao.countPublishedArticles();
    }

    @Transactional(readOnly = true)
    public int getFeaturedArticleCount() {
        return articleDao.countFeaturedArticles();
    }

    @Transactional(readOnly = true)
    public int getArticleCountByCategory(Long categoryId) {
        return articleDao.countArticlesByCategory(categoryId);
    }

    @Transactional(readOnly = true)
    public int getArticleCountByAuthor(String author) {
        return articleDao.countArticlesByAuthor(author);
    }

    // Search methods
    @Transactional(readOnly = true)
    public List<ArticleDto> searchArticles(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllArticles();
        }
        
        List<Article> articles = articleDao.searchArticles(keyword.trim());
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> searchPublishedArticles(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getPublishedArticles();
        }
        
        List<Article> articles = articleDao.searchPublishedArticles(keyword.trim());
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> searchArticlesWithPaging(String keyword, int page, int size) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getArticlesWithPaging(page, size);
        }
        
        int offset = page * size;
        List<Article> articles = articleDao.searchArticlesWithPaging(keyword.trim(), offset, size);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> searchPublishedArticlesWithPaging(String keyword, int page, int size) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getPublishedArticlesWithPaging(page, size);
        }
        
        int offset = page * size;
        List<Article> articles = articleDao.searchPublishedArticlesWithPaging(keyword.trim(), offset, size);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public int getSearchResultCount(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getTotalArticleCount();
        }
        return articleDao.countSearchResults(keyword.trim());
    }

    @Transactional(readOnly = true)
    public int getPublishedSearchResultCount(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getPublishedArticleCount();
        }
        return articleDao.countPublishedSearchResults(keyword.trim());
    }

    // Update
    public ArticleDto updateArticle(Long id, ArticleDto articleDto) {
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            throw new RuntimeException("Article not found with id: " + id);
        }

        validateArticleForUpdate(articleDto, id);

        existingArticle.setTitle(articleDto.getTitle());
        existingArticle.setContent(articleDto.getContent());
        existingArticle.setSummary(articleDto.getSummary());
        existingArticle.setAuthor(articleDto.getAuthor());
        existingArticle.setFeaturedImage(articleDto.getFeaturedImage());
        existingArticle.setReadTime(articleDto.getReadTime());
        existingArticle.setIsFeatured(articleDto.getIsFeatured());
        existingArticle.setIsPublished(articleDto.getIsPublished());
        existingArticle.setCategoryId(articleDto.getCategoryId());
        existingArticle.setUpdatedAt(LocalDateTime.now());

        articleDao.updateArticle(existingArticle);
        return convertToDto(existingArticle);
    }

    public void updateArticleTitle(Long id, String title) {
        if (title == null || title.trim().isEmpty()) {
            throw new RuntimeException("Article title cannot be empty");
        }
        
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            throw new RuntimeException("Article not found with id: " + id);
        }

        articleDao.updateArticleTitle(id, title.trim());
    }

    public void updateArticleContent(Long id, String content) {
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            throw new RuntimeException("Article not found with id: " + id);
        }

        articleDao.updateArticleContent(id, content);
    }

    public void updateArticleCategory(Long id, Long categoryId) {
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            throw new RuntimeException("Article not found with id: " + id);
        }
        
        if (categoryId != null) {
            Category category = categoryDao.selectCategoryById(categoryId);
            if (category == null) {
                throw new RuntimeException("Category not found with id: " + categoryId);
            }
        }

        articleDao.updateArticleCategory(id, categoryId);
    }

    public void publishArticle(Long id) {
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            throw new RuntimeException("Article not found with id: " + id);
        }

        articleDao.updateArticlePublishStatus(id, true);
    }

    public void unpublishArticle(Long id) {
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            throw new RuntimeException("Article not found with id: " + id);
        }

        articleDao.updateArticlePublishStatus(id, false);
    }

    public void featureArticle(Long id) {
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            throw new RuntimeException("Article not found with id: " + id);
        }

        articleDao.updateArticleFeaturedStatus(id, true);
    }

    public void unfeatureArticle(Long id) {
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            throw new RuntimeException("Article not found with id: " + id);
        }

        articleDao.updateArticleFeaturedStatus(id, false);
    }

    public void incrementViewCount(Long id) {
        articleDao.incrementViewCount(id);
    }

    // Delete
    public boolean deleteArticle(Long id) {
        Article existingArticle = articleDao.selectArticleById(id);
        if (existingArticle == null) {
            return false;
        }
        
        int deletedCount = articleDao.deleteArticleById(id);
        return deletedCount > 0;
    }

    public void deleteArticlesByCategory(Long categoryId) {
        articleDao.deleteArticlesByCategory(categoryId);
    }

    public void deleteAllArticles() {
        articleDao.deleteAllArticles();
    }

    // Business methods
    @Transactional(readOnly = true)
    public List<ArticleDto> getRecentArticles(int limit) {
        List<Article> articles = articleDao.selectRecentArticles(limit);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ArticleDto> getPopularArticles(int limit) {
        List<Article> articles = articleDao.selectPopularArticles(limit);
        return articles.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<String> getDistinctAuthors() {
        return articleDao.selectDistinctAuthors();
    }

    // Validation methods
    private void validateArticleForCreate(ArticleDto articleDto) {
        if (articleDto == null) {
            throw new RuntimeException("Article data cannot be null");
        }
        
        if (articleDto.getTitle() == null || articleDto.getTitle().trim().isEmpty()) {
            throw new RuntimeException("Article title is required");
        }
        
        if (articleDto.getContent() == null || articleDto.getContent().trim().isEmpty()) {
            throw new RuntimeException("Article content is required");
        }
        
        if (articleDto.getAuthor() == null || articleDto.getAuthor().trim().isEmpty()) {
            throw new RuntimeException("Article author is required");
        }
        
        if (articleDto.getCategoryId() != null) {
            Category category = categoryDao.selectCategoryById(articleDto.getCategoryId());
            if (category == null) {
                throw new RuntimeException("Category not found with id: " + articleDto.getCategoryId());
            }
        }
        
        if (articleDto.getReadTime() != null && articleDto.getReadTime() < 0) {
            throw new RuntimeException("Read time must be a non-negative number");
        }
    }

    private void validateArticleForUpdate(ArticleDto articleDto, Long id) {
        if (articleDto == null) {
            throw new RuntimeException("Article data cannot be null");
        }
        
        if (articleDto.getTitle() == null || articleDto.getTitle().trim().isEmpty()) {
            throw new RuntimeException("Article title is required");
        }
        
        if (articleDto.getContent() == null || articleDto.getContent().trim().isEmpty()) {
            throw new RuntimeException("Article content is required");
        }
        
        if (articleDto.getAuthor() == null || articleDto.getAuthor().trim().isEmpty()) {
            throw new RuntimeException("Article author is required");
        }
        
        if (articleDto.getCategoryId() != null) {
            Category category = categoryDao.selectCategoryById(articleDto.getCategoryId());
            if (category == null) {
                throw new RuntimeException("Category not found with id: " + articleDto.getCategoryId());
            }
        }
        
        if (articleDto.getReadTime() != null && articleDto.getReadTime() < 0) {
            throw new RuntimeException("Read time must be a non-negative number");
        }
    }

    // Conversion methods
    private ArticleDto convertToDto(Article article) {
        if (article == null) {
            return null;
        }
        
        ArticleDto dto = new ArticleDto();
        dto.setId(article.getId());
        dto.setTitle(article.getTitle());
        dto.setContent(article.getContent());
        dto.setSummary(article.getSummary());
        dto.setAuthor(article.getAuthor());
        dto.setFeaturedImage(article.getFeaturedImage());
        dto.setReadTime(article.getReadTime());
        dto.setViewCount(article.getViewCount());
        dto.setIsFeatured(article.getIsFeatured());
        dto.setIsPublished(article.getIsPublished());
        dto.setCategoryId(article.getCategoryId());
        dto.setCreatedAt(article.getCreatedAt());
        dto.setUpdatedAt(article.getUpdatedAt());
        
        // Set category name if category is loaded
        if (article.getCategory() != null) {
            dto.setCategoryName(article.getCategory().getName());
        }
        
        return dto;
    }

    private Article convertToEntity(ArticleDto articleDto) {
        if (articleDto == null) {
            return null;
        }
        
        Article article = new Article();
        article.setId(articleDto.getId());
        article.setTitle(articleDto.getTitle() != null ? articleDto.getTitle().trim() : null);
        article.setContent(articleDto.getContent() != null ? articleDto.getContent().trim() : null);
        article.setSummary(articleDto.getSummary() != null ? articleDto.getSummary().trim() : null);
        article.setAuthor(articleDto.getAuthor() != null ? articleDto.getAuthor().trim() : null);
        article.setFeaturedImage(articleDto.getFeaturedImage());
        article.setReadTime(articleDto.getReadTime());
        article.setViewCount(articleDto.getViewCount());
        article.setIsFeatured(articleDto.getIsFeatured());
        article.setIsPublished(articleDto.getIsPublished());
        article.setCategoryId(articleDto.getCategoryId());
        article.setCreatedAt(articleDto.getCreatedAt());
        article.setUpdatedAt(articleDto.getUpdatedAt());
        
        return article;
    }
}