USE sakila;

-- Challenge #1
-- #1
SELECT MAX(length) AS max_duration, 
	   MIN(length) AS min_duration 
FROM film;

SELECT FLOOR(AVG(length) / 60) AS avg_hours, 
	   FLOOR(AVG(length) % 60) AS avg_minutes 
FROM film;

-- #2
SELECT DATEDIFF(MAX(rental_date), 
	   MIN(rental_date)) AS days_operating 
FROM rental;

 SELECT rental_id, rental_date, 
		DATE_FORMAT(rental_date, '%M') AS rental_month, 
		DATE_FORMAT(rental_date, '%W') AS rental_weekday 
FROM rental 
LIMIT 20;

-- #3
SELECT title, IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration 
FROM film 
ORDER BY title ASC;

-- Challenge #2
-- #1
SELECT COUNT(*) AS total_films 
FROM film;

SELECT rating, COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating;

SELECT rating, COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating 
ORDER BY number_of_films DESC;

-- #2
SELECT rating, ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

SELECT rating 
FROM film 
GROUP BY rating 
HAVING AVG(length) > 120;