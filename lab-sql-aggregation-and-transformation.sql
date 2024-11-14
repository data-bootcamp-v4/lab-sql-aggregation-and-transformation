-- Lab | SQL Data Aggregation and Transformation
USE sakila;

-- CHALLENGE 1
-- 1
-- 1.1
SELECT MAX(length) FROM sakila.film;
SELECT MIN(length) FROM sakila.film;
-- 1.2
SELECT FLOOR(AVG(length / 60)) AS Average_hours FROM sakila.film;
SELECT FLOOR(AVG(length)) AS Average_Minutes FROM sakila.film;

-- 2
-- 2.1
SELECT rental_date FROM sakila.rental;
SELECT DATEDIFF (MAX(rental_date),MIN(rental_date)) FROM sakila.rental;

-- 2.2
SELECT * FROM sakila.rental;
select *, date_format(convert(rental_date,date), "%M") as rental_month, date_format(convert(rental_date,date), "%d") as rental_day
from sakila.rental
limit 20;

-- 2.3
SELECT 
    *,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' 
        ELSE 'workday' 
    END AS DAY_TYPE
FROM 
    sakila.rental;
    
-- 3
SELECT title, 
IFNULL (rental_duration, "Not Available") AS rental_duration
FROM sakila.film
ORDER BY title ASC;

-- 4 BONUS

-- CHALLENGE 2
-- 1
-- 1.1
SELECT * FROM sakila.film;
SELECT COUNT(film_id) FROM sakila.film;

-- 1.2
SELECT rating, COUNT(film_id) AS film_count
FROM sakila.film
GROUP BY (rating);

-- 1.3
SELECT rating, COUNT(film_id) AS film_count
FROM sakila.film
GROUP BY (rating)
ORDER BY film_count DESC;

-- 2
-- 2.1
SELECT rating, ROUND(AVG(length), 2) as mean_length
FROM sakila.film
GROUP BY (rating)
ORDER BY mean_length DESC;

-- 2.2
SELECT rating, ROUND(AVG(length)/60, 2) as hr_mean_length
FROM sakila.film
GROUP BY (rating)
HAVING hr_mean_length > 2
ORDER BY hr_mean_length DESC;

-- 3
SELECT last_name, COUNT(last_name) AS last_name_count
FROM sakila.actor
GROUP BY (last_name)
HAVING last_name_count = 1
ORDER BY last_name;


