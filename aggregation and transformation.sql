USE sakila;
-- Determine the shortest and longest movie durations
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration
FROM 
    film;
SHOW TABLES;  
DESCRIBE film;  

-- Express the Average Movie Duration in Hours and Minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60) AS avg_minutes
FROM 
    film;
    
--  Calculate the Number of Days the Company Has Been Operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM 
    rental;
    
-- Retrieve Rental Information with Month and Weekday Columns
SELECT 
    rental_id, 
    customer_id, 
    rental_date, 
    MONTH(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- Add a DAY_TYPE Column (Weekend or Workday)
SELECT 
    rental_id, 
    customer_id, 
    rental_date, 
    MONTH(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM 
    rental
LIMIT 20;

-- Retrieve Film Titles and Handle NULL Rental Durations
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;
    
-- Concatenate First and Last Names and Extract Email Prefix
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    SUBSTRING(email, 1, 3) AS email_prefix
FROM 
    customer
ORDER BY 
    last_name ASC;
    
-- Total Number of Films Released
SELECT 
    COUNT(*) AS total_films
FROM 
    film;
    
-- Number of Films for Each Rating
SELECT 
    rating, 
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating;

-- Number of Films for Each Rating Sorted by Count

SELECT 
    rating, 
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;
-- Mean Film Duration for Each Rating

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    avg_duration DESC;
-- Ratings with Mean Duration Over Two Hours

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    AVG(length) > 120;
-- Determine Which Last Names Are Not Repeated

SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;





