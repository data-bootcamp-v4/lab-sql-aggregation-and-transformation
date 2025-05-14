SELECT 
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

SELECT
FLOOR(AVG(length)/60) AS horas,
FLOOR(AVG(length)%60) AS mminutos
FROM film;

SELECT
DATEDIFF((MAX(rental_date)),(MIN(rental_date)))
FROM rental;

SELECT *,
MONTH(rental_date) AS rental_month,
DAYOFWEEK(rental_date) AS rental_day
FROM rental
LIMIT 20;

SELECT *,
CASE 
	WHEN DAYOFWEEK(rental_date) = 5
	OR DAYOFWEEK(rental_date) = 6
	THEN 'Workday'
	ELSE 'Weekend'
	END AS day_type
FROM rental;

SELECT IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film;

SELECT
COUNT(DISTINCT film_id)
FROM film;

SELECT
rating,
COUNT(DISTINCT film_id) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

SELECT
rating,
ROUND(AVG(DISTINCT length)) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT
rating,
ROUND(AVG(DISTINCT length)) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

SELECT
last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;



