USE sakila;
SHOW TABLES;
-- CHALLENGE 1:
-- QUESTION 1:
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;
SELECT CONCAT (AVG(length) / 60, "hours",  AVG(length) % 60, "minutes") AS avg_duration FROM film;
-- QUESTION 2:
SELECT DATEDIFF (MAX(rental_date), MIN(rental_date)) AS days_operating FROM rental;
SELECT rental_date, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday FROM rental LIMIT 20;
-- BONUS:
SELECT rental_date,
	CASE
		WHEN DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7 THEN "Weekend"
		ELSE "workday"
	END AS day_type
FROM rental LIMIT 20;
-- QUESTION 3:
SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration FROM film ORDER BY title ASC;
-- BONUS:
SELECT CONCAT(last_name, " ", first_name) AS full_name, LEFT(email, 3) AS first_3_char_email FROM customer ORDER BY last_name ASC;
-- CHALLENGE 2:
-- QUESTION 1:
SELECT COUNT(*) AS total_films_released FROM film;
SELECT rating, COUNT(*) AS films_count_for_each_rating FROM film GROUP BY rating;
SELECT rating, COUNT(*) AS films_count_for_each_rating FROM film GROUP BY rating ORDER BY films_count_for_each_rating DESC;
-- QUESTION 2:
SELECT rating, ROUND(AVG(length), 2) AS mean_film_dur FROM film GROUP BY rating ORDER BY mean_film_dur DESC;
SELECT rating, ROUND(AVG(length), 2) AS mean_film_dur FROM film GROUP BY rating HAVING AVG(length)>120;
-- BONUS:
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1;





