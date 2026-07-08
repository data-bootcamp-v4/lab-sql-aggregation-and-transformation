USE sakila;

-- Challenge 1 --

-- Q1 --
-- Q1.1 --

SELECT  MIN(length) as min_duration,
        MAX(length) as max_duration
FROM film;

-- Q1.2 --

SELECT  
    FLOOR (AVG (length) /60) AS avg_hours,
    ROUND (AVG (length) % 60 ) AS avg_minutes
FROM film;

-- Q2 --
-- Q2.1 --

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- Q2.2 --

SELECT 
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Q2.3 --

SELECT 
   *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- Q3 --

SELECT  
    title, 
    IFNULL (rental_duration, 'Not Available') AS rental_duration
FROM film;

-- Q4 --

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2 --

-- Q1 --
-- Q1.1 --

SELECT  release_year, 
        COUNT(title) AS number_of_films
FROM film
GROUP BY release_year;

-- Q1.2 --

SELECT  rating, 
        COUNT(title) as number_of_films
FROM film
GROUP BY rating;

-- Q1.3 --

SELECT  rating, 
        COUNT(title) as number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Q2 --
-- Q2.1 --

SELECT  rating,
        ROUND(AVG(length), 2) AS mean_film_duration
FROM film
GROUP BY rating
ORDER BY mean_film_duration DESC;

-- Q2.2 --

SELECT  rating,
        ROUND(AVG(length), 2) AS mean_film_duration
FROM film
GROUP BY rating
HAVING mean_film_duration > 120
ORDER BY mean_film_duration DESC;

-- Q3 --
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;