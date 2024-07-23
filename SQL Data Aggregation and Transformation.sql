-- Active: 1721290976264@@127.0.0.1@3306@sakila
USE sakila

--challenge 1--

--1.1--
SELECT MAX(film.length) AS max_duration, MIN(film.length) AS min_duration
FROM sakila.film

--1.2--
SELECT ROUND(AVG(film.length),0)
FROM film

SELECT ROUND((AVG(film.length))/60,0)
FROM film

--2.1--
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS DaysOperating
FROM rental;

--2.2--
SELECT *, MONTH(rental_date) AS Month,
    DAYNAME(rental_date) AS Weekday
FROM rental
LIMIT 20

--2.3--
SELECT *,
CASE
    WHEN DAYNAME(rental_date) = 'Monday' THEN 'workday'
    WHEN DAYNAME(rental_date) = 'Tuesday' THEN 'workday'
    WHEN DAYNAME(rental_date) = 'Wedensday' THEN 'workday'
    WHEN DAYNAME(rental_date) = 'Thursday' THEN 'workday'
    WHEN DAYNAME(rental_date) = 'Friday' THEN 'workday'
    ELSE 'weekend'
END AS DAY_TYPE
FROM rental

--3--
SELECT film.title, IFNULL(film.rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC

--4--
SELECT *, CONCAT(customer.first_name, ' ' ,customer.last_name, ' ', LEFT(customer.email, 3)) AS full_name
FROM customer
ORDER BY customer.last_name ASC

--challenge 2--

--1.1--
SELECT COUNT(*) AS num_of_film_release 
FROM film

--1.2--
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating

--1.3--
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC

--2.1--
SELECT rating, ROUND(AVG(`length`),2)
FROM film
GROUP BY rating
ORDER BY AVG(`length`) DESC

--2.2--
SELECT rating, ROUND(AVG(`length`),2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120

--3--
SELECT last_name, COUNT(DISTINCT last_name) AS unique_last
FROM actor
GROUP BY last_name
HAVING unique_last = 1


