USE sakila;
SELECT 
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

SELECT 
FLOOR(AVG(length) / 60) AS avg_hours,
ROUND(MOD(AVG(length), 60)) AS avg_minutes
FROM film;

SELECT 
DATEDIFF(MAX(rental_date), 
MIN(rental_date)) AS operating_days
FROM rental;

SELECT rental_id, rental_date,
MONTHNAME(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT title,
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating,
COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT rating,
COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

SELECT rating,
ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT rating,
ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;
