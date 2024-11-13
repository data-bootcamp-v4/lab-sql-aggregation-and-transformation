-- Challenge 1

-- 1.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM film;
SELECT FLOOR(AVG(length) / 60.0) as avg_duration_hours, ROUND(AVG(length) - 60 * FLOOR(AVG(length) / 60.0)) AS avg_duration_minutes FROM film;

-- 2.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM rental;
SELECT *, MONTH(rental_date), WEEKDAY(rental_date) FROM rental LIMIT 20;
SELECT *, CASE WEEKDAY(rental_date) WHEN 6 THEN "weekend" WHEN 7 THEN "weekend" ELSE "weekday" END day_type FROM rental;

-- 3.
SELECT title, IFNULL(rental_duration, "Not Available") FROM film ORDER BY title ASC;

-- 4.
SELECT CONCAT(first_name, " ", last_name) AS full_name, SUBSTR(email, 1, 3) FROM customer ORDER BY last_name ASC;

-- Challenge 2

-- 1.
SELECT COUNT(*) FROM film;
SELECT rating, COUNT(*) FROM film GROUP BY rating;
SELECT rating, COUNT(*) number_of_films FROM film GROUP BY rating ORDER BY number_of_films DESC;

-- 2.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM film GROUP BY rating ORDER BY mean_duration DESC;
SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM film GROUP BY rating HAVING mean_duration > 120 ORDER BY mean_duration DESC;

-- 3.
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1;