package com.handong.internationalmedia.dao;

import com.handong.internationalmedia.model.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ArticleDao {
    
    // Create
    int insertArticle(Article article);
    
    // Read
    Article selectArticleById(Long id);
    Article selectArticleWithCategory(Long id);
    List<Article> selectAllArticles();
    List<Article> selectAllArticlesWithCategory();
    List<Article> selectPublishedArticles();
    List<Article> selectFeaturedArticles();
    List<Article> selectArticlesByCategory(@Param("categoryId") Long categoryId);
    List<Article> selectArticlesByAuthor(@Param("author") String author);
    List<Article> selectArticlesWithPaging(@Param("offset") int offset, @Param("limit") int limit);
    List<Article> selectPublishedArticlesWithPaging(@Param("offset") int offset, @Param("limit") int limit);
    List<Article> selectArticlesByCategoryWithPaging(@Param("categoryId") Long categoryId, 
                                                    @Param("offset") int offset, 
                                                    @Param("limit") int limit);
    
    // Count
    int countAllArticles();
    int countPublishedArticles();
    int countFeaturedArticles();
    int countArticlesByCategory(@Param("categoryId") Long categoryId);
    int countArticlesByAuthor(@Param("author") String author);
    
    // Update
    int updateArticle(Article article);
    int updateArticleTitle(@Param("id") Long id, @Param("title") String title);
    int updateArticleContent(@Param("id") Long id, @Param("content") String content);
    int updateArticleSummary(@Param("id") Long id, @Param("summary") String summary);
    int updateArticleCategory(@Param("id") Long id, @Param("categoryId") Long categoryId);
    int updateArticlePublishStatus(@Param("id") Long id, @Param("isPublished") Boolean isPublished);
    int updateArticleFeaturedStatus(@Param("id") Long id, @Param("isFeatured") Boolean isFeatured);
    int incrementViewCount(@Param("id") Long id);
    
    // Delete
    int deleteArticleById(Long id);
    int deleteArticlesByCategory(@Param("categoryId") Long categoryId);
    int deleteAllArticles();
    
    // Search
    List<Article> searchArticles(@Param("keyword") String keyword);
    List<Article> searchPublishedArticles(@Param("keyword") String keyword);
    List<Article> searchArticlesWithPaging(@Param("keyword") String keyword, 
                                          @Param("offset") int offset, 
                                          @Param("limit") int limit);
    List<Article> searchPublishedArticlesWithPaging(@Param("keyword") String keyword, 
                                                   @Param("offset") int offset, 
                                                   @Param("limit") int limit);
    int countSearchResults(@Param("keyword") String keyword);
    int countPublishedSearchResults(@Param("keyword") String keyword);
    
    // Business methods
    List<Article> selectRecentArticles(@Param("limit") int limit);
    List<Article> selectPopularArticles(@Param("limit") int limit);
    List<String> selectDistinctAuthors();
}