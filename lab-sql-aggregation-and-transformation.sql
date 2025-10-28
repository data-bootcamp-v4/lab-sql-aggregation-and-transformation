USE sakila;

SHOW TABLES;

-- answer to 1.1
SELECT max(length) AS max_duration,
	   min(length) AS min_duration
FROM film;

SELECT * FROM film;

-- answer to 1.2
SELECT AVG(length)
FROM film;

SELECT FLOOR(AVG(length)/60) AS hours,
	   ROUND(MOD(AVG(length),60)) AS minutes
FROM film;

-- answer to 2.1
SELECT DATEDIFF(
	(SELECT MAX(rental_date) FROM rental),
    (SELECT MIN(rental_date) FROM rental)) AS operating_days;
    
-- answer 2.2
SELECT *, DATE_FORMAT(rental_date, '%M') AS rental_month,
	   DATE_FORMAT(rental_date, '%a') AS rental_day
 FROM rental
 LIMIT 20;

-- answer 2.3
SELECT *, 
	CASE
		WHEN DATE_FORMAT(rental_date, '%a') = "Sat" OR "Sun" THEN "weekend" 
		ELSE "weekday"
	END AS DAY_TYPE
FROM rental;

-- answer to 3
SELECT title,
	IFNULL(rental_duration, 'Not Available') AS adjusted_rental_duration
FROM film
ORDER BY title ASC;

-- answer to 4
SELECT CONCAT(first_name,' ',last_name) AS full_name,
	   SUBSTRING(email, 1, 3) AS first_3_email
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- answer to 1.1
SELECT count(*) FROM film;

-- answer to 1.2
SELECT rating, count(film_id) AS number_of_films
FROM film
GROUP BY rating;

-- answer 1.3
SELECT rating, count(film_id) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- answer 2.1
SELECT rating, ROUND(AVG(length),2) AS average_length 
FROM film
GROUP BY rating
ORDER BY average_length DESC;

-- answer 2.2
SELECT rating, ROUND(AVG(length),2) AS average_length 
FROM film
GROUP BY rating
HAVING average_length > 120
ORDER BY average_length DESC;

-- answer 3
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

