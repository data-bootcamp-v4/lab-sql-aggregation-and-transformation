
-- LAB | SQL Data Aggregation and Transformation

-- CHALLENGE 1

-- 1.1 Determine the shortest and longest movie durations.
USE sakila;

SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Express the average movie duration in hours and minutes. Don't use decimals.

SELECT 
    FLOOR(AVG(length) / 60) AS average_hours,
    ROUND(AVG(length) % 60) AS average_minutes
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Retrieve rental information and add month and weekday columns. Return 20 rows.

SELECT 
    *,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Add DAY_TYPE with values 'weekend' or 'workday'.

SELECT 
    *,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Retrieve film titles and rental duration. Replace NULL with 'Not Available'.

SELECT 
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS: Concatenate first and last names of customers,
-- and retrieve first 3 characters of their email.

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2

-- 1.1 Total number of films released.

SELECT 
    COUNT(*) AS total_films_released
FROM film;

-- 1.2 Number of films for each rating.

SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, sorted descending.

SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;


-- 2.1 Mean film duration for each rating, rounded to two decimals,
-- sorted descending.

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;


-- 2.2 Ratings with mean duration over two hours.

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- BONUS: Last names that are not repeated in actor table.

SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;