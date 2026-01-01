-- ---------------------------------------------------
-- Lab: SQL Data Aggregation and Transformation
-- ---------------------------------------------------

USE sakila;

-- ---------------------------------------------------
-- Challenge 1
-- ---------------------------------------------------

-- 1.1 Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Express the average movie duration in hours and minutes (no decimals)
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(MOD(AVG(length), 60)) AS avg_minutes
FROM film;

-- 2.1 Calculate the number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Retrieve rental info + month + weekday (first 20)
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Add DAY_TYPE column ('weekend' or 'workday')
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Retrieve film titles and rental duration (replace NULL with 'Not Available')
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. BONUS: Concatenate first + last name and first 3 chars of email
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- ---------------------------------------------------
-- Challenge 2
-- ---------------------------------------------------

-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films for each rating
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 1.3 Number of films per rating (sorted descending)
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2.1 Mean film duration per rating, rounded to 2 decimals
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours (120 mins)
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;

-- 3. BONUS: Last names in 'actor' table that are not repeated
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;
