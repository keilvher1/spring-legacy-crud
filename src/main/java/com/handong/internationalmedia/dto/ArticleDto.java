package com.handong.internationalmedia.dto;

import java.time.LocalDateTime;

public class ArticleDto {
    private Long id;
    private String title;
    private String content;
    private String summary;
    private String author;
    private String featuredImage;
    private Integer readTime;
    private Long viewCount;
    private Boolean isFeatured;
    private Boolean isPublished;
    private Long categoryId;
    private String categoryName;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Default constructor
    public ArticleDto() {}

    // Constructor for creating new article
    public ArticleDto(String title, String content, String author, Long categoryId) {
        this.title = title;
        this.content = content;
        this.author = author;
        this.categoryId = categoryId;
        this.viewCount = 0L;
        this.isFeatured = false;
        this.isPublished = false;
    }

    // All args constructor
    public ArticleDto(Long id, String title, String content, String summary, String author,
                     String featuredImage, Integer readTime, Long viewCount, Boolean isFeatured,
                     Boolean isPublished, Long categoryId, String categoryName,
                     LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.summary = summary;
        this.author = author;
        this.featuredImage = featuredImage;
        this.readTime = readTime;
        this.viewCount = viewCount;
        this.isFeatured = isFeatured;
        this.isPublished = isPublished;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getFeaturedImage() {
        return featuredImage;
    }

    public void setFeaturedImage(String featuredImage) {
        this.featuredImage = featuredImage;
    }

    public Integer getReadTime() {
        return readTime;
    }

    public void setReadTime(Integer readTime) {
        this.readTime = readTime;
    }

    public Long getViewCount() {
        return viewCount;
    }

    public void setViewCount(Long viewCount) {
        this.viewCount = viewCount;
    }

    public Boolean getIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(Boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public Boolean getIsPublished() {
        return isPublished;
    }

    public void setIsPublished(Boolean isPublished) {
        this.isPublished = isPublished;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Helper methods
    public boolean isFeatured() {
        return isFeatured != null && isFeatured;
    }

    public boolean isPublished() {
        return isPublished != null && isPublished;
    }

    // toString method
    @Override
    public String toString() {
        return "ArticleDto{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", categoryName='" + categoryName + '\'' +
                ", viewCount=" + viewCount +
                ", isFeatured=" + isFeatured +
                ", isPublished=" + isPublished +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}