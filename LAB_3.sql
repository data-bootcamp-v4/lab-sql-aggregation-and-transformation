USE sakila;

-- CHALLENGE 1
SELECT
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

-- 1.2: EXPRESS AVERAGE DURATION IN HOURS AND MINUTES
SELECT
FLOOR(AVG(length) / 60) AS avg_hours,
ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1: CALCULATE TOTAL OPERATING DAYS
SELECT
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2: EXTRACT RENTAL MONTH AND WEEKDAY
SELECT
rental_id,
rental_date,
MONTHNAME(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3: BONUS
SELECT
rental_id,
rental_date,
CASE
  WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
  ELSE 'workday'
  END AS DAY_TYPE
FROM rental;

-- 3: REPLACE MISSING RENTAL DURATIONS
SELECT
title,
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4: CREATE PERSONALIZED CUSTOMER EMAIL LIST
SELECT
CONCAT(first_name, '', last_name) AS customer_name,
LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2
-- 1.1: FIND THE TOTAL NUMBER OF FILMS RELEASED
SELECT
COUNT(*) AS total_films
FROM film;

-- 1.2: show the number of films for each rating category
SELECT
rating,
COUNT(*) AS number_of_fims
FROM film
GROUP BY rating;

-- 1.3: SORT THE RATINGS FROM HIGHEST FILM COUNT TO LOWEST
SELECT
rating,
COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 FINDING THE AVERAGE MOVIE DURATION FOR EACH RATING
SELECT
rating,
ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 IDENTIFY RATINGS THAT AVERAGE OVER TWO HOURS LONG
SELECT
rating,
ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- BONUS
SELECT
last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
