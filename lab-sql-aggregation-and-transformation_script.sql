USE sakila;

# Task 1
# You need to use SQL built-in functions to gain insights relating to the duration of movies:
#
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
# Hint: Look for floor and round functions.

#SELECT ROUND(AVG(length)) AS length_minutes, ROUND(AVG(length)/60) AS length_hours
#FROM film;

SELECT FLOOR(AVG(length)/60) AS length_hours, FLOOR(AVG(length) % 60) AS length_minutes
FROM film;


# Task 2.0
#You need to gain insights related to rental dates:

# 2.1 Calculate the number of days that the company has been operating.
#  Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date
#  column from the latest date.

#SELECT (DATEDIFF(MAX(rental_date), CURDATE())*-1) AS days_operation
#FROM rental

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operation
FROM rental;

# Task 2.2
# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
# Return 20 rows of results.

SELECT rental_id, rental_date, MONTH(rental_date) as rental_month,
	CASE
		WHEN DAYOFWEEK(rental_date) = 1 THEN "Sunday"
        WHEN DAYOFWEEK(rental_date) = 2 THEN "Monday"
        WHEN DAYOFWEEK(rental_date) = 3 THEN "Tuesday"
        WHEN DAYOFWEEK(rental_date) = 4 THEN "Wednesday"
        WHEN DAYOFWEEK(rental_date) = 5 THEN "Thursday"
        WHEN DAYOFWEEK(rental_date) = 6 THEN "Friday"
        WHEN DAYOFWEEK(rental_date) = 7 THEN "Saturday"
    END
    AS rental_day
FROM rental
LIMIT 20;


# 2.3 Bonus: Retrieve rental information and add an additional column called
# DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT rental_id, rental_date, MONTH(rental_date) as rental_month,
	CASE
		WHEN DAYOFWEEK(rental_date) = 1 THEN "Sunday"
        WHEN DAYOFWEEK(rental_date) = 2 THEN "Monday"
        WHEN DAYOFWEEK(rental_date) = 3 THEN "Tuesday"
        WHEN DAYOFWEEK(rental_date) = 4 THEN "Wednesday"
        WHEN DAYOFWEEK(rental_date) = 5 THEN "Thursday"
        WHEN DAYOFWEEK(rental_date) = 6 THEN "Friday"
        WHEN DAYOFWEEK(rental_date) = 7 THEN "Saturday"
    END
    AS rental_day,
    CASE
		WHEN DAYOFWEEK(rental_date) >= 2 OR DAYOFWEEK(rental_date) <= 6 THEN "Workday"
        ELSE "Weekend"
    END
    AS day_type
FROM rental
LIMIT 20;

# Task 3
#You need to ensure that customers can easily access information about the movie collection.
#To achieve this, retrieve the film titles and their rental duration.
# If any rental duration value is NULL, replace it with the string 'Not Available'.
# Sort the results of the film title in ascending order.

#Please note that even if there are currently no null values in the rental duration column, 
# the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.

SELECT title, IFNULL(rental_duration, "Not Available") AS availability
FROM film
ORDER BY title ASC;


# CHALLENGE 2
# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
# 1.1 The total number of films that have been released.

SELECT COUNT(film_id)
FROM film;

# 1.2 The number of films for each rating.

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films.

SELECT rating, COUNT(film_id) AS count_rating
FROM film
GROUP BY rating
ORDER BY count_rating DESC;

# This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

# Task 2.0
# Using the film table, determine:
# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, COUNT(film_id) AS count_rating, ROUND(AVG(length),2) as mean_length
FROM film
GROUP BY rating
ORDER BY count_rating DESC;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, COUNT(film_id) AS count_rating, ROUND(AVG(length),2) as mean_length
FROM film
GROUP BY rating
HAVING mean_length > 120
ORDER BY count_rating DESC;