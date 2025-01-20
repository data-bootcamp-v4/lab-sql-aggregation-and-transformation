USE sakila;

SELECT *
FROM film;

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

SELECT AVG(length), CONCAT(length DIV 60, ' hours and ', length % 60, ' minutes') AS Time_Formatted
FROM film;

SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes
FROM film;

SELECT length, CONCAT(length DIV 60, ' hours and ', length % 60, ' minutes') AS Time_Formatted
FROM film;

SELECT MIN(rental_date), MAX(rental_date)
FROM rental;

SELECT DATEDIFF("2006-02-14", "2005-05-24") AS Number_days_operation
FROM rental
LIMIT 1;

SELECT *
FROM rental;

ALTER TABLE rental
ADD WEEKDAY varchar(50);

UPDATE rental
SET WEEKDAY = 
WHERE DATE_FORMAT(rental_date, '%W'); 

SELECT *, DATE_FORMAT(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY
FROM rental;

ALTER TABLE rental
ADD day_type varchar(50);

UPDATE rental
SET day_type = "weekday"
WHERE WEEKDAY = "Tuesday" "Monday", "Wednesday", "Thursday", "Friday"; 

SELECT *, DATE_FORMAT(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY
FROM rental
LIMIT 20;


SELECT title, COALESCE(rental_duration, "Not Available") AS duration
FROM film
ORDER BY title ASC;

SELECT *
FROM customer;

SELECT *, CONCAT( first_name," ", last_name) AS full_name, SUBSTRING(email, 1, 3) AS email_characcters
FROM customer
ORDER BY last_name;

SELECT *
FROM film;

SELECT COUNT(film_id)
FROM film;

SELECT rating, COUNT(film_id) AS films_by_rating
FROM film
GROUP BY rating;

SELECT rating, COUNT(film_id) AS films_by_rating
FROM film
GROUP BY rating
ORDER BY films_by_rating DESC;

SELECT rating, ROUND(AVG(length), 2) AS Avg_Duration
FROM film
GROUP BY rating
ORDER BY Avg_Duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS Avg_Duration
FROM film
GROUP BY rating
HAVING Avg_Duration > 120
ORDER BY Avg_Duration DESC;

SELECT DISTINCT last_name
FROM actor;



