USE sakila;
# You need to use SQL built-in functions to gain insights relating to the duration of movies:
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT min(length) as min_duration FROM film;
SELECT max(length) as max_duration FROM film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT avg(length) as average_duration FROM film; 
#Hint: Look for floor and round functions.

# You need to gain insights related to rental dates:

#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.


# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
# 1.1 The total number of films that have been released.
SELECT count(film_id) FROM film;
# 1.2 The number of films for each rating.
SELECT count(film_id), rating FROM film
GROUP BY rating
ORDER BY count(film_id) DESC;
# 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
# This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

# Using the film table, determine:
# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT avg(length), rating FROM film
GROUP BY rating
ORDER BY avg(length) DESC;
# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT avg(length), rating FROM film
GROUP BY rating
HAVING avg(length) > 120;