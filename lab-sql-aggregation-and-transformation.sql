USE sakila;

-- 1
-- 1-1
SELECT MAX(length) AS max_duration
FROM  film; 

SELECT MIN(length) AS min_duration
FROM film; 

-- 1.2

SELECT FLOOR(AVG(length)/60) AS hours, ROUND(AVG(length)%60) AS mins
FROM film; 

SELECT CONCAT( FLOOR(AVG(length)/60), ' hour ', ROUND(AVG(length)%60), ' minutes') AS duration
FROM film; 

-- 2
-- 2.1
SELECT DATEDIFF(curdate(),MIN(rental_date))
FROM rental; 

-- 2.2

SELECT *, month(rental_date), weekday(rental_date)
FROM rental; 

-- 2.3 

SELECT *, 
CASE 
WHEN weekday(rental_date) <= 5 THEN 'workday'
ELSE 'weekend'
END AS DAY_TYPE
FROM rental; 

-- 3
SELECT title, IFNULL(rental_duration, 'Not available') AS rental_duration
FROM film
ORDER BY title; 

-- 4

SELECT CONCAT(first_name, ' ', last_name) AS full_name, LEFT(email, 3)AS email_prefix
FROM customer
ORDER BY last_name;




-- CHALLENGE 2

-- 1
-- 1.1
SELECT COUNT(DISTINCT title)
FROM film;


-- 1.2
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating;

-- 1.3
SELECT rating, COUNT(rating) AS number_films
FROM film
GROUP BY rating
ORDER BY number_films DESC;

-- 2
-- 2.1

SELECT DISTINCT rating, ROUND(AVG(length),2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

-- 2.2

SELECT DISTINCT rating, ROUND(AVG(length),2) AS avg_length
FROM film
GROUP BY rating
HAVING avg_length > 120;

-- 3

SELECT last_name, COUNT(last_name) AS repetition
FROM actor
GROUP BY last_name 
HAVING repetition = 1;


