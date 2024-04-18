#1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT length AS max_duration
FROM film
ORDER BY max_duration DESC
LIMIT 1;
SELECT length AS min_duration
FROM film
ORDER BY min_duration ASC
LIMIT 1;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(length)) AS total_minutes,
FLOOR(AVG(LENGTH) / 60) AS hours,
FLOOR(AVG(length)) % 60 AS minutes
FROM film;
#2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS operational_days
FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, MONTH(rental_date) AS month, WEEKDAY(rental_date) AS weekday 
FROM rental;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *, MONTH(rental_date) AS month, WEEKDAY(rental_date) AS weekday,
CASE
WHEN WEEKDAY(rental_date) >= 1 AND WEEKDAY(rental_date) < 6 THEN "workday"
WHEN WEEKDAY(rental_date) = 6 OR WEEKDAY(rental_date) = 0 THEN "weekend"
END
AS DAY_TYPE
FROM rental;
#3. retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration
FROM film
ORDER BY rental_duration ASC;

#challenge 2
#1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(DISTINCT film_id) AS total_films
FROM film;
-- 1.2 The number of films for each rating.
SELECT rating, COUNT(DISTINCT film_id) AS total_films
FROM film
GROUP BY rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(DISTINCT film_id) AS total_films
FROM film
GROUP BY rating
ORDER BY COUNT(DISTINCT film_id) DESC;
#2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
SELECT rating, COUNT(DISTINCT film_id) AS total_films, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, COUNT(DISTINCT film_id) AS total_films, AVG(length) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120;