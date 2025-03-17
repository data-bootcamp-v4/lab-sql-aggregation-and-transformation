#Challenge 1
#1
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration 
FROM 
sakila.film;
SELECT * FROM sakila.film;
SELECT FLOOR(AVG(length)/60) as hours,
	   FLOOR(AVG(length)%60) as minutes
FROM sakila.film;

#2
SELECT DATEDIFF(max(rental_date), min(rental_date)) as operating_days FROM sakila.rental;
SELECT *, DATE_FORMAT(rental_date, "%d") as "weekday", DATE_FORMAT(rental_date, "%m") as "month"
FROM sakila.rental
LIMIT 20;
SELECT *,
	CASE
		WHEN DATE_FORMAT(rental_date, "%W") = "Saturday" THEN "weekend"
		WHEN DATE_FORMAT(rental_date, "%W") = "Sunday" THEN "weekend"
		ELSE "weekday"
		END AS "day_type"
FROM sakila.rental;
#3
SELECT title, IFNULL(rental_duration, "not available") as rental_duration
FROM sakila.film
ORDER BY title ASC;
#4 Bonus
SELECT CONCAT(first_name, last_name), LEFT(email,3)
FROM sakila.customer
ORDER BY last_name ASC;

#Challenge 2
#1
SELECT COUNT(DISTINCT title) as total_num_films FROM sakila.film;
SELECT rating, COUNT(DISTINCT title) FROM sakila.film
GROUP by rating;
SELECT rating, COUNT(DISTINCT title) as total_released FROM sakila.film
GROUP by rating
ORDER BY total_released DESC;

#2
SELECT * FROM sakila.film;
SELECT rating, ROUND(AVG(length), 2) as mean_duration FROM sakila.film
GROUP by rating
ORDER BY mean_duration DESC;

SELECT rating, ROUND(AVG(length), 2) as mean_duration 
FROM sakila.film
GROUP by rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

#3 Bonus
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1;