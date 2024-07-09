# CHALLENGE 1

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

USE sakila;

SELECT MAX(length) AS "max_duration"
FROM film; #185

SELECT title, length
FROM film
WHERE length = 185;

SELECT MIN(length) AS "min_duration"
FROM film; #46

SELECT title, length
FROM film
WHERE length = 46;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.

SELECT AVG(length) AS "average_duration",
FLOOR (AVG(length) / 60) AS avg_hours,
FLOOR (AVG(length) % 60) AS avg_minutes
FROM film;

SELECT 
CONCAT( FLOOR(AVG(length) / 60), ' hours ', 
        FLOOR(AVG(length) % 60), ' minutes'
    ) AS avg_duration_formatted
FROM film;

#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT DATEDIFF(MAX(rental_date) , MIN(rental_date))
FROM rental; #266 days

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *, MONTH(rental_date) AS "month", DAYNAME(rental_date) AS "day"
FROM rental
LIMIT 20;


SELECT title, rating, 
CASE
	WHEN length >= 150  THEN "Long Movie"
    WHEN length > 90 AND length < 150 THEN "Medium Lenght Movie"
    ELSE "Short Movie"
END AS lenght_type
FROM film;


#...RETRIEVE film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.

SELECT title, IFNULL(rental_duration,"Not available") as rental_duration
FROM film
ORDER BY rental_duration;


# CHALLENGE 2: Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:

#1.1 The total number of films that have been released.

SELECT count(film_id)
FROM film; #1,000

#1.2 The number of films for each rating.

SELECT rating, count(film_id)
FROM film
GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT rating, count(title)
FROM film
GROUP BY rating
ORDER BY rating DESC;  # REVISAR ERROR!!! no funciona completamente desc, hay que ajustarlo con la flechita

#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating , round(avg(length),2) AS film_duration
FROM film
GROUP BY rating
ORDER BY film_duration DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT title, length
FROM film
WHERE length >= 120
ORDER BY length DESC;

SELECT rating , round(avg(length),2) AS film_duration
FROM film
GROUP BY rating
HAVING film_duration >= 120
ORDER BY film_duration DESC;

#Bonus: determine which last names are not repeated in the table actor
SELECT DISTINCT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

