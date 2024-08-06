#lab3
USE sakila;

#1.1
SELECT 
	 MAX(length) AS max_duration,
     MIN(length) AS min_duration
FROM film;

#1.2
SELECT
	FLOOR(AVG(length)/60) AS average_hours,
    ROUND(AVG(length) %60) AS avg_minutes
FROM film;

#2.1
SELECT 
	DATEDIFF(MAX(rental_date), min(rental_date))
FROM rental;

SELECT * FROM rental;

#2.2
SELECT 
	rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

#2.3
SELECT
	rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
		WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
	END AS DAY_TYPE
FROM rental;

#3
SELECT
	title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
