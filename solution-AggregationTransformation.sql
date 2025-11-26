USE sakila;

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

(SELECT
	title, length
FROM film
ORDER BY length DESC, title
LIMIT 1)
UNION ALL
(SELECT
	title, length
FROM film
ORDER BY length, title
LIMIT 1);

SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(AVG(length) % 60) AS minutes
FROM film;

SELECT
	datediff(MAX(rental_date),MIN(rental_date)) as Days_Operating
FROM rental;

SELECT
	monthname(rental_date) AS 'rental_month',
    dayname(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT rental_date,
    CASE 
		WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'Weekend'
        ELSE 'Workday'
    END AS DAY_TYPE
FROM rental;

SELECT
  title,
  IFNULL(CONCAT(rental_duration, ''), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

SELECT 
    last_name,
    COUNT(*) AS number_last_names
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;


SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;


SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

