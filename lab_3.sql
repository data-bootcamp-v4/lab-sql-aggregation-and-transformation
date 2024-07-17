USE sakila;

-- Challenge 1
-- 1
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration
FROM film;
-- 1.2
SELECT 
    FLOOR(AVG(length)) AS average_length_minutes,
    FLOOR(AVG(length) / 60) AS average_hours,
    FLOOR(AVG(length) % 60) AS average_minutes
FROM 
    film;
-- 2.1
SELECT 
	earliest_date, -- select this from subquery results
	latest_date, 
	DATEDIFF(latest_date, earliest_date) AS duration
FROM( -- source of the data
	SELECT
		MIN(rental_date) AS earliest_date,
		MAX(rental_date) AS latest_date
	FROM rental
) AS subquery; -- defines subquery 

-- 2.2
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS month, -- extracts month
	DATE_FORMAT(rental_date, '%W') AS weekday, -- formats rental_date to return name of weekday 
    inventory_id,
    customer_id, 
    return_date,
    staff_Id,
    last_update,
CASE 
        WHEN DAYOFWEEK(rental_date) IN (5, 7) THEN 'Weekend'
        ELSE 'Workday'
    END AS day_type
FROM rental
LIMIT 600;

-- 3
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available')AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 2
-- 1.1
SELECT SUM(film_id) FROM film;
-- 1.2
SELECT 
rating,
SUM(film_id) AS film_count
FROM film
GROUP BY rating;

-- 1.3
SELECT 
rating,
SUM(film_id) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2 
SELECT 
rating,
SUM(film_id) AS film_count,
ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2
SELECT 
rating,
SUM(film_id) AS film_count,
ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING ROUND(AVG(length), 2) > 120; -- filters rows after grouping 

SELECT last_name
FROM actor
GROUP BY last_name
HAVING
COUNT(*) = 1;





