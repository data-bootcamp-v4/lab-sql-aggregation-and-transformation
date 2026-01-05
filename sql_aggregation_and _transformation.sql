USE sakila;

SELECT
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;





-- 1.2 Average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 Number of days company has been operating
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

-- 2.3 Rental info with day type
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration (handle NULLs)
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Bonus: Customer names and email prefix
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- 1.1 Total number of films
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films per rating
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Films per rating (descending)
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Mean film duration per rating
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Bonus: Non-repeated actor last names
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
