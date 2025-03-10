USE sakila;

SELECT 
    MIN(f.rental_duration) AS min_duration,
    MAX(f.rental_duration) AS max_duration
FROM 
    film f;

SELECT 
    CONCAT(
        FLOOR(AVG(f.length) / 60), ' hours ', 
        ROUND(AVG(f.length) % 60), ' minutes'
    ) AS average_duration
FROM 
    film f;

SELECT 
    DATEDIFF(MAX(r.rental_date), MIN(r.rental_date)) AS days_operating
FROM 
    rental r;

SELECT 
    r.rental_id,
    r.rental_date,
    MONTH(r.rental_date) AS rental_month,
    DAYOFWEEK(r.rental_date) AS rental_weekday
FROM 
    rental r
LIMIT 20;

SELECT 
    r.rental_id,
    r.rental_date,
    CASE 
        WHEN DAYOFWEEK(r.rental_date) IN (1, 7) THEN 'weekend' 
        ELSE 'workday' 
    END AS day_type
FROM 
    rental r
LIMIT 20;

SELECT 
    f.title, 
    CASE
        WHEN r.return_date IS NULL THEN 'Not Available'
        ELSE DATEDIFF(r.return_date, r.rental_date) 
    END AS rental_duration_days
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id
ORDER BY 
    f.title ASC;

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    LEFT(c.email, 3) AS email_prefix
FROM 
    customer c
ORDER BY 
    c.last_name ASC;
    
SELECT COUNT(*) AS total_films
FROM film;

SELECT 
    rating, COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating;

SELECT 
    rating, COUNT(*) AS number_of_films
FROM    
    film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;

SELECT 
    rating, ROUND(AVG(length), 2) AS average_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    average_duration DESC;

SELECT 
    rating, ROUND(AVG(length), 2) AS average_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    average_duration > 120;

SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;