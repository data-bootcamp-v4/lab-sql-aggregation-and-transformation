USE sakila;


SELECT MAX(length) AS max_duration FROM film;
SELECT MIN(length) AS min_duration FROM film;

SELECT ROUND(AVG(length)) AS rounded_avg_length FROM film;

SELECT 
	FLOOR (AVG(length) / 60) AS hours,
    MOD(ROUND(AVG(length)), 60) AS minutes
FROM film;

SELECT DATEDIFF(
    (SELECT MAX(rental_date) FROM rental), 
    (SELECT MIN(rental_date) FROM rental)
) AS rental_days_difference;

SELECT * from rental;

-- EXTRACT WEEKDAY and MONTH:

SELECT rental.*, 
       DATE_FORMAT(rental_date, '%M') AS month,
       CASE 
           WHEN DAYOFWEEK(rental_date) = 1 THEN "Sunday"
           WHEN DAYOFWEEK(rental_date) = 2 THEN "Monday"
           WHEN DAYOFWEEK(rental_date) = 3 THEN "Tuesday"
           WHEN DAYOFWEEK(rental_date) = 4 THEN "Wednesday"
           WHEN DAYOFWEEK(rental_date) = 5 THEN "Thursday"
           WHEN DAYOFWEEK(rental_date) = 6 THEN "Friday"
           WHEN DAYOFWEEK(rental_date) = 7 THEN "Saturday"
       END AS weekday
FROM rental
LIMIT 20;


SELECT rental.*, 
	CASE 
		WHEN DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7 THEN "weekend"
        ELSE "weekday"
	END AS day_type
FROM rental
HAVING day_type = "weekday"
ORDER BY rental_date ASC
LIMIT 20;

-- film titles and their rental duration:

SELECT 
	title,
	rental_date, 
	return_date, 
	return_date - rental_date AS rental_duration,
	CASE
		WHEN return_date IS NOT NULL THEN return_date - rental_date
		ELSE 'Not Available'
	END AS rental_duration
FROM film, rental;

-- Challenge 2

-- 
SELECT COUNT(title) from film; 

SELECT COUNT(title), rating from film
group by rating;

SELECT COUNT(title), rating from film
group by rating
ORDER BY COUNT(title) DESC;

SELECT FORMAT(AVG(length),2) AS mean_length, rating 
FROM film
GROUP BY rating
ORDER BY mean_length DESC;














        





