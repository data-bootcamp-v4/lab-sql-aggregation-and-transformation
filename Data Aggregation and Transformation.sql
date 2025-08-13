/* 1.1 Shortest & longest movie durations (in minutes) */
SELECT
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;

/* 1.2 Average movie duration as HOURS and MINUTES (no decimals) */
SELECT
  FLOOR(AVG(length) / 60)             AS avg_hours,
  MOD(ROUND(AVG(length)), 60)         AS avg_minutes
FROM film;

/* 2.1 Number of days the company has been operating (using rentals) */
SELECT
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

/* 2.2 Rental info + month & weekday (show 20 rows) */
SELECT
  rental_id,
  customer_id,
  rental_date,
  MONTH(rental_date)   AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;

/* 2.3 BONUS: Add DAY_TYPE = weekend/workday */
SELECT
  rental_id,
  customer_id,
  rental_date,
  DAYNAME(rental_date) AS rental_weekday,
  CASE
    WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'  -- 1=Sun, 7=Sat
    ELSE 'workday'
  END AS day_type
FROM rental
ORDER BY rental_date
LIMIT 20;

/* 3. Films with rental duration; replace NULL with 'Not Available' */
SELECT
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

/* 4. BONUS (marketing): full name + first 3 chars of email; ordered by last name */
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3)                     AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;


-- Challenge 2

/* 1.1 Total number of films */
SELECT COUNT(*) AS total_films
FROM film;

/* 1.2 Number of films for each rating */
SELECT
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating;

/* 1.3 Number of films for each rating, sorted desc by count */
SELECT
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

/* 2.1 Mean film duration for each rating (2 decimals), sorted desc */
SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

/* 2.2 Ratings whose mean duration > 120 minutes */
SELECT
  rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

/* 3. BONUS: Last names in actor table that are NOT repeated */
SELECT
  last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;
