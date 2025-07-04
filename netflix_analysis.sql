
-- 1. Total number of shows:
SELECT COUNT(*) FROM netflix_data;

-- 2. Total Movies vs TV Shows:
SELECT type, COUNT(*) FROM netflix_data GROUP BY type;

-- 3. Top 10 countries with most Netflix content:
SELECT country, COUNT(*) AS total FROM netflix_data
WHERE country IS NOT NULL
GROUP BY country ORDER BY total DESC LIMIT 10;

-- 4. Top 10 directors with most content:
SELECT director, COUNT(*) AS total FROM netflix_data
WHERE director IS NOT NULL
GROUP BY director ORDER BY total DESC LIMIT 10;

-- 5. Content added each year:
SELECT release_year, COUNT(*) FROM netflix_data
GROUP BY release_year ORDER BY release_year;

-- 6. Top 10 genres/categories:
SELECT listed_in, COUNT(*) AS total FROM netflix_data
GROUP BY listed_in ORDER BY total DESC LIMIT 10;

-- 7. Number of shows containing ‘Drama’:
SELECT COUNT(*) FROM netflix_data
WHERE listed_in LIKE '%Drama%';

-- 8. Content by genre and type:
SELECT type, listed_in, COUNT(*) FROM netflix_data
GROUP BY type, listed_in ORDER BY COUNT(*) DESC;

-- 9. Most common genre per country:
SELECT country, listed_in, COUNT(*) AS total FROM netflix_data
WHERE country IS NOT NULL
GROUP BY country, listed_in
ORDER BY country, total DESC;

-- 10. Most common genres for TV Shows:
SELECT listed_in, COUNT(*) FROM netflix_data
WHERE type = 'TV Show'
GROUP BY listed_in ORDER BY COUNT(*) DESC;

-- 11. Distribution of ratings:
SELECT rating, COUNT(*) FROM netflix_data
GROUP BY rating ORDER BY COUNT(*) DESC;

-- 12. Content rated ‘TV-MA’:
SELECT title, type, rating FROM netflix_data
WHERE rating = 'TV-MA';

-- 13. Longest movie duration:
SELECT title, duration FROM netflix_data
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;

-- 14. TV Shows with most seasons:
SELECT title, duration FROM netflix_data
WHERE type = 'TV Show'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 5;

-- 15. Average duration of Movies:
SELECT AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS avg_duration
FROM netflix_data WHERE type = 'Movie';

-- 16. Most active years (by content added):
SELECT release_year, COUNT(*) FROM netflix_data
GROUP BY release_year ORDER BY COUNT(*) DESC LIMIT 10;

-- 17. First content ever added:
SELECT * FROM netflix_data
ORDER BY date_added ASC LIMIT 1;

-- 18. Most recent content added:
SELECT * FROM netflix_data
ORDER BY date_added DESC LIMIT 1;

-- 19. Content added in a specific year (e.g., 2020):
SELECT * FROM netflix_data
WHERE YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) = 2020;

-- 20. Monthly content addition trend:
SELECT MONTH(STR_TO_DATE(date_added, '%M %d, %Y')) AS month, COUNT(*) AS total
FROM netflix_data
WHERE date_added IS NOT NULL
GROUP BY month ORDER BY month;

-- 21. Shows with a specific actor (e.g., Robert De Niro):
SELECT title FROM netflix_data
WHERE cast LIKE '%Robert De Niro%';

-- 22. Shows by a specific director (e.g., Martin Scorsese):
SELECT title FROM netflix_data
WHERE director = 'Martin Scorsese';

-- 23. Count of shows with cast info missing:
SELECT COUNT(*) FROM netflix_data
WHERE cast IS NULL OR cast = '';

-- 24. Most frequently appearing actors (approximate using LIKE):
SELECT cast, COUNT(*) FROM netflix_data
WHERE cast IS NOT NULL
GROUP BY cast ORDER BY COUNT(*) DESC LIMIT 10;

-- 25. Top 5 genres in each year:
SELECT release_year, listed_in, COUNT(*) AS total
FROM netflix_data
GROUP BY release_year, listed_in
ORDER BY release_year, total DESC;

-- 26. Movies with no director listed:
SELECT title FROM netflix_data
WHERE type = 'Movie' AND (director IS NULL OR director = '');

-- 27. Most common rating for Movies vs TV Shows:
SELECT type, rating, COUNT(*) AS total
FROM netflix_data
GROUP BY type, rating
ORDER BY type, total DESC;

-- 28. TV shows with 1 season only:
SELECT title, duration FROM netflix_data
WHERE type = 'TV Show' AND duration LIKE '1 Season';

-- 29. Shows in India with rating 'TV-14':
SELECT title FROM netflix_data
WHERE country LIKE '%India%' AND rating = 'TV-14';

-- 30. Percentage of TV Shows vs Movies:
SELECT type, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_data), 2) AS percentage
FROM netflix_data
GROUP BY type;
