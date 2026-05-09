USE sakila;
SELECT * FROM rental;
-- 1. 
SELECT MIN(length) AS 'min duration' , MAX(length) from film;

-- 1.2. 
SELECT CONCAT(FLOOR(AVG(length) / 60), 'h ', ROUND(AVG(length) % 60), 'm') as 'Avg length' FROM film;

-- 2.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS 'Ops dates' FROM rental;

-- 2.1.
SELECT *, MONTHNAME(rental_date) as rental_month, DAYNAME(rental_date) AS 'rental_weekday' FROM rental LIMIT 20;

-- 2.2.
SELECT *, CASE WHEN DAYNAME(rental_date) IN (1,7) THEN 'Weekend' ELSE 'workday' END AS DAY_TYPE FROM rental;

-- 3.
SELECT f.title, IFNULL(DATEDIFF(r.return_date, r.rental_date), 'Not available') AS rental_duration
FROM film f
JOIN inventory i on f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title ASC;

-- 4.
SELECT CONCAT(first_name, ' ', last_name) AS fill_name, LEFT(email, 3) AS email_start
FROM customer ORDER BY last_name ASC;

-- Challenge 2 Question 1
SELECT COUNT(*) AS total_film
FROM film;

-- 1.2
SELECT rating, COUNT(*) AS 'number of film'
FROM film
GROUP BY rating;

-- 1.3
SELECT rating, COUNT(*) as number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.
SELECT rating, ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1;
 