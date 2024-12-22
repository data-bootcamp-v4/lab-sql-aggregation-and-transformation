#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE Sakila;
SHOW TABLES;
SELECT * FROM film_list;
SELECT MAX(length) AS max_duration FROM film_list;
SELECT MIN(length) AS min_duration FROM film_list;
#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(length) / 60) AS avg_hours, FLOOR(MOD(AVG(length), 60)) AS avg_minutes   -- Minutes restantes (entier)
FROM film_list;
#2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_date, DATE_FORMAT(rental_date, '%M') AS rental_month,   
DATE_FORMAT(rental_date, '%W') AS rental_weekday 
FROM rental LIMIT 20;
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT DAYNAME(rental_date) AS rental_weekday,  
CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' 
ELSE 'workday' END AS DAY_TYPE             
FROM rental
LIMIT 20;            
#3.retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.   
SELECT 
    title, 
    IFNULL(length, 'Not Available') AS rental_duration
FROM film_list
ORDER BY title ASC;

#1.1 The total number of films that have been released.
SELECT * FROM film_list;
SELECT COUNT(*) AS released_films
FROM film_list;
#1.2 The number of films for each rating.
SELECT rating, COUNT(rating) AS 'number' FROM film_list GROUP BY rating;
#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(rating) AS 'number' FROM film_list GROUP BY rating ORDER BY number DESC;
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
SELECT rating, ROUND(AVG(length),2) AS 'avg_film_duration' FROM film_list GROUP BY rating ORDER BY rating DESC;
#2.2 Identify which ratings have a mean duration of over two hours
SELECT rating, ROUND(AVG(length),2) AS 'avg_film_duration' FROM film_list GROUP BY rating HAVING AVG(length) > 120;
#Bonus: determine which last names are not repeated in the table actor.
SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

