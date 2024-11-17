USE sakila;
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    MOD(AVG(length), 60) AS avg_minutes
FROM film;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
SELECT * FROM rental;
SELECT 
    *,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM
    rental
LIMIT 20;
SELECT 
    *,
    DAYNAME(rental_date) AS day_type,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Workday'
    END AS day_type
FROM rental;
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM
    film
ORDER BY 
    title ASC;
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM
    customer
ORDER BY 
    last_name ASC;
SELECT COUNT(*) FROM film;
SELECT 
    rating,
    COUNT(*) AS total_count
FROM
    film
GROUP BY
    rating;
SELECT 
    rating,
    COUNT(*) AS film_count
FROM
    film
GROUP BY
    rating
ORDER BY 
    film_count DESC;
SELECT 
    rating,
    COUNT(*) AS total_count,
    ROUND(AVG(length),2) AS film_duration
FROM
    film
GROUP BY
    rating
ORDER BY 
    film_duration DESC;
SELECT 
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM
    film
GROUP BY
    rating
HAVING
    AVG(length) > 120
ORDER BY
    average_duration DESC;

SELECT 
    last_name
FROM
    actor
GROUP BY
    last_name
HAVING 
    COUNT(last_name) = 1;





