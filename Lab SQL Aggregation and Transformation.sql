USE sakila;
SHOW TABLES;
SELECT * FROM film;

SELECT MAX(length) AS max_duration FROM film;
SELECT MIN(length) AS min_duration FROM film;
SELECT (AVG(length)/60) AS avg_duration FROM film;

SELECT 
    CONCAT(FLOOR(AVG(length) / 60), ":", LPAD(ROUND(AVG(length) % 60), 2, "0")) AS avg_hours 
FROM film;
SELECT 
    CONCAT(FLOOR(AVG(length) / 60), ":", LPAD(ROUND(AVG(length) % 60), 2, "0")) AS avg_hours 
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS number_days_operation FROM rental;

SELECT *, 
       DATE_FORMAT(rental_date, "%M") AS month, 
       DATE_FORMAT(rental_date, "%W") AS weekday,
       CASE 
           WHEN DATE_FORMAT(rental_date, "%W") IN ("Saturday", "Sunday") THEN "Weekend"
           ELSE "Weekday"
       END AS day_type
FROM rental;

SELECT title, rental_duration,
       CASE 
           WHEN rental_duration IS NULL THEN "NOT Available"
           ELSE rental_duration
       END AS rental_status
FROM film
ORDER BY title DESC;

SELECT first_name, last_name, LEFT(email, 3) AS first_characters_email
FROM customer
ORDER BY last_name ASC;

SELECT COUNT(*) FROM film;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
ORDER BY avg_film_duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_film_duration,
CASE 
	WHEN AVG(length) > 120 THEN "over two hrs in average"
    ELSE "under two hrs in average"
END AS comment
FROM film
GROUP BY rating
ORDER BY avg_film_duration DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;













	





