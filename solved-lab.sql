SELECT 
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;

SELECT
  FLOOR(ROUND(AVG(length)) / 60) AS avg_hours,
  MOD(ROUND(AVG(length)), 60)   AS avg_minutes,
  CONCAT(FLOOR(ROUND(AVG(length))/60), ' hours ',
         MOD(ROUND(AVG(length)),60), ' minutes') AS avg_duration_hm
FROM film;

SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

SELECT
  rental_id,
  rental_date,
  customer_id,
  inventory_id,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date)   AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;

SELECT
  rental_id,
  rental_date,
  customer_id,
  inventory_id,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'  -- 1=Sunday, 7=Saturday
    ELSE 'workday'
  END AS day_type
FROM rental
ORDER BY rental_date
LIMIT 20;

SELECT
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3)                     As email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_length
FROM film
GROUP BY rating
ORDER BY mean_length DESC;

SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_length DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;
