USE sakila;
--   CHALLENGE 1
 
/* 1.1 Shortest and longest movie durations (minutes) */
SELECT MAX(rental_duration) AS max_duration, MIN(rental_duration) AS min_duration
FROM film;

/* 1.2 Average movie duration in hours and minutes  */
SELECT 
  FLOOR(AVG(length) / 60) AS avg_hours,
  FLOOR(AVG(length)) % 60 AS avg_minutes
FROM film;

/* 2.1 Days the company has been operating (based on rentals) */
SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

/* 2.2 Show month and weekday for rentals (20 rows) */
SELECT 
  rental_id,
  rental_date,
  DATE_FORMAT(rental_date, '%M') AS rental_month,
  DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;

/* 2.3 Add DAY_TYPE = 'weekend' or 'workday' (20 rows) */
SELECT 
  rental_id,
  rental_date,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'  -- 1=Sun, 7=Sat
    ELSE 'workday'
  END AS day_type
FROM rental
ORDER BY rental_date
LIMIT 20;

/* 3. Film titles and rental duration, replace NULL with 'Not Available' */

SELECT 
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

/* 4. Full name + first 3 chars of email, order by last name */
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;

   -- CHALLENGE 2

/* 1.1 Total number of films released */
SELECT COUNT(*) AS total_films FROM film;

/* 1.2 Number of films for each rating */
SELECT 
  rating,
  COUNT(*) AS films
FROM film
GROUP BY rating
ORDER BY rating;

/* 1.3 Number of films for each rating, sorted by count descending */
SELECT 
  rating,
  COUNT(*) AS films
FROM film
GROUP BY rating
ORDER BY films DESC, rating ASC;

/* 2.1 Mean film duration per rating, rounded to 2 decimals */
SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_duration_minutes
FROM film
GROUP BY rating
ORDER BY rating;

/* 2.2 Ratings with mean duration > 2 hours (120 minutes) */
SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_duration_minutes
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration_minutes DESC;

/* 3. Last names that are NOT repeated in actor table */
-- Challenge 2 - 3 Bonus
SELECT 
  last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;

