SELECT MIN(length) FROM film AS min_duration;
SELECT MAX(length) FROM film AS max_duration; 
SELECT 
	FLOOR(AVG(length)/60) as avg_len_hours, -- FLOOR to remove decimals
	FLOOR(MOD(AVG(length), 60)) as avg_len_minutes -- MOD returns the remainder of the division
FROM film; -- 1

SELECT 
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS company_op
FROM rental; 
SELECT *,
	MONTH(rental.rental_date) AS rental_month,
    DAYNAME(rental.rental_date) AS rental_day
FROM rental;
SELECT *,
	MONTH(rental.rental_date) AS rental_month,
    DAYNAME(rental.rental_date) AS rental_weekday,
	CASE
		WHEN DAYOFWEEK(rental.rental_date) IN (1,7) THEN "weekend"
		ELSE "workday"
	END AS day_type
FROM rental
LIMIT 20; -- 2

SELECT 
	title,
    IFNULL(rental_duration, "Not Available") AS rental_duration
FROM film
ORDER BY title ASC; -- 3

SELECT 
	CONCAT(first_name, " ", last_name) AS customer_full_name,
	SUBSTRING(email, 1, 3) AS email_3
FROM customer; -- 4

-- CHALLENGE 2
SELECT COUNT(release_year) FROM film;
SELECT COUNT(film_id), rating
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

SELECT ROUND(AVG(length), 2) AS avg_length, rating
FROM film
GROUP BY rating  
ORDER BY avg_length DESC;

SELECT ROUND(AVG(length), 2) AS avg_length, rating
FROM film
GROUP BY rating 
HAVING AVG(length) > 120  
ORDER BY avg_length DESC;

SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

