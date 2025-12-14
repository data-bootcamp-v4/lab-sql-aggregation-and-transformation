USE sakila;

-- =========================
-- CHALLENGE 1
-- =========================

-- 1. Movie duration insights
-- 1.1 Shortest and longest movie durations
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes (no decimals)
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2. Rental date insights
-- 2.1 Number of days company has been operating
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Rental info with month and weekday (20 rows)
SELECT
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Add DAY_TYPE (weekend / workday)
SELECT
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration (handle NULLs)
SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. BONUS: Customer names and first 3 email characters
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- =========================
-- CHALLENGE 2
-- =========================

-- 1. Film counts
-- 1.1 Total number of films
SELECT
    COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films per rating
SELECT
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 1.3 Number of films per rating (descending order)
SELECT
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2. Film duration analysis
-- 2.1 Mean film duration per rating (rounded, descending)
SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours (120 minutes)
SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 3. BONUS: Actor last names that are not repeated
SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
