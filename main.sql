CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);
CREATE TABLE news (
    id SERIAL PRIMARY KEY,
    category_id INT REFERENCES categories(id),
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_published BOOLEAN DEFAULT FALSE
);
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    news_id INT REFERENCES news(id),
    author_name VARCHAR(100),
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE news
ADD COLUMN views INTEGER DEFAULT 0;
ALTER TABLE comments
ALTER COLUMN author_name TYPE TEXT;
INSERT INTO categories (name, description)
VALUES
('Technology', 'Tech-related news'),
('Sports', 'Sports-related news'),
('Health', 'Health and wellness news');
INSERT INTO news (category_id, title, content, is_published)
VALUES
(1, 'New Tech Innovation', 'Details about the latest tech innovation.', TRUE),
(2, 'Big Sports Event', 'Highlights from the latest sports event.', TRUE),
(3, 'Health Tips', 'Tips for maintaining good health.', FALSE);
INSERT INTO comments (news_id, author_name, comment_text)
VALUES
(1, 'Alice', 'Very informative article!'),
(2, 'Bob', 'Amazing insights about the game.'),
(3, 'Charlie', 'Helpful health tips!');
UPDATE news
SET views = views + 1;
UPDATE news
SET is_published = TRUE
WHERE published_at < CURRENT_DATE - INTERVAL '1 day';
DELETE FROM comments
WHERE created_at < CURRENT_DATE - INTERVAL '1 year';
SELECT n.id AS news_id, n.title AS news_title, c.name AS category_name
FROM news n
JOIN categories c ON n.category_id = c.id;
SELECT * FROM news
WHERE category_id = (SELECT id FROM categories WHERE name = 'Technology');
SELECT * FROM news
WHERE is_published = TRUE
ORDER BY published_at DESC
LIMIT 5;
SELECT * FROM news
WHERE views BETWEEN 10 AND 100;
SELECT * FROM comments
WHERE author_name LIKE 'A%';
SELECT * FROM comments
WHERE author_name IS NULL;
SELECT c.name AS category_name, COUNT(n.id) AS news_count
FROM categories c
LEFT JOIN news n ON c.id = n.category_id
GROUP BY c.name;
ALTER TABLE news
ADD CONSTRAINT unique_title UNIQUE (title);