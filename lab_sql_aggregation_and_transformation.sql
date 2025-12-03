USE sakila; 

-- Challenge 1
-- 1. 
-- 1.1
SELECT MAX(length) AS max_duration,
	MIN(length) AS min_duration
FROM film;

-- 1.2
SELECT FLOOR(AVG(length)/ 60) AS avg_hours,
	ROUND(AVG(length) - 60 * FLOOR(AVG(length)/ 60)) AS avg_minutes
FROM film;

-- 2. 
-- 2.1
SELECT MIN(rental_date) AS min_date,
	MAX(rental_date) AS max_date
FROM rental; 

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2
SELECT *,
	MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3
SELECT *, 
	CASE 
		WHEN DAYNAME(rental_date) NOT IN ('Saturday', 'Sunday') THEN 'workday'
        ELSE 'weekend'
	END AS day_type
FROM rental;

-- 3. 
-- No hay ningún null value, pero igualmente lo hacemos por si acaso!
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC; 

-- 4. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	LEFT(email, 3) AS email_perfix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1. 
-- 1.1 
SELECT COUNT(film_id)
FROM film
WHERE release_year IS NOT NULL;

-- 1.2 
SELECT DISTINCT rating, COUNT(rating) AS count_rating
FROM film
GROUP BY rating;

-- 1.3 
SELECT DISTINCT rating, COUNT(rating) AS count_rating
FROM film
GROUP BY rating
ORDER BY count_rating DESC;

-- 2. 
-- 2.1
SELECT DISTINCT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 
SELECT DISTINCT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film
GROUP BY rating
HAVING avg_duration > 120;

-- 3. 
SELECT last_name, COUNT(last_name) AS count_repeated_last_name
FROM actor
GROUP BY last_name;


