USE sakila;

SELECT MAX(length) AS max_duration FROM film;
SELECT MIN(length) AS min_duration FROM film;

SELECT FLOOR(AVG(length) / 60) AS hours,
       ROUND((AVG(length) % 60), 0) AS minutes
FROM film;

SELECT DATEDIFF(DATE(MAX(rental_date)), DATE(MIN(rental_date))) AS days_operating
FROM rental;

SELECT *,
	   MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_day
FROM rental;

SELECT title AS film_title,
	   IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY film_title ASC;	 

SELECT COUNT(film_id)
FROM film;  

SELECT rating,
	   COUNT(*) AS films_per_rating
FROM film
GROUP BY rating;

SELECT rating,
	   COUNT(*) AS films_per_rating
FROM film
GROUP BY rating
ORDER BY films_per_rating DESC;

SELECT rating,
	   ROUND(AVG(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
ORDER BY avg_film_duration DESC;

SELECT rating,
	   ROUND(AVG(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_film_duration DESC;