-- Challenge 1 

-- 1.1 Shortest and longest movie durations
SELECT max(length) as max_duration, min(length) as min_duration FROM sakila.film; 

-- 1.2  Express average movie duration in hours & minutes (no decimals)
SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes FROM sakila.film; 

-- 2.1 Number of days the company has been operating
SELECT DATEDIFF(MAX(rental_date ), MIN (rental_date)) AS days_operation FROM sakila.rental;  

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, MONTHNAME (rental_date) AS rental_month, DAYNAME (rental_date) AS rental_weekday FROM sakila.rental LIMIT 20;

-- 3 You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, 'NOT Available') as Rental_Duration FROM sakila.film ORDER BY rental_duration ASC;

-- Challenge 2, 1.1-1.3 
-- 1.1
SELECT COUNT(*) AS total_films FROM sakila.film;

-- 1.2 
SELECT rating, COUNT(*) AS number_of_films FROM sakila.film GROUP BY rating;

-- 1.3 
SELECT rating, count(rating) as count FROM sakila.film GROUP BY rating ORDER BY RIGHT(rating,2) DESC; 

-- Challenge 2, 2.1-2.3
-- 2.1 
SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM sakila.film GROUP BY rating ORDER BY mean_duration DESC;

-- 2.2 
SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM sakila.film GROUP BY rating HAVING mean_duration > 120;

-- 2.3 
SELECT ROUND(AVG(length),2) as length, rating FROM sakila.film GROUP BY rating ORDER BY rating DESC; 


