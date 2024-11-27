USE sakila;



-- challange 1
-- 1.1 determine the shortest and longest movie durations
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;



-- 1.2 the average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    MOD(AVG(length), 60) AS avg_minutes
FROM film;


-- 2.1 calculate the number of days that the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;


-- 2.2 rental information
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;


-- 2.3 Bonus:
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;


-- 3.0 to retrieve the film titles and their rental duration
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- bonus
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- challange 2
-- 1.1 total number of films that have been released
SELECT COUNT(*) AS total_films_released
FROM film;


-- 1.2 -  1.3  the number of films for each rating by descendig order
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;


-- 2.1 the mean film duration for each rating 
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;


-- 2.2 ratings with a mean duration of over 2h 
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;


-- bonus determine which last names are not repeated in the table actor
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;










--
