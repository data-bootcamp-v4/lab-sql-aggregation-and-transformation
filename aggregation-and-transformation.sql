USE sakila;

-- =========================
-- Challenge 1
-- =========================

-- 1.1 Determine the shortest and longest movie durations
SELECT
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;

-- 1.2 Express the average movie duration in hours and minutes (no decimals)
-- average minutes -> hours = FLOOR(avg/60), minutes = ROUND(avg - hours*60)
SELECT
  FLOOR(AVG(length) / 60) AS avg_hours,
  ROUND(AVG(length) - (FLOOR(AVG(length) / 60) * 60)) AS avg_minutes
FROM film;


-- 2.1 Calculate the number of days the company has been operating (based on rental dates)
SELECT
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental info + month + weekday, return 20 rows
SELECT
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  staff_id,
  MONTH(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Add DAY_TYPE = 'weekend' or 'workday'
SELECT
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  staff_id,
  MONTH(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday,
  CASE
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- 1=Sunday, 7=Saturday in MySQL
    ELSE 'workday'
  END AS day_type
FROM rental
LIMIT 20;


-- 3. Film titles + rental duration; if NULL then 'Not Available'; sort by title ASC
SELECT
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4 BONUS: customer full name, first 3 chars of address, email; order by last name ASC
-- customer -> address via customer.address_id
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(a.address, 3) AS address_first_3,
  c.email
FROM customer c
JOIN address a
  ON c.address_id = a.address_id
ORDER BY c.last_name ASC, c.first_name ASC;


-- =========================
-- Challenge 2
-- =========================

-- 1.1 Total number of films released
SELECT
  COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films for each rating
SELECT
  rating,
  COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, sorted descending by number of films
SELECT
  rating,
  COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;


-- 2.1 Mean film duration for each rating, rounded to 2 decimals, sort desc by mean duration
SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours (> 120 minutes)
SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;


-- 3 BONUS: last names NOT repeated in actor table (appear exactly once)
SELECT
  last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;
