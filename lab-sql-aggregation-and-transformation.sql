USE sakila;

-- Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,  -- Find the maximum movie duration and label it as max_duration
    MIN(length) AS min_duration   -- Find the minimum movie duration and label it as min_duration
FROM 
    film;  -- From the film table

-- Express the average movie duration in hours and minutes
SELECT
    FLOOR(AVG(length) / 60) AS hours,    -- Calculate the average length, convert it to hours, and label it as hours
    FLOOR(AVG(length) % 60) AS minutes   -- Calculate the remaining minutes and label it as minutes
FROM
    film;  -- From the film table
    
SELECT
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days 
FROM
	rental;
  SELECT 
    rental_id,  -- Rental ID
    rental_date,  -- Rental Date
    MONTH(rental_date) AS rental_month,  -- Month of the rental
    DATE_FORMAT(rental_date, '%W') AS rental_weekday  -- Weekday of the rental using DATE_FORMAT
FROM 
    rental  -- From the rental table
LIMIT 20;  

SELECT 
	title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM
	film 
ORDER BY
	title asc;
    
SELECT 
	COUNT(*) AS total_films
FROM 
	film;
SELECT
	rating,
    COUNT(*) AS number_of_films
FROM
	film
GROUP BY
	rating
ORDER BY 
	number_of_films DESC;
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
    COUNT(*) AS number_of_films
FROM
	film
GROUP BY
	rating
ORDER BY 
	number_of_films DESC;
SELECT 
	rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
	film
GROUP BY 
	rating
HAVING 
	AVG(LENGTH) > 120
ORDER BY 
	mean_duration DESC;
