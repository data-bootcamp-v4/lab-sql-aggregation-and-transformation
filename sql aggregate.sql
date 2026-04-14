USE sakila;

-- =========================
-- Challenge 1
-- =========================

-- 1.1 Shortest and longest movie duration
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;


-- 1.2 Average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;


-- 2.1 Number of days company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;


-- 2.2 Rental info with month and weekday (limit 20)
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS month,
    DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;


-- 2.3 BONUS: Add day type (weekend/workday)
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS weekday,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;


-- 3. Film titles + rental duration (handle NULL)
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 4. BONUS: Customer names + email substring
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- =========================
-- Challenge 2
-- =========================

-- 1.1 Total number of films
SELECT COUNT(*) AS total_films FROM film;


-- 1.2 Number of films per rating
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating;


-- 1.3 Films per rating (sorted DESC)
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;


-- 2.1 Average duration per rating
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;


-- 2.2 Ratings with avg duration > 120 minutes
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;


-- 3. BONUS: Unique last names (not repeated)
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;