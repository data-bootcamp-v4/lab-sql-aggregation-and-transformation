USE sakila;

SELECT * FROM film;

SELECT 
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;

SELECT 
FLOOR(AVG(length) / 60) AS hours,
ROUND(AVG(length) % 60) AS minutes
FROM film;

SELECT * FROM rental;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) as operation_days
FROM rental;

SELECT rental_date,
MONTH(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT rental_date,
DAYNAME(rental_date) AS rental_weekday,
CASE 
  WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
  ELSE 'Workday'
END AS Day_type
FROM rental
LIMIT 20;

SELECT title,
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT COUNT(*) FROM film;

SELECT * FROM film;

SELECT COUNT(*), rating
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration DESC;

SELECT 
  last_name,
  COUNT(*) AS number_of_actors
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;






