-- Challenge 1

-- 1.1 Shortest and longest movie durations
SELECT
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration as H and M (no decimals)
SELECT
  CONCAT(
    FLOOR(AVG(length)/60), 'h ',
    MOD(FLOOR(AVG(length)), 60), 'm'
  ) AS avg_duration_hm
FROM film;

-- 2.1 Days the company has been operating
SELECT
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Rental info + month and weekday (20 rows)
SELECT
  rental_id, rental_date, return_date, customer_id, staff_id,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date)   AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;

-- 2.3 BONUS: Rental info + DAY_TYPE = weekend/workday (20 rows)
SELECT
  rental_id, rental_date, return_date, customer_id, staff_id,
  CASE
    WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental
ORDER BY rental_date
LIMIT 20;

-- 3. Film titles + rental_duration, NULL -> 'Not Available'
SELECT
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS: Full name + first 3 chars of email, ordered by last name
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  SUBSTRING(email, 1, 3)            AS email_prefix
FROM customer
ORDER BY last_name ASC;



-- Challenge 2

-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 Number of films for each rating
SELECT
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 1.3 Number of films per rating, descending by count
SELECT
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2.1 Mean film duration by rating (rounded to 2 decimals), desc
SELECT
  rating,
  ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

-- 2.2 Ratings with mean duration > 2 hours
SELECT
  rating,
  ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_length DESC;

-- BONUS: Last names in actor table that are NOT repeated
SELECT
  last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;