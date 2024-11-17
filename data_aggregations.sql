USE sakila;
SHOW tables FROM sakila;

SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM sakila.film;
SELECT length, (length / 60) AS Hours, (length % 60) AS Minutes, CONCAT ((FLOOR(length / 60)), ' ', 'Hours', ' ',  (length % 60), ' ', 'Minutes') AS Formatted_duration FROM sakila.film;
SELECT MIN(rental_date) FROM rental;
SELECT MAX(rental_date) FROM rental;
SELECT DISTINCT DATEDIFF('2006-02-14', '2005--5-24') AS days_operating FROM rental; 

SELECT *, DAYNAME(rental_date), MONTHNAME(rental_date) FROM rental LIMIT 20;
SELECT *, IF (DAYNAME(rental_date) = 'Sunday' OR 'Saturday', 'Weekend', 'Workday') AS DAY_TYPE FROM rental; 

SELECT title, IFNULL (length, 'Not Available') AS length FROM film
ORDER BY title ASC;

SELECT *, CONCAT(first_name, ' ', last_name) as full_name, LEFT(email, 3) AS first_three_characters FROM customer
ORDER BY last_name ASC;

SELECT COUNT(film_id) AS number_of_films_released FROM film;
SELECT rating, COUNT(film_id) AS number_of_films_released FROM film
GROUP BY rating;
SELECT rating, COUNT(film_id) AS number_of_films_released FROM film
GROUP BY rating ORDER BY number_of_films_released DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_length FROM film
GROUP BY rating
HAVING avg_length > 120
ORDER BY avg_length DESC; 

SELECT last_name FROM actor 
GROUP BY last_name
HAVING COUNT(*) = 1;


