USE sakila;
-- Challenge 1
-- number 1.1
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM sakila.film;
-- number 1.2
SELECT FLOOR(AVG(length) / 60) AS avg_duration_hours, FLOOR(AVG(length) % 60) AS avg_duration_minutes FROM film;
-- number 2.1
SELECT DISTINCT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating FROM rental;
-- number 2.2
SELECT rental_id, rental_date, inventory_id, customer_id, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_day FROM sakila.rental LIMIT 20;
-- number 3
SELECT title, IFNULL(CAST(rental_duration AS CHAR), 'Not available') FROM sakila.film ORDER BY title ASC;

-- Challenge 2
-- number 1.1
SELECT COUNT(*) AS total_number_of_films FROM sakila.film;
-- number 1.2
SELECT COUNT(*) AS count, rating FROM sakila.film GROUP BY rating;
-- number 1.3
SELECT COUNT(*) AS count, rating FROM sakila.film GROUP BY rating ORDER BY count DESC;

-- number 2.1
SELECT AVG(length) AS average_length, rating FROM sakila.film GROUP BY rating ORDER BY average_length DESC;
-- number 2.2
SELECT AVG(length) AS average_length, rating FROM sakila.film GROUP BY rating HAVING average_length > 120 ORDER BY average_length DESC;