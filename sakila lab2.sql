#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;
SELECT MAX(length) AS max_druration, MIN(length) AS min_duration
FROM film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT AVG(length) AS average_duration
FROM film;
SELECT FORMAT(115.2720, 0);


#2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;


#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT 
rental_id,
rental_date,
inventory_id,
customer_id,
return_date,
staff_id,
DATE_FORMAT(rental_date, '%M') AS month_date, 
DATE_FORMAT(rental_date,'%W' ) AS weeday_date
FROM rental
LIMIT 20;


#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT *,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental;

#3 retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
    FROM film
    ORDER BY title ASC; 

#CHALLENGE 2
#1.1 The total number of films that have been released.
SELECT COUNT(film_id) AS total_films_released
FROM film
WHERE release_year IS NOT NULL;

#1.2 The number of films for each rating.
SELECT rental_rate, COUNT(film_id) AS total_films_each_rating
FROM film
GROUP BY rental_rate;


#1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
#This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rental_rate, COUNT(film_id) AS total_films_each_rating
FROM film
GROUP BY rental_rate
ORDER BY total_films_each_rating ASC;

#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rental_rate, ROUND(AVG(length), 2) AS mean_length_each_rating
FROM film
GROUP BY rental_rate
ORDER BY mean_length_each_rating DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies
SELECT rental_rate, ROUND(AVG(length), 2) AS mean_length_each_rating
FROM film
GROUP BY rental_rate
HAVING ROUND(AVG(length), 2) > 120
ORDER BY mean_length_each_rating DESC;
