USE sakila;

# CHALLENGE 1
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(length) / 60) AS hours, FLOOR(AVG(length)) % 60 AS minutes
FROM film;

# 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental;

# 2.2 Retrieve rental information and add two additional columns to show the month
# and weekday of the rental. Return 20 rows of results.
SELECT rental_id, customer_id, rental_date, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

# 3. retrieve the film titles and their rental duration. If any rental duration value is NULL,
# replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
# use IFNULL function
SELECT title, IFNULL(rental_duration, 'Not Available')
FROM film
ORDER BY title ASC;

# CHALLENGE 2
# 1.1 The total number of films that have been released.
SELECT COUNT('film_id')
FROM film;

# 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(film_id) AS nr
FROM film
GROUP BY rating
ORDER BY nr DESC;

# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
# Round off the average lengths to two decimal places.
SELECT rating, ROUND(AVG(length), 2) AS mean_length
FROM film
GROUP BY rating
ORDER BY mean_length DESC;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS mean_length
FROM film
GROUP BY rating
HAVING mean_length > 120
ORDER BY mean_length DESC;
