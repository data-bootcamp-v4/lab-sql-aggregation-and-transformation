use sakila;

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

SELECT 
    FLOOR(ROUND(AVG(length)) / 60) AS avg_hours,
	MOD(ROUND(AVG(length)), 60) AS remaining_minutes
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS OPERATING_DAYS
FROM rental;

SELECT r.*,
MONTHNAME(r.rental_date) AS rental_month,
DAYNAME(r.rental_date) AS rental_day
FROM rental AS r
LIMIT 20;

SELECT 
	title,
    IFNULL(rental_duration, "Not Available") AS rental_duration
    FROM film
    ORDER BY title ASC;
    
SELECT COUNT(*) AS total_films
FROM film;

SELECT COUNT(*) AS total_films,
	rating
FROM film
GROUP BY rating; 
    
SELECT COUNT(*) AS total_films,
	rating
FROM film
GROUP BY rating
ORDER BY total_films DESC;

SELECT 
	ROUND(AVG(length), 2) AS mean_duration,
    rating
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

 SELECT 
	ROUND(AVG(length), 2) AS mean_duration,
    rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;
