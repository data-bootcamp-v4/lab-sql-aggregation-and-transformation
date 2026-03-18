USE sakila;

#1.1
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

#1.2
SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

--
#2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS Operating_Days
FROM rental;

#2.2
SELECT *,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

#2.3
SELECT *,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

#3.
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#4 BONUS
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

--
#CHALLENGE 2
--

#1.1
SELECT COUNT(film_id)
FROM film;

#1.2
SELECT 
    rating,
    COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating;

#1.3
SELECT
	rating,
    COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

#2.1
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

#2.2
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

#3
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;