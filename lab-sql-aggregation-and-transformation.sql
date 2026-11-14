USE sakila;

SHOW TABLES;
#Challenge 1
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) MOD 60) AS minutes
FROM film;
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
SELECT
    *,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;
SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_start
FROM customer
ORDER BY last_name ASC;
# Challenge 2
SELECT
    COUNT(*) AS total_films
FROM film;
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;
SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;