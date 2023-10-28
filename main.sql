--  CHALENGE 1 --
--  1.1
USE sakila;
SELECT title, length 
FROM film 
WHERE length = (select MIN(length) from film);

SELECT title, length 
FROM film 
WHERE length = (select MAX(length) from film);

--  1.2
SELECT floor(AVG(length)/60) AS hours, ROUND(AVG(length)) % 60 as mins 
FROM film;

--  2.1
SELECT DATEDIFF(MAX(rental_date),  MIN(rental_date)) 
FROM rental;

--  2.2
SELECT *, MONTH(rental_date), WEEKDAY(rental_date)
FROM rental
LIMIT 20;

--  2.3
SELECT *,
    CASE
        WHEN WEEKDAY(rental_date) < 5 THEN "workday"
        WHEN WEEKDAY(rental_date) >= 5 THEN "weekend"
    END
FROM rental;

--  3
SELECT title, COALESCE(rental_duration, "NOT AVAILABLE") --  Interessant
FROM film;

--  4
SELECT CONCAT(first_name,last_name,LEFT(email,3))
FROM customer;
USE sakila;

-- CHALENGE 2 --
--  1.1 The total number of films that have been released.
SELECT COUNT(*)
FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*)
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, and sort the results in descending order of the number of films. This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.
SELECT rating, COUNT(*)
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

-- 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2)
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

-- 3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2)
FROM film
GROUP BY rating
HAVING AVG(length) >= 120
ORDER BY AVG(length) DESC;

-- 4 Determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;



