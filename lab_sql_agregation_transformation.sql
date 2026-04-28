USE sakila;

SELECT
	MIN(length) AS min_duration,
	MAX(length) AS max_duration
FROM film;

SELECT
	FLOOR(avg(length) / 60) AS avg_hours,
    ROUND(avg(length) % 60) AS avg_minutes
from film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

SELECT *,
	MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT *,
	CASE
		WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
	END AS DAY_TYPE
FROM rental;

SELECT
	title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT
	CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS number_of_films
FROM film
group by rating;

SELECT rating, COUNT(*) AS number_of_films
FROM film
group by rating
order by number_of_films DESC;

SELECT rating, ROUND(avg(length), 2) AS mean_duration
FROM film
group by rating
order by mean_duration DESC;

SELECT rating, ROUND(avg(length), 2) AS mean_duration
FROM film
group by rating
having mean_duration >120;

SELECT last_name
FROM actor
group by last_name
HAVING COUNT(*) = 1;
