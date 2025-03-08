USE sakila;

-- CHALLENGE 1

-- 1.1 .

SELECT MIN(length) AS min_duration,
 MAX(length) AS max_duration 
 FROM film;

-- 1.2. 

SELECT FLOOR(AVG(length) / 60) AS hours, 
FLOOR(MOD(AVG(length), 60)) AS minutes 
FROM film;

-- 2.1 
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
 FROM rental;

-- 2.2 

SELECT rental_date,
 DATE_FORMAT(rental_date, '%M') AS month, 
 DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;

-- 2.3  

SELECT 	rental_date, 
		DATE_FORMAT(rental_date, '%M') AS month, 
		DAYNAME(rental_date) AS weekday,
		CASE WHEN WEEKDAY(rental_date) BETWEEN 0 AND 4 THEN 'yes' ELSE 'no' END AS weekday
FROM rental
LIMIT 20;

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT 	title,
		CASE WHEN rental_duration IS NULL THEN 'Not Available'
        ELSE rental_duration 
        END AS rental_duration,
        IFNULL(rental_duration, 'Not Available')
FROM film;

-- CHALLENGE 2
-- 1.1 The total number of films that have been released.

SELECT COUNT(DISTINCT(film_id)) AS total_releases 
FROM film;

-- 1.2 

SELECT COUNT(*) AS number_of_films, rating
FROM film
GROUP BY rating;

-- 1.3  

SELECT COUNT(*) AS number_of_films, rating
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

-- 2.1  

SELECT 	rating,
		ROUND(AVG(length) , 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

-- 2.2 

SELECT rating, COUNT(rating) AS number_of_films
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

