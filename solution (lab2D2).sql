-- Lab SQL data aggregation and transformation - Challenge 1

USE sakila;

-- 1.1 Shortest and longest movie durations
SELECT MIN(length) AS max_duration, MAX(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes
SELECT ROUND(AVG(length) / 60) AS hours,
       ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2.1 Number of days the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental;

-- 2.2 Rental information with the month and weekday of each rental (20 rows)
SELECT *, MONTH(rental_date) AS month, DAYOFWEEK(rental_date) AS weekday
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration, 'Not Available' when the value is NULL
SELECT title, IFNULL(rental_duration, 'Not Available')
FROM film
ORDER BY title;
