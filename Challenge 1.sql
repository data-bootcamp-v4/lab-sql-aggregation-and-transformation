USE sakila;

SELECT
	MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

SELECT
	FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

SELECT
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT
	rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT
	rental_id,
    rental_date,
    DAYNAME(rental_date) AS weekday_name,
    CASE
		WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
	END AS DAY_TYPE
FROM rental
LIMIT 20;

SELECT
	title,
	IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM customer
ORDER BY last_name ASC;