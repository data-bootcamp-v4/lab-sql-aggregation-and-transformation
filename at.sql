-- Challenge 1
-- 1.1 Determine the shortest and longest movie durations
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration
FROM sakila.film;
-- 1.2 Express the average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS average_hours, 
    MOD(FLOOR(AVG(length)), 60) AS average_minutes
FROM sakila.film;

-- 2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM sakila.rental;
-- 2.2 Retrieve rental information and add columns for month and weekday of the rental
SELECT 
    rental_id, 
    rental_date, 
    customer_id, 
    inventory_id, 
    staff_id, 
    MONTH(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add a column for day type (weekend or workday)
SELECT 
    rental_id, 
    rental_date, 
    customer_id, 
    inventory_id, 
    staff_id, 
    MONTH(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM sakila.rental
LIMIT 20;

-- 3
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    sakila.film
ORDER BY 
    title ASC;
    
    -- 4 Bonus
    SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM 
    sakila.customer
ORDER BY 
    last_name ASC;
    
    -- Challenge 2
    -- 1.1 Total number of films that have been released
SELECT COUNT(*) AS total_films_released
FROM sakila.film;
-- 1.2 Number of films for each rating
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating;
-- 1.3 Number of films for each rating, sorting the results in descending order of the number of films
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Mean film duration for each rating, sorted in descending order of the mean duration
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    sakila.film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;
-- 2.2 Identify which ratings have a mean duration of over two hours
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    sakila.film
GROUP BY 
    rating
HAVING 
    mean_duration > 120;

-- Bonus
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;





