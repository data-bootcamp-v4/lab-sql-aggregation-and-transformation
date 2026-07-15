-- ==========================================
-- Challenge 1
-- ==========================================

-- 1.1 Shortest and longest movie durations
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes
SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2.1 Number of days the company has been operating
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Rental information with month and weekday
SELECT
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS month,
    DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS - Rental information with DAY_TYPE
SELECT
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS month,
    DAYNAME(rental_date) AS weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3 Rental duration (replace NULL values)
SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS - Customer names and email prefix
SELECT
    CONCAT(first_name, ' ', last_name) AS customer_name,
    SUBSTRING(email,1,3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- ==========================================
-- Challenge 2
-- ==========================================

-- 1.1 Total number of films
SELECT
    COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films by rating
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Number of films by rating (descending)
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Mean film duration by rating
SELECT
    rating,
    ROUND(AVG(length),2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours
SELECT
    rating,
    ROUND(AVG(length),2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;

-- BONUS - Last names that are not repeated
SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;