-- Sample data for International Media Academic Society
-- This file populates the database with initial data for testing and development

-- Insert default categories
INSERT INTO categories (name, description, display_order, is_active, created_at, updated_at) VALUES
('National', 'National news and events', 1, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Politics', 'Political news and analysis', 2, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Business', 'Business and economic news', 3, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Finance', 'Financial markets and investment news', 4, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Lifestyle', 'Lifestyle and culture articles', 5, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Sports', 'Sports news and events', 6, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('World', 'International news and events', 7, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Videos', 'Video content and multimedia', 8, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Entertainment & Arts', 'Entertainment and arts coverage', 9, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert sample students
INSERT INTO students (name, email, created_at, updated_at) VALUES
('John Smith', 'john.smith@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Emily Johnson', 'emily.johnson@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Michael Brown', 'michael.brown@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Sarah Davis', 'sarah.davis@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('David Wilson', 'david.wilson@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Lisa Anderson', 'lisa.anderson@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('James Taylor', 'james.taylor@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Jennifer Garcia', 'jennifer.garcia@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Robert Martinez', 'robert.martinez@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Amanda Lee', 'amanda.lee@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert sample articles
INSERT INTO articles (title, content, summary, author, featured_image, read_time, view_count, is_featured, is_published, category_id, created_at, updated_at) VALUES
('Government concerned about the low birthrate in the country', 
 '<p>South Korea faces a pressing demographic issue with its persistently low birthrate. Factors such as high living costs, competitive work culture, and societal pressures have led many couples to delay or forego starting families. Recognizing the implications for long-term economic stability, the government seeks to promote work-life balance, enhance childcare infrastructure, and shift societal attitudes toward parenthood. However, addressing this complex challenge demands a collaborative effort involving government, businesses, and communities to create an environment that supports family life and fosters sustainable population growth.</p>', 
 'South Korea faces a pressing demographic issue with its persistently low birthrate...', 
 'Yewon Kim', 
 'https://images.unsplash.com/photo-1491438590914-bc09fcaaf77a?w=800', 
 3, 156, true, true, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('Is Apple performing Monopoly?', 
 '<p>Founded in 1976, Apple Inc. is a leader in the consumer electronics industry, known for its iconic products such as the iPhone and Macintosh computers. Renowned for its elegant design and cutting-edge technology, Apple sets the standard for innovation. However, the company has recently been sued by the U.S Department of Justice.</p><p>The DoJ sued Apple for monopolizing the smartphone market, posing a significant challenge for the country''s launch of its brand-new product. The lawsuit alleges that Apple has unlawfully maintained its monopoly power on the grounds against the tech giant Apple. Finally, there is the exclusivity of AppStore. Apple introduced AppPlay as a security measure for users and did not allow third-party applications to access the chip that enables the iPhone to make mobile payments.</p>', 
 'Apple Inc. faces antitrust lawsuit from US Department of Justice over alleged smartphone market monopolization...', 
 'Yewon Kim', 
 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800', 
 5, 89, true, true, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('Bitcoin reached its peak', 
 '<p>Bitcoin has reached unprecedented heights in the financial markets, marking a significant milestone in cryptocurrency adoption. The digital currency has seen remarkable growth driven by institutional investment and growing acceptance as a legitimate asset class.</p>', 
 'Bitcoin reaches new all-time highs as institutional adoption accelerates...', 
 'Financial Team', 
 'https://images.unsplash.com/photo-1621761191319-c6fb62004040?w=800', 
 4, 234, false, true, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('Biden vs Trump rematch', 
 '<p>The 2024 presidential election presents a potential rematch between current President Joe Biden and former President Donald Trump. Political analysts examine the implications of this unprecedented scenario in American politics.</p>', 
 'Analysis of the potential Biden vs Trump rematch in the 2024 presidential election...', 
 'Political Desk', 
 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800', 
 6, 312, false, true, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('South Korea''s young doctors go on strike', 
 '<p>Young doctors in South Korea have initiated a nationwide strike to protest government healthcare policies. The strike has significant implications for the country''s healthcare system and patient care.</p>', 
 'South Korean medical residents strike over healthcare reform policies...', 
 'Health Reporter', 
 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=800', 
 4, 178, false, true, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('Korea regional elections', 
 '<p>South Korea prepares for important regional elections that will shape local governance and policy direction. Voters will choose leaders who will influence regional development and public services.</p>', 
 'Overview of upcoming regional elections in South Korea and key candidates...', 
 'Electoral Team', 
 'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=800', 
 5, 92, false, true, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('Spring Framework Best Practices', 
 '<p>Explore the best practices for developing Spring applications, including dependency injection, configuration management, and testing strategies. This comprehensive guide covers essential techniques for building robust and maintainable Spring applications.</p>', 
 'A comprehensive guide to Spring Framework best practices for developers...', 
 'Tech Team', 
 'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800', 
 7, 145, true, true, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('The Future of Web Development', 
 '<p>Web development continues to evolve with new technologies and frameworks. This article explores emerging trends, tools, and methodologies that are shaping the future of web development.</p>', 
 'Exploring emerging trends and technologies in modern web development...', 
 'Development Team', 
 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800', 
 6, 203, false, true, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('Student Life in the Digital Age', 
 '<p>How technology is transforming the student experience, from online learning platforms to digital collaboration tools. This article examines the impact of digital transformation on education.</p>', 
 'Examining how technology is reshaping the modern student experience...', 
 'Education Team', 
 'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=800', 
 5, 167, false, true, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

('Global Media Trends 2025', 
 '<p>An analysis of current and emerging trends in global media, including social media influence, digital journalism, and changing consumer preferences in media consumption.</p>', 
 'Analysis of global media trends and their impact on society in 2025...', 
 'Media Research Team', 
 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800', 
 8, 289, true, true, 7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);