-- =========================================================================
-- Sakila Data Aggregation & Transformation Lab Solution // E_Fuzes / Gebra
-- =========================================================================

USE sakila;

-- =====================================================
-- CHALLENGE 1
-- =====================================================

-- -----------------------------------------------------
-- 1. Movie duration insights
-- -----------------------------------------------------

-- 1.1 Shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;

-- 1.2 Average movie duration expressed in hours and minutes (no decimals)
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;


-- -----------------------------------------------------
-- 2. Insights related to rental dates
-- -----------------------------------------------------

-- 2.1 Calculate the number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days 
FROM rental;

-- 2.2 Retrieve rental info with rental month and weekday (20 rows)
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Add DAY_TYPE ('weekend' or 'workday')
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


-- -----------------------------------------------------
-- 3. Film titles and rental duration (Replace NULL with 'Not Available')
-- -----------------------------------------------------
SELECT 
    title, 
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- -----------------------------------------------------
-- 4. BONUS: Personalized customer info for marketing campaign
-- -----------------------------------------------------
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- =====================================================
-- CHALLENGE 2
-- =====================================================

-- -----------------------------------------------------
-- 1. Film analysis by ratings
-- -----------------------------------------------------

-- 1.1 Total number of films released
SELECT COUNT(film_id) AS total_released_films 
FROM film;

-- 1.2 Number of films for each rating
SELECT 
    rating, 
    COUNT(film_id) AS film_count
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating (sorted in descending order)
SELECT 
    rating, 
    COUNT(film_id) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;


-- -----------------------------------------------------
-- 2. Mean film duration insights
-- -----------------------------------------------------

-- 2.1 Mean film duration for each rating (sorted DESC, rounded to 2 decimals)
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with a mean duration of over 2 hours (120 minutes)
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;


-- -----------------------------------------------------
-- 3. BONUS: Last names that are not repeated in the actor table
-- -----------------------------------------------------
SELECT last_name 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;