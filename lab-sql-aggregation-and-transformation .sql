#Challenge 1 
#1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
use sakila;

SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;

#1.2 Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

#2. You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_active
FROM rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
#Return 20 rows of results.

SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%M') AS month, 
    DATE_FORMAT(rental_date, '%W') AS day_of_week,
    CASE 
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

#3. You need to ensure that customers can easily access information about the movie collection. 
#To achieve this, retrieve the film titles and their rental duration. 
#If any rental duration value is NULL, replace it with the string 'Not Available'. 
#Sort the results of the film title in ascending order.

SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#Challenge 2
#1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.
SELECT 
    COUNT(*) AS total_films
FROM film;

#1.2 The number of films for each rating.

SELECT 
    rating, 
    COUNT(*) AS film_count
FROM film
GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT 
    rating, 
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;



#2. Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING avg_length > 120;

