USE sakila;

-- Challenge 1
-- 1.1 Shortest and longest movie durations
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes (no decimals)
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 Number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Rental info with month and weekday
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: add DAY_TYPE
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration, replacing NULLs
SELECT 
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bonus: concatenated customer name and first 3 email characters
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1 Total number of films
SELECT 
    COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films for each rating
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, sorted descending
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Mean film duration for each rating
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

-- 3. Bonus: last names not repeated in actor table
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;