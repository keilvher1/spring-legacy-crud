-- Database schema for International Media Academic Society
-- H2 Database Compatible Version

-- Students table
CREATE TABLE IF NOT EXISTS students (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Articles table
CREATE TABLE IF NOT EXISTS articles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    summary VARCHAR(500),
    author VARCHAR(100),
    featured_image VARCHAR(500),
    read_time INT,
    view_count BIGINT DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    is_published BOOLEAN DEFAULT FALSE,
    category_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Create indexes separately (H2 compatible)
CREATE INDEX IF NOT EXISTS idx_student_name ON students(name);
CREATE INDEX IF NOT EXISTS idx_student_email ON students(email);
CREATE INDEX IF NOT EXISTS idx_student_created ON students(created_at);

CREATE INDEX IF NOT EXISTS idx_category_name ON categories(name);
CREATE INDEX IF NOT EXISTS idx_category_order ON categories(display_order);
CREATE INDEX IF NOT EXISTS idx_category_active ON categories(is_active);

CREATE INDEX IF NOT EXISTS idx_article_title ON articles(title);
CREATE INDEX IF NOT EXISTS idx_article_author ON articles(author);
CREATE INDEX IF NOT EXISTS idx_article_published ON articles(is_published);
CREATE INDEX IF NOT EXISTS idx_article_featured ON articles(is_featured);
CREATE INDEX IF NOT EXISTS idx_article_category ON articles(category_id);
CREATE INDEX IF NOT EXISTS idx_article_created ON articles(created_at);
CREATE INDEX IF NOT EXISTS idx_article_views ON articles(view_count);