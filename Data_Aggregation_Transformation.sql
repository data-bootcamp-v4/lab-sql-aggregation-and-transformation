USE sakila;
SELECT 
    MAX(length) AS max_duration, MIN(length) AS min_duration
FROM
    film;
SELECT FLOOR(ROUND(AVG(length),0)/60) AS avg_hour,
MOD(ROUND(AVG(length),0),60) AS avg_minutes
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

SELECT *,
MONTH(rental_date) AS rental_month,
WEEKDAY(rental_date) AS rental_day
FROM rental
LIMIT 20;

SELECT *,
MONTH(rental_date) AS rental_month,
WEEKDAY(rental_date) AS rental_day,
CASE 
	WHEN WEEKDAY(rental_date) < 5 THEN 'workday'
	ELSE 'weekend'
END AS day_type
FROM rental;


SELECT title, rental_duration + IFNUll(rental_duration,'Not Available') AS film_available
FROM film
ORDER BY title ASC;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, SUBSTRING(email, 1, 3) AS email_prefix FROM customer ORDER BY last_name ASC;

SELECT COUNT(DISTINCT title) AS total_film
FROM film;

SELECT rental_rate, COUNT(DISTINCT title) AS number_film FROM film 
GROUP BY(rental_rate);

SELECT rental_rate, COUNT(DISTINCT title) AS number_film FROM film 
GROUP BY(rental_rate)
ORDER BY number_film DESC;
SELECT rental_rate, COUNT(DISTINCT title) AS number_film, ROUND(AVG(length), 2) AS mean_duration FROM film 
GROUP BY(rental_rate)
ORDER BY mean_duration DESC;
SELECT 
    rental_rate,
    COUNT(DISTINCT title) AS number_film,
    ROUND(AVG(length), 2) AS mean_duration
FROM
    film
GROUP BY (rental_rate)
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1;
