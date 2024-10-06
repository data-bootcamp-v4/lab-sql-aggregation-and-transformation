USE sakila;

SELECT * FROM film;

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;

SELECT AVG(length) FROM film;
SELECT ROUND(AVG(length),0) FROM film;
SELECT FLOOR(AVG(length)) FROM film;

SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes
FROM film;

SELECT * FROM rental;

SELECT DATEDIFF(MIN(rental_date), MAX(rental_date)) FROM rental;

SELECT *, DATE_FORMAT(rental_date, "%M") AS month, DAYNAME(rental_date) AS weekday 
FROM rental
LIMIT 20; 

#SELECT *, DATE_FORMAT(rental_date, "%M") AS month, LEFT(DAYNAME(rental_date),3) AS weekday FROM rental; 

SELECT *, DAYNAME(rental_date) AS weekday,
CASE
	WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
	ELSE 'workday'
END AS DAY_TYPE
FROM rental; 

SELECT * FROM film;

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT * FROM customer;

SELECT CONCAT(first_name,' ',last_name) AS full_name, LEFT (email,3) AS email_abr
FROM customer
ORDER BY last_name ASC;

SELECT * FROM film;

SELECT COUNT(*) FROM film;

SELECT rating, COUNT(*)
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

SELECT rating, ROUND(AVG(length),2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT rating, ROUND(AVG(length),2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120
ORDER BY avg_duration DESC;

SELECT * FROM actor;

SELECT first_name, last_name
FROM actor
GROUP BY last_name
ORDER BY last_name ASC;

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
ORDER BY COUNT(*) ASC;

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;


