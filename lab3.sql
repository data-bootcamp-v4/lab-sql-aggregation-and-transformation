USE sakila;
#.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(length) AS min_duration
FROM film;

SELECT MAX(length) AS max_duration
FROM film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

#2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *,
MONTH(rental_date),
DAYNAME(rental_date),
CASE
        WHEN WEEKDAY(rental_date) >= 5 THEN 'weekend'
        ELSE 'workday'rental_duration
    END AS DAY_TYPE
 FROM rental;
 
#retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, 
CASE
        WHEN rental_duration >= 1 THEN rental_duration
        ELSE 'not available'
    END AS rental_duration
FROM film
ORDER BY title ASC;

#1.1 The total number of films that have been released.
SELECT COUNT(*)
FROM film;

#1.2 The number of films for each rating.
SELECT rating, COUNT(*)
FROM film
GROUP BY rating
ORDER BY COUNT(*) ASC;

#mean film duration for each rating 
SELECT rating, COUNT(*), ROUND(AVG(length),2)
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

#which ratings have a mean duration of over two hours
SELECT rating, COUNT(*), ROUND(AVG(length),2)
FROM film
GROUP BY rating
HAVING ROUND(AVG(length), 2) > 120
ORDER BY AVG(length) DESC;

