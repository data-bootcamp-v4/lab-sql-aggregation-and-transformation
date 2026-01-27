USE sakila;
SHOW TABLES;

SELECT *
FROM film;

SELECT
MIN(length) AS min_lenght,
MAX(length) AS max_length
FROM film;

SELECT
  FLOOR(AVG(length) / 60) AS avg_hours,
  ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

SELECT *
FROM rental;

SELECT 
DATEDIFF(max(rental_date), min(rental_date)) AS operating_days
FROM rental;

SELECT
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  MONTH(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  CASE
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    ELSE 'workday'
  END AS DAY_TYPE
FROM rental
LIMIT 20;

SELECT
  title,
  IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT *
FROM customer;

SELECT 
CONCAT(first_name, ' ', last_name) AS full_name,
LEFT(email, 3) AS email_mark
FROM customer
ORDER BY last_name ASC;

SELECT *
FROM film;

SELECT
COUNT(film_id)
FROM film;

SELECT
rating,
COUNT(film_id)
FROM film
GROUP BY
rating;

SELECT
rating,
COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

SELECT
rating,
ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

SELECT
rating,
AVG(length) AS avg_len
FROM film
GROUP BY
rating
HAVING avg_len > 120;

SELECT *
FROM actor;

SELECT
last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1 



