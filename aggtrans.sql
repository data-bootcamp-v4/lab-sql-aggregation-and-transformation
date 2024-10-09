USE sakila;

#1.1 Determine the shortest and longest movie durations and
#name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration,
	MIN(length) AS min_duration
FROM film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT
    ROUND(AVG(length)) AS average_length_minutes,
    CONCAT(ROUND(FLOOR(AVG(length) / 60)), ' Hour(s) and ', ROUND(AVG(length) % 60), ' Minutes') AS average_length_hours_minutes
FROM film;

#2.1 Calculate the number of days that the company has been operating.
SELECT MIN(rental_date) AS first_day, MAX(rental_date) AS last_day,
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

#2.2 Retrieve rental information and add two additional columns to show 
#the month and weekday of the rental. Return 20 rows of results.
SELECT *,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

#To achieve this, retrieve the film titles and their rental duration.
#If any rental duration value is NULL, replace it with the string 'Not Available'.
#Sort the results of the film title in ascending order.
SELECT title,
	IFNULL(rental_duration, "Not Available") AS rental_duration
FROM film
ORDER BY rental_duration ASC;

#Using the film table, determine:
#1.1 The total number of films that have been released.
SELECT COUNT(film_id)
FROM film;
#1.2 The number of films for each rating.
SELECT COUNT(film_id), rating
FROM film
GROUP BY rating;
#1.3 The number of films for each rating,
#sorting the results in descending order of the number of films.
#This will help you to better understand the popularity of different film ratings
#and adjust purchasing decisions accordingly.
SELECT rating,COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

#Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order
#of the mean duration. Round off the average lengths to two decimal places.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
#This will help identify popular movie lengths for each category.
#2.2 Identify which ratings have a mean duration of over two hours in order to
#help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

#Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;