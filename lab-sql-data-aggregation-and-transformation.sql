USE sakila;

--
-- CHALLENGE 1
--

# 1.1
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM film;

# 1.2
SELECT AVG(length), 
	ROUND(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

# 2.1
SELECT MIN(CONVERT(rental_date, DATE)) FROM rental;

SELECT MIN(rental_date) AS earliest_date FROM rental;

SELECT DATEDIFF(CURDATE(), MIN(rental_date)) AS operating_days FROM rental;

# 2.2
SELECT *, 
	DATE_FORMAT(CONVERT(rental_date, DATE), "%b") AS month,
    DATE_FORMAT(CONVERT(rental_date, DATE), "%a") AS weekday
FROM rental
LIMIT 20;

# 3
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration FROM film;

#4
SELECT first_name, last_name, CONCAT(first_name,' ', last_name) AS full_name, LEFT(email, 3) AS email_shorten FROM customer
ORDER BY last_name ASC;

--
-- CHALLENGE 2
--

# 1.1
SELECT COUNT(*) FROM film
WHERE release_year IS NOT NULL;

# 1.2
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

# 1.3
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

# 2.1
SELECT rating, AVG(length) AS length_mean
FROM film
GROUP BY rating
ORDER BY length_mean DESC;

# 2.2
SELECT rating, 
	AVG(length) AS length_mean
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY length_mean DESC;

# 3
SELECT last_name 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;


