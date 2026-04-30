USE sakila;

-- =========================================================
-- CHALLENGE 1
-- =========================================================

-- 1.1 Shortest and longest movie durations
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes without decimals
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(MOD(AVG(length), 60)) AS avg_minutes
FROM film;

-- 2.1 Number of days the company has been operating
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Rental information with month and weekday (20 rows)
SELECT
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    staff_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: rental information with DAY_TYPE
SELECT
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    staff_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration, replacing NULLs with 'Not Available'
SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bonus: customer full name + first 3 characters of email
SELECT
    CONCAT(first_name, ' ', last_name) AS customer_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;

-- =========================================================
-- CHALLENGE 2
-- =========================================================

-- 1.1 Total number of films released
SELECT
    COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films for each rating
SELECT
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating sorted descending
SELECT
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- 2.1 Mean film duration for each rating, rounded to 2 decimals
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration over two hours
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- 3. Bonus: last names not repeated in actor
SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;