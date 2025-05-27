SELECT 
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;

SELECT 
  FLOOR(AVG(length) / 60) AS hours,
  FLOOR(AVG(length) % 60) AS minutes
FROM film;

SELECT DATEDIFF(
    MAX(rental_date),
    MIN(rental_date)
) AS operating_days
FROM rental;

SELECT 
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  return_date,
  staff_id,
  MONTH(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT 
  title,
  CASE 
    WHEN rental_duration IS NULL THEN 'Not Available'
    ELSE CAST(rental_duration AS CHAR)
  END AS rental_duration
FROM film
ORDER BY title ASC;


SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS films_count
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS films_count
FROM film
GROUP BY rating
ORDER BY films_count DESC;

SELECT 
  rating, 
  ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT 
  rating, 
  ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;