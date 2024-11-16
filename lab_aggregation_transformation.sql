USE sakila;

-- CHALLENGE 1
-- Determine the shortest and longest movie durations
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM 
    film;

-- Express the average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,         -- Average in hours
    MOD(FLOOR(AVG(length)), 60) AS avg_minutes   -- Remainder in minutes
FROM 
    film;

-- Calculate the number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM 
    rental;
    
-- Retrieve rental information and add month and weekday of the rental
SELECT 
    rental_id, 
    rental_date, 
    customer_id, 
    inventory_id, 
    staff_id, 
    DATEDIFF(return_date, rental_date) AS rental_duration,  -- Optional, to calculate rental duration
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- Bonus: Retrieve rental information and add a DAY_TYPE column
SELECT 
    rental_id, 
    rental_date, 
    customer_id, 
    inventory_id, 
    staff_id, 
    DATEDIFF(return_date, rental_date) AS rental_duration, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- 1 = Sunday, 7 = Saturday
        ELSE 'workday'
    END AS day_type
FROM 
    rental
LIMIT 20;

-- Ensure that customers can easily access information about the movie collection
SELECT 
    f.title AS film_title,
    IFNULL(DATEDIFF(r.return_date, r.rental_date), 'Not Available') AS rental_duration
FROM 
    film f
LEFT JOIN 
    rental r ON f.film_id = r.film_id
ORDER BY 
    f.title ASC;
    
-- CHALLENGE 2
-- Total number of films that have been released
SELECT 
    COUNT(*) AS total_films
FROM 
    film;
    
-- The number of films for each rating
SELECT 
    rating, 
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating;
    
-- The number of films for each rating, sorted in descending order of the number of films
SELECT 
    rating, 
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;
    
-- The mean film duration for each rating, sorted in descending order of the mean duration
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;
    
-- Identify which ratings have a mean duration of over two hours
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
    
-- Determine which last names are not repeated in the actor table
SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;
    



    

    


