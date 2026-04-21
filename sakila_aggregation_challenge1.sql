-- 2.1.1: Total number of films
SELECT COUNT(*) AS total_films
FROM film;

-- 2.1.2: Number of films per rating
SELECT 
    rating,
    COUNT(*) AS num_films
FROM film
GROUP BY rating;

-- 2.1.3: Number of films per rating, sorted by count DESC
SELECT 
    rating,
    COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

-- 2.2.1: Mean film duration per rating, rounded to 2 decimals
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2.2: Ratings where mean duration > 2 hours (120 minutes)
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- BONUS: Last names in actor table that are NOT repeated
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;