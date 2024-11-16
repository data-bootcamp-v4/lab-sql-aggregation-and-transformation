-- Challenge 1
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM 
    film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM 
    film;

-- Challenge 2
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM 
    rental;

SELECT 
    rental_id, 
    rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

SELECT 
    rental_id, 
    rental_date, 
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM 
    rental
LIMIT 20;

-- Challenge 3
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;

-- Bonus Chalenge

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    LEFT(email, 3) AS email_prefix
FROM 
    customer
ORDER BY 
    last_name ASC;

