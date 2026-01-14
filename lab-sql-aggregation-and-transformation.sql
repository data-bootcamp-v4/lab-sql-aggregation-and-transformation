USE sakila;
# You need to use SQL built-in functions to gain insights relating to the duration of movies:
# Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;

# Express the average movie duration in hours and minutes. Don't use decimals.

SELECT 
CONCAT(FLOOR(AVG(length)/60), ' hours ', ROUND(AVG(length) - 60, 0), ' minutes ') AS average_duration
FROM film;

# You need to gain insights related to rental dates:

# Calculate the number of days that the company has been operating.

SELECT DATEDIFF( max(rental_date), min(rental_date)) AS total_days
from rental;

# Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT MONTH(rental_date) AS month, DAYOFWEEK(rental_date) as day_of_week
FROM rental
LIMIT 20;

# You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
# If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT film_id , title,  IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film ;


# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
# The total number of films that have been released.

SELECT COUNT(film_id) AS total_films
FROM film;

# The number of films for each rating.

SELECT rating, COUNT(film_id) AS total_films
FROM film 
GROUP BY rating;

# The number of films for each rating, sorting the results in descending order of the number of films. 
# This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT rating, COUNT(film_id) AS total_films
FROM film 
GROUP BY rating
ORDER BY total_films DESC;



# Using the film table, determine:
# The mean film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

#  Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;