USE sakila;

SELECT MIN(length) as min_duration, MAX(length) as max_duration FROM film;
SELECT FLOOR(AVG(length)) as ave_movie_duration_min, ROUND(AVG(length)/60,2) as avg_movie_duration_hour FROM film;

SELECT MIN(rental_date) as first_date, MAX(rental_date) as last_day, DATEDIFF(MAX(rental_date),MIN(rental_date)) as operating_days FROM rental;

SELECT *, DATE_FORMAT(rental_date, '%m') as month, DATE_FORMAT(rental_date,'%w') as weekday, 
	CASE
		WHEN DATE_FORMAT(rental_date,'%w') = 0 THEN 'weekend'
        WHEN DATE_FORMAT(rental_date,'%w') = 6 THEN 'weekend'
        ElSE 'weekday'
	END AS day_type
FROM rental
LIMIT 20;

SELECT title, COALESCE(rental_duration,'Not Available')
FROM film;

SELECT title, COALESCE(rental_duration, 'NA')
FROM film
WHERE rental_duration IS NULL;

SELECT CONCAT(last_name," ", first_name) as full_name, LEFT(email,3)
FROM customer
ORDER BY last_name;

SELECT COUNT(film_id) as total_number_of_films FROM film;

SELECT rating, COUNT(film_id) as total_number_of_films FROM film GROUP BY rating ORDER BY total_number_of_films DESC;

SELECT rating, ROUND(AVG(length),2) as avg_duration FROM film GROUP BY rating HAVING avg_duration > 120 ORDER BY avg_duration DESC;

SELECT DISTINCT last_name FROM actor;




