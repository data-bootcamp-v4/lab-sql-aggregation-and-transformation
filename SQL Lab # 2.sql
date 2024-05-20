-- # SQL LAB 2

USE sakila;


-- CHALLENGE #1 
# 1 You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT
    MIN(length) AS "min_duration",
    MAX(length) AS "max_duration"
FROM film;

-- Express the average movie duration in hours and minutes. Don't use decimals.
SELECT length
FROM film;

WITH AvgLength AS (
    SELECT AVG(length) AS avg_length
    FROM film
)
SELECT 
    FLOOR(avg_length / 60) AS hours,
    FLOOR(avg_length % 60) AS minutes
FROM AvgLength;


-- #2 You need to gain insights related to rental dates:

-- Calculate the number of days that the company has been operating.

SELECT datediff( max(rental_date), min(rental_date))
FROM rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT 
    rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM 
    rental
LIMIT 20;

-- # 3 You need to ensure that customers can easily access information about the movie collection. 

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;
    
    -- CHALLENGE # 2
    
    -- # 1 Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine: 
    
    -- The total number of films that have been released.
    
    SELECT 
    COUNT(release_year)
    FROM film;

-- The number of films for each rating.

SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating;

-- The number of films for each rating, sorting the results in descending order 

SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;
    
    -- # 2 Using the film table.
    
    -- The mean film duration for each rating, and sorting the results in descending order of the mean duration.
    
    SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;

     -- Identify which ratings have a mean duration of over two hours in order
     
     SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    mean_duration > 120
ORDER BY 
    mean_duration DESC;

     




