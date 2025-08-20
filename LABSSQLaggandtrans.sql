USE sakila;

SELECT * FROM film;
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(MOD(AVG(length), 60)) AS avg_minutes
FROM film;

SELECT * FROM rental;

SELECT DATEDIFF
(MAX(rental_date),
MIN(rental_date)) AS operating_days
FROM rental;

SELECT * FROM rental;
SELECT *, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT * FROM rental;
SELECT *, 
       CASE 
		WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') 
		THEN 'weekend'
		ELSE 'workday'
        END AS DAY_TYPE
FROM rental;

SELECT * FROM film;

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
	FROM film
	ORDER By title ASC;
    
    
SELECT * FROM film;

SELECT COUNT(DISTINCT title) AS distinct_film
FROM film;

SELECT rating, COUNT(rating) AS film_count
    FROM film
    GROUP BY rating
    ORDER BY film_count DESC;
    
    SELECT * FROM film;
    
    SELECT rating, ROUND(AVG(length), 2) AS avg_length
    FROM film
    GROUP BY rating 
    ORDER BY avg_length DESC;
    
    SELECT rating, ROUND(AVG(length), 2) AS avg_length
    FROM film
    GROUP BY rating 
    HAVING AVG(length) > 120
    ORDER BY avg_length DESC;