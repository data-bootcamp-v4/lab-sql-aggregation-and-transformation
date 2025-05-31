USE sakila;

SELECT MAX(length) AS max_duration
FROM FILM;

SELECT MIN(length) AS min_duration
FROM FILM;

SELECT ROUND(AVG(length),'') AS avg_duration_min
FROM FILM;

SELECT ROUND(AVG(length)/60,'') AS avg_duration_hours
FROM FILM;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT *
FROM rental;

SELECT
	rental_id, 
    rental_date, 
    inventory_id, 
    customer_id, 
    return_date, 
    staff_id, 
    last_update, 
    MONTH(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental;

SELECT 
  rental_id,
  rental_date,
  customer_id,
  return_date,
  inventory_id,
  staff_id,
  DAYNAME(rental_date) AS rental_weekday,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental;


SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;
    

SELECT 
		CONCAT(first_name,' ', last_name) AS full_name,
        LEFT(EMAIL, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, count(*) AS films_per_rating
FROM film
GROUP BY rating;

SELECT rating, count(*) AS films_per_rating
FROM film
GROUP BY rating
ORDER BY films_per_rating DESC;

SELECT rating, count(*) AS films_per_rating, ROUND(AVG (length),2) AS avg_film_duration
FROM film
GROUP BY rating
ORDER BY avg_film_duration DESC;

SELECT rating, count(*) AS films_per_rating, ROUND(AVG (length),2) AS avg_film_duration
FROM film
GROUP BY rating
HAVING avg_film_duration > 120
ORDER BY avg_film_duration DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) =1;

