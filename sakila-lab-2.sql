USE SAKILA;

SELECT
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM
    film;
    
SELECT
    -- Calculate average duration in minutes
    AVG(length) AS avg_minutes,
    -- Calculate hours: FLOOR(Average Minutes / 60)
    FLOOR(AVG(length) / 60) AS avg_hours,
    -- Calculate remaining minutes: MOD(Average Minutes, 60)
    MOD(ROUND(AVG(length)), 60) AS avg_remaining_minutes
FROM
    film;
    
    SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM
    rental;
    
    SELECT
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    -- Extract the month name from rental_date
    MONTH(rental_date) AS rental_month,
    -- Extract the full weekday name
    DAYNAME(rental_date) AS rental_weekday
FROM
    rental
LIMIT 20;

SELECT
    *,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- 1=Sunday, 7=Saturday
        ELSE 'workday'
    END AS DAY_TYPE
FROM
    rental
LIMIT 20; -- Limiting to 20 rows for review

SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration_status
FROM
    film
ORDER BY
    title ASC;
    
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM
    customer
ORDER BY
    last_name ASC;
    
    
SELECT
    COUNT(film_id) AS total_films
FROM
    film;
    
SELECT
    rating,
    COUNT(film_id) AS film_count
FROM
    film
GROUP BY
    rating;
    
SELECT
    rating,
    COUNT(film_id) AS film_count
FROM
    film
GROUP BY
    rating
ORDER BY
    film_count DESC;
    
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
    film
GROUP BY
    rating
ORDER BY
    mean_duration DESC;
    
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
    film
GROUP BY
    rating
HAVING
    AVG(length) > 120
ORDER BY
    mean_duration DESC;
    
SELECT
    last_name,
    COUNT(*) AS name_count
FROM
    actor
GROUP BY
    last_name
HAVING
    COUNT(*) = 1
ORDER BY
    last_name;
    
