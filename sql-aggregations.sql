USE sakila;

SELECT MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

SELECT time_format(sec_to_time(ROUND(AVG(length)*60)),'%H:%i') as avg_duration FROM film;

SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) FROM rental;

SELECT *, 
MONTHNAME(rental_date) AS rental_month, 
DAYNAME(rental_date) AS rental_day,
CASE WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend' ELSE 'weekday' END AS day_type
FROM rental LIMIT 20;

SELECT title,
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film;

SELECT COUNT(*) AS tot_film_released FROM film;

SELECT rating,
COUNT(*) AS tot_film_released 
FROM film
GROUP BY rating
ORDER BY tot_film_released DESC;

SELECT rating,
ROUND(AVG(length),2) AS film_duration 
FROM film
GROUP BY rating
HAVING film_duration > 120
ORDER BY film_duration DESC;

SELECT last_name, count(*) AS num_names FROM actor GROUP BY last_name HAVING num_names = 1;

