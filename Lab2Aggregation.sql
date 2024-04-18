#Challenge 1
USE sakila;
#1
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;


SELECT 
    CONCAT(FLOOR(AVG(length) / 60), ' hours ', ROUND(AVG(length) % 60), ' minutes') AS average_duration
FROM film;

#2
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating FROM rental;

SELECT 
    rental_id, 
    rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday 
FROM rental LIMIT 20;


SELECT rental_id, rental_date, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend' 
        ELSE 'workday' 
    END AS DAY_TYPE 
FROM rental LIMIT 50;

#3
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM film 
ORDER BY title ASC;

#Bonus
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    LEFT(email, 3) AS email_prefix 
FROM customer 
ORDER BY last_name ASC;

#Challenge 2
#1.1
SELECT COUNT(*) AS total_films_released FROM film;

#1.2
SELECT rating, COUNT(film_id) AS num_films FROM film GROUP BY rating;

#1.3
SELECT rating, COUNT(*) AS num_films 
FROM film 
GROUP BY rating 
ORDER BY num_films DESC;

#2
SELECT rating, ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

-- #2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, AVG(length) AS mean_duration 
FROM film 
GROUP BY rating 
HAVING AVG(length) > 120;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT last_name 
FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;
