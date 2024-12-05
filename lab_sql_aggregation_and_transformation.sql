USE sakila;

SELECT MAX(length) AS max_duration
FROM  film; 

SELECT MIN(length) AS min_duration
FROM film; 

SELECT FLOOR(AVG(length)/60) AS hours, ROUND(AVG(length)%60) AS mins
FROM film; 

SELECT CONCAT( FLOOR(AVG(length)/60), ' hour ', ROUND(AVG(length)%60), ' minutes') AS duration
FROM film; 

SELECT DATEDIFF(curdate(),MIN(rental_date))
FROM rental; 

SELECT *, month(rental_date), weekday(rental_date)
FROM rental; 

SELECT *, 
CASE 
WHEN weekday(rental_date) <= 5 THEN 'workday'
ELSE 'weekend'
END AS DAY_TYPE
FROM rental;

SELECT title, IFNULL(rental_duration, 'Not available') AS rental_duration
FROM film
ORDER BY title; 

SELECT CONCAT(first_name, ' ', last_name) AS full_name, LEFT(email, 3)AS email_prefix
FROM customer
ORDER BY last_name;

SELECT COUNT(DISTINCT title)
FROM film;

SELECT rating, COUNT(rating)
FROM film
GROUP BY rating;

SELECT rating, COUNT(rating) AS number_films
FROM film
GROUP BY rating
ORDER BY number_films DESC;

SELECT DISTINCT rating, ROUND(AVG(length),2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

SELECT DISTINCT rating, ROUND(AVG(length),2) AS avg_length
FROM film
GROUP BY rating
HAVING avg_length > 120;
