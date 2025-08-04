-- 1.1

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM sakila.film;

-- 1.2

SELECT FLOOR(AVG(length)/60) AS avg_hours,
FLOOR(AVG(length)) AS avg_minutes
FROM sakila.film;

-- 2.1

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS number_of_days FROM rental;

-- 2.2

SELECT *, MONTHNAME(rental_date) AS r_month, DAYNAME(rental_date) FROM sakila.rental
LIMIT 20;

-- 2.3

SELECT *,
CASE 
WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
ELSE 'workday'
END AS day_type
FROM sakila.rental;

-- 3

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration FROM sakila.film
ORDER BY title;

-- 4

SELECT concat(first_name, " ", last_name) AS name_customer, LEFT(email,3) AS email_prefix from sakila.customer;

-- CHALLENGE 2

-- 1.1

SELECT COUNT(film_id) AS num_film FROM sakila.film;

-- 1.2

SELECT COUNT(film_id) AS num_film, rating FROM sakila.film
GROUP BY rating;

-- 1.3

SELECT COUNT(film_id) AS num_film, rating FROM sakila.film
GROUP BY rating
ORDER BY num_film DESC;

-- 2

-- 2.1
SELECT ROUND(AVG(length),2) AS l_film, rating FROM sakila.film
GROUP BY rating
ORDER BY l_film DESC;

-- 2.2

SELECT length FROM sakila.film;
SELECT ROUND(AVG(length),2) AS l_film, rating FROM sakila.film
GROUP BY rating
ORDER BY l_film DESC;

-- 2.3

SELECT ROUND(AVG(length),2) AS l_film, rating FROM sakila.film
GROUP BY rating
HAVING l_film > 120; 

-- 3

SELECT last_name, COUNT(last_name) AS num_last_name FROM sakila.actor
GROUP BY last_name
HAVING num_last_name = 1;

