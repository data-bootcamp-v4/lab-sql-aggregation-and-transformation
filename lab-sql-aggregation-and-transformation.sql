USE sakila;

-- Challenge 1
-- 1.1
SELECT title, length
FROM film
WHERE length IN (
    (SELECT MAX(length) FROM film),
    (SELECT MIN(length) FROM film)
)
ORDER BY length;

-- 1.2

SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;


-- 2.1
SELECT
    DATEDIFF(
        MAX(rental_date),
        MIN(rental_date)
    ) AS days_operating
FROM rental;

-- 2.2

SELECT *, 
	DATE_FORMAT(rental_date, '%M') AS rental_month,
	DATE_FORMAT(rental_date, '%a') AS rental_weekday
FROM rental
LIMIT 20;


-- 2.3

SELECT *, 
	DATE_FORMAT(rental_date, '%a') AS rental_weekday,
CASE
	WHEN DATE_FORMAT(rental_date, '%a') IN ('Sat', 'Sun') THEN 'Weekend'
    ELSE 'Weekday'
END AS DAY_TYPE
FROM rental;

-- 3
SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 2
-- 1.1
SELECT COUNT(title)
FROM film;

-- 1.2 
SELECT COUNT(title), rating
FROM film
GROUP BY rating;

-- 1.3
SELECT COUNT(title), rating
FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- 2.1
SELECT ROUND(AVG(length), 2) AS avg_length, rating
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

-- 2.2
SELECT ROUND(AVG(length), 2) AS avg_length, rating,
CASE 
	WHEN ROUND(AVG(length), 2) > 120 THEN '2h+'
    ELSE 'less than 2h'
END AS '2h length'
FROM film
GROUP BY rating
ORDER BY avg_length DESC;