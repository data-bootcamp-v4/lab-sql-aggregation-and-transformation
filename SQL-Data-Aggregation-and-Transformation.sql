USE sakila;

-- Challenge 1

-- 1.1
SELECT 
	MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- 1.2
SELECT
	FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length)% 60 ) AS avg_minutes
FROM film;

-- 2.1 
SELECT
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;


-- 2.2
Select
	rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_mounth,
    DAYNAME(rental_date) AS  rental_weekday
FROM rental
LIMIT 20;

-- 2.3
SELECT
	rental_id,
    rental_date,
    DAYNAME(rental_date),
    
    CASE
		WHEN DAYNAME(rental_date) IN ('Saturdat', 'Sunday') THEN 'Weekend'
        ELSE 'Workday'
	END AS day_type
FROM rental
LIMIT 20;

-- 3
SELECT
	title,
    IFNULL(rental_duration, 'NOT AVAILABLE') as rental_duration
FROM film
ORDER BY title ASC;     


-- Challenge 2 

-- 1.1
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 1.3
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2.1
SELECT
	rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2
SELECT
	rating,
    ROUND(AVG(length),2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;








