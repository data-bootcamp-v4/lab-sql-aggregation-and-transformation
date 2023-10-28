# 1.1

SELECT title, length 
FROM sakila.film
ORDER BY length DESC;

SELECT MAX(length) AS max_duration
FROM sakila.film;

SELECT MIN(length) AS min_duration
FROM sakila.film;

#1.2

SELECT 
	FLOOR(AVG(length)/60) AS average_hours,
    ROUND(AVG(length)%60) AS average_minutes
FROM sakila.film; 

#2.1

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM sakila.rental;

#2.2

SELECT MONTH(rental_date) AS MONTH 
FROM sakila.rental;

SELECT DAYOFWEEK(rental_date) AS weekday 
FROM sakila.rental;

ALTER TABLE sakila.rental
ADD COLUMN rental_month INT;

SET SQL_SAFE_UPDATES = 0;

UPDATE sakila.rental
SET rental_month = MONTH(rental_date);

ALTER TABLE sakila.rental
ADD COLUMN rental_day INT;

UPDATE sakila.rental
SET rental_day = WEEKDAY(rental_date);

SELECT *
FROM sakila.rental
LIMIT 20;

# 2.3

ALTER TABLE sakila.rental
ADD COLUMN Day_type VARCHAR(10);

UPDATE sakila.rental 
	SET day_type = CASE WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weeked'
		ELSE 'workday'
	END;
    
#3 

UPDATE sakila.film
SET rental_duration = COALESCE(rental_duration, 'Not Available');

SELECT title, rental_duration
FROM sakila.film
ORDER BY film.title ASC;

#4

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       SUBSTRING(email, 1, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name ASC;


#Challenge 2 

# 1.1

SELECT COUNT(title)
FROM sakila.film
WHERE release_year < '2023-07-01';

#1.2 
SELECT  rating, COUNT(title)
FROM sakila.film
GROUP BY rating;

#1.3 

SELECT  rating, COUNT(title)
FROM sakila.film
GROUP BY rating
ORDER BY COUNT(Title) DESC;

#2

SELECT staff_id, COUNT(rental_id)
FROM sakila.rental
GROUP BY staff_id;

#3.1

SELECT rating, ROUND(AVG(length),2)
FROM sakila.film
GROUP BY rating
ORDER BY AVG(length) DESC;

#3.2
SELECT rating, ROUND(AVG(length),2)
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 2
ORDER BY AVG(length) DESC;


SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) < 2;

