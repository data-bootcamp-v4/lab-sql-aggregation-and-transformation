SELECT 
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;
SELECT 
  FLOOR(AVG(length) / 60) AS avg_hours,
  ROUND(AVG(length) % 60) AS avg_minutes
FROM film;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
SELECT 
  rental_id,
  rental_date,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday,
  CASE 
    WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental
LIMIT 20;
SELECT 
  title,
  IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;
SELECT COUNT(*) AS total_films
FROM film;
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
