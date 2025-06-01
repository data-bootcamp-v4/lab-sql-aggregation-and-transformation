USE sakila;

SELECT MAX(length) as max_duration, MIN(length) as min_duration
FROM film;

SELECT ROUND(AVG(length/60)) as avg_hour_duration
FROM film;

SELECT FLOOR(AVG(length)) as avg_min_duration
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental;

SELECT *, DATE_FORMAT(rental_date, "%M") as month, DATE_FORMAT(rental_date, "%W") as weekday
FROM rental;

WITH cte_rental AS (
SELECT *, DATE_FORMAT(rental_date, "%W") as weekday
FROM rental)

SELECT *, 
CASE weekday
WHEN "Saturday" THEN "weekend"
WHEN "Sunday" THEN "weekend"
ELSE "workday"
END AS day_type
FROM cte_rental;

SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration
FROM film
ORDER BY title;

SELECT CONCAT(first_name, " ", last_name) as full_name, SUBSTR(email, 1, 3) AS extract_email
FROM customer
ORDER BY last_name;

SELECT count(DISTINCT film_id) as films_released
FROM film;

SELECT rating, count(film_id) as number_films
FROM film
GROUP BY rating;

SELECT rating, count(film_id) as number_films
FROM film
GROUP BY rating
ORDER BY number_films DESC;

SELECT rating, round(avg(length), 2) as avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

SELECT rating
FROM (SELECT rating, round(avg(length), 2) as avg_length
FROM film
GROUP BY rating) avgleng
WHERE avgleng.avg_length > 120
ORDER BY avgleng.avg_length;

SELECT last_name
FROM (SELECT last_name, count(last_name) as rep_table
FROM actor
GROUP BY last_name) count_ln
WHERE count_ln.rep_table = 1;