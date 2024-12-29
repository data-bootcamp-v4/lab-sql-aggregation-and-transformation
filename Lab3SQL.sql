USE sakila;

SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;
SELECT * FROM rental;

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

SELECT
   CONCAT(
      FLOOR(AVG(length)/60),
      ' hours ',
      ROUND(AVG(length)/60),
      ' minutes'
      ) AS average_duration
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT 
    rental_id, 
    rental_date, 
    MONTH(rental_date) AS rental_month, 
    CASE 
        WHEN WEEKDAY(rental_date) = 0 THEN 'Sunday'
        WHEN WEEKDAY(rental_date) = 1 THEN 'Monday'
        WHEN WEEKDAY(rental_date) = 2 THEN 'Tuesday'
        WHEN WEEKDAY(rental_date) = 3 THEN 'Wednesday'
        WHEN WEEKDAY(rental_date) = 4 THEN 'Thursday'
        WHEN WEEKDAY(rental_date) = 5 THEN 'Friday'
        ELSE 'Saturday'
    END AS rental_weekday
FROM rental
LIMIT 20;
SELECT 
    rental_id, 
    rental_date, 
    CASE 
        WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM 
    customer
ORDER BY 
    last_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;
    
    -- 2.2 Identify which ratings have a mean duration of over two hours
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    mean_duration > 120;
    
    SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;