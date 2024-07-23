USE sakila;
SHOW TABLES;

SELECT MAX(`length`) AS max_duration, MIN(`length`) AS min_duration FROM film;
SELECT CONCAT(FLOOR(AVG(`length`)/60),'h ',ROUND(AVG(`length`)%60,0),'min') FROM film;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM rental;
SELECT *,DATE_FORMAT(rental_date,'%M') AS Month,DATE_FORMAT(rental_date,'%W') AS weekday FROM rental LIMIT 20;
SELECT *, CASE WHEN DATE_FORMAT(rental_date, '%w') IN (0, 6) THEN 'weekend' ELSE 'workday' END AS day_type FROM rental;
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration FROM film ORDER BY title ASC;
SELECT CONCAT(first_name,last_name,SUBSTRING(email,1,3)) AS maketing_email FROM customer ORDER BY last_name ASC;
SELECT COUNT(film_id) FROM film WHERE release_year IS NOT NULL;
SELECT rating, COUNT(*) AS total FROM film GROUP BY rating;
SELECT rating, COUNT(*) AS total FROM film GROUP BY rating ORDER BY total DESC;
SELECT rating, ROUND(AVG(`length`),2) AS avg_duration, COUNT(*) AS total FROM film GROUP BY rating ORDER BY avg_duration DESC;
SELECT rating, ROUND(AVG(`length`),2) AS avg_duration FROM film GROUP BY rating HAVING avg_duration > 120;
