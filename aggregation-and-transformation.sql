USE sakila;
-- 1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) FROM film;
SELECT MIN(length) FROM film;  

-- Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    MOD(AVG(length), 60) AS minutes
FROM 
    film;

-- 2 Calculate the number of days that the company has been operating
SELECT 
    DATEDIFF(
        (SELECT MAX(rental_date) FROM rental), 
        (SELECT MIN(rental_date) FROM rental)
    ) AS days_operating;   
    
-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM 
    rental
LIMIT 20;  

-- 3 Retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;  
    
-- 4 retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM 
    customer
ORDER BY 
    last_name ASC;  
    
-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1 The total number of films that have been released.
SELECT 
    COUNT(*) AS total_films
FROM 
    film;
    
-- The number of films for each rating.
SELECT 
    rating,
    COUNT(*) AS film_count
FROM 
    film
GROUP BY 
    rating; 
    
-- The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings
SELECT 
    rating,
    COUNT(*) AS film_count
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    film_count DESC;  
    
-- Using the film table, determine:
-- 2 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;

-- Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
    rating
FROM 
    (
        SELECT 
            rating,
            AVG(length) AS mean_duration
        FROM 
            film
        GROUP BY 
            rating
    ) AS avg_duration
WHERE 
    mean_duration > 120;  
    
    
  