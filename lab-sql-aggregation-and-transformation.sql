USE sakila;

-- Challenge 1
-- 1.1
SELECT title, `length` AS max_duration
FROM film
WHERE `length` = (SELECT MAX(length) FROM film)
UNION
SELECT title, `length` AS min_duration
FROM film
WHERE `length` = (SELECT MIN(length) FROM film);
-- 1.2
SELECT FLOOR(AVG(length)/60) AS avg_hours, FLOOR(AVG(length)) AS avg_minutes
FROM film;
-- 2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental;
-- 2.2 
SELECT *, month(rental_date) AS rental_month, day(rental_date) AS rental_day 
FROM rental;
-- 2.3
SELECT *, month(rental_date) AS rental_month, day(rental_date) AS rental_day,
	CASE
		WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
	END AS DateType
FROM rental
LIMIT 20;
-- 3
select title, IFNULL(rental_duration,'Not Available')
from film
ORDER BY title asc;
-- 4
SELECT concat(first_name,' ',last_name) AS customer_name, LEFT(email,3) AS email_letters
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1
SELECT count(title)
FROM film
WHERE release_year IS NOT NULL;
-- 1.2
SELECT rating, count(distinct title)
FROM film
GROUP BY rating;
-- 1.3
SELECT rating, count(distinct title) AS number_titles
FROM film
GROUP BY rating
ORDER BY number_titles DESC;
-- 2.1
SELECT rating, round(AVG(length),2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;
-- 2.2
SELECT rating, round(AVG(length),2) AS avg_length
FROM film
GROUP BY rating
HAVING avg_length > 120
ORDER BY avg_length DESC;
-- 3
SELECT last_name, count(distinct first_name) AS unique_count
FROM actor
GROUP BY last_name
HAVING unique_count = 1;




