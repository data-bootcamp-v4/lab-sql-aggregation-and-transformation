USE sakila;

SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM film;

SELECT CONCAT(FLOOR(AVG(length) / 60), 'h ', FLOOR(AVG(length) % 60), 'm') AS avg_duration_hm
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT rental_id, rental_date, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;

SELECT rental_id, rental_date,
       CASE WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend' ELSE 'workday' END AS DAY_TYPE
FROM rental
ORDER BY rental_date
LIMIT 20;

SELECT title,
       COALESCE(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS films_count
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS films_count
FROM film
GROUP BY rating
ORDER BY films_count DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_length
FROM film
GROUP BY rating
ORDER BY mean_length DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_length_over_2h
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_length_over_2h DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;