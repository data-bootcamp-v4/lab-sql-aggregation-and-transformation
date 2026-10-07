USE sakila;

#Challenge 1
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

DESCRIBE film;

SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film; 
#Max duration: 185: Mininum duration: 46

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals

SELECT
    FLOOR(AVG(length) / 60) AS hours, #FLOOR always round down to get 1 hour
    ROUND(AVG(length) % 60) AS minutes 
FROM film;

#The average is 115,27 minutes we use FLOOR to round it down for hours (1 hour) and ROUND for minutes
#1 hour 55 minutes

#2  
#2.1. Calculate the number of days that the company has been operating. 

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental; 
#266 days operating

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of rental

DESCRIBE rental;

SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

#3
#Retrieve the film titles and their rental duration. 
#If any rental duration value is NULL, replace it with the string 'Not Available'

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#Challenge 2

#Using the film table, determine:

#1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM film; #1000 films

 #1.2 The number of films for each rating.

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

 #1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

#.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;
