#You need to use SQL built-in functions to gain insights relating to the duration of movies:
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;
SELECT max(length) AS max_duration, min(length) AS min_duration
FROM film;
#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(AVG(length)) AS minutes
FROM film;

SELECT ROUND((AVG(length)/60)) AS hours
FROM film;

#You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(max(rental_date),min(rental_date))
FROM rental;
#Hint: To do this, use the rental table, and the DATEDIFF() function to 
#subtract the earliest date in the rental_date column from the latest date.
#2.2 Retrieve rental information and add two additional columns to show the 
#month and weekday of the rental. Return 20 rows of results.
SELECT rental_date,
DATE(rental_date) AS rental_day,
MONTH(rental_date) AS rental_month
FROM rental
LIMIT 20;
#3.You need to ensure that customers can easily access information about the movie collection. 
#To achieve this, retrieve the film titles and their rental duration. 
#If any rental duration value is NULL, replace it with the string 'Not Available'. 
#Sort the results of the film title in ascending order.
#Please note that even if there are currently no null values in the rental duration column, 
#the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.
SELECT DISTINCT title, rental_duration,
  CASE 
    WHEN rental_duration IS NULL THEN 'Not Available'
    ELSE 'Available'
  END AS availability_status
FROM film
ORDER BY title ASC;

#Challenge2
# Using the film table, determine:
#1.1 The total number of films that have been released.
SELECT COUNT(film_id)
FROM film;
#1.2 The number of films for each rating.#1.3 The number of films for each rating, 
#sorting the results in descending order of the number of films. This will help you to better understand 
#the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT COUNT(film_id) AS num_films , rating
FROM film
GROUP BY (rating)
ORDER BY num_films DESC;
#Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT ROUND(avg(length),2) AS mean_duration, rating
FROM film
GROUP BY(rating)
ORDER BY mean_duration DESC;
#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer 
#longer movies.
SELECT (avg(length)) AS mean_duration, rating
FROM film
GROUP BY(rating)
HAVING mean_duration >120;