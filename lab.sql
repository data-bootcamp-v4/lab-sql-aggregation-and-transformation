USE sakila;

# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration

SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM film;
SELECT FLOOR(AVG(length)) AS avg_minutes,
FLOOR(AVG(length)/60) AS hours FROM film;

# 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS operating_days FROM rental;


# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_date, 
DAY(rental_date) AS "day",
WEEK(rental_date) AS "week"
FROM rental;

# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT rental_date, 
WEEKDAY(rental_date) AS "weekday",
	CASE 
		WHEN WEEKDAY(rental_date) THEN "workday"
		ELSE "weekend"
	END AS day_tpe
FROM rental;


# 3.

SELECT title, 
IFNULL(rental_duration,"not available") AS rental_duration;


# Challenge 2

SELECT COUNT(film_id) 
FROM film;

SELECT rating, COUNT(film_id) AS amount
FROM film
GROUP BY rating;

SELECT rating, COUNT(film_id) AS amount
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

# Challenge 2.2 

SELECT rating, ROUND(AVG(length),2) AS mean_length
FROM film
GROUP BY rating
ORDER BY ROUND(AVG(length),2) DESC;


SELECT rating, ROUND(AVG(length),2) AS mean_length
FROM film
GROUP BY rating
HAVING ROUND(AVG(length),2) > 120
ORDER BY ROUND(AVG(length),2) DESC;
