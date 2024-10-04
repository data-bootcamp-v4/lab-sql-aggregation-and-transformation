USE sakila;
#Challenge 1
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MAX(length) AS max_duration,
	   MIN(length) AS min_duration
FROM film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.

SELECT FLOOR(AVG(length) / 60) AS hours,
MOD(FLOOR(AVG(length)), 60) AS minutes
FROM film;

#2.1 Calculate the number of days that the company has been operating.
SELECT * FROM rental;
SELECT DATEDIFF(
        (SELECT MAX(rental_date) FROM rental), 
        (SELECT MIN(rental_date) FROM rental)
    ) AS days_operating;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,
MONTH(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20; 

#3. retrieve the film titles and their rental duration. 
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#CHALLENGE 2
#1.1 The total number of films that have been released.
SELECT COUNT(film_id) AS total_films
FROM film;

#1.2 The number of films for each rating.
SELECT * FROM film;
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT * FROM film;
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) AS mean_film_duration
FROM film
GROUP BY rating
ORDER BY mean_film_duration ASC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, ROUND(AVG(length),2) AS mean_film_duration
FROM film
GROUP BY rating
HAVING mean_film_duration > 120
ORDER BY mean_film_duration ASC;

#Bonus: determine which last names are not repeated in the table actor.
SELECT DISTINCT last_name FROM actor;



