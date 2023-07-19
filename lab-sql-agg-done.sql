/* 1.1. */ 
SELECT MIN(length) AS min_duration
FROM film;
select max(length) as max_duration
from film;
/* 1.2. */
SELECT CONCAT(
  FLOOR(AVG(length) / 60), -- Hours
  'h ',
  ROUND(AVG(length) % 60), -- Minutes
  'min'
) AS average_duration
FROM film;
/* 2.1. */
 SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
/*2.2. */
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
/* 2.3. */
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;
/*3.*/
SELECT 
    title AS film_title,
    COALESCE(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY film_title ASC;
/* 4. */
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;
/* ChALLENGE 2 */
/*1.*/ 
SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

/*2*/

SELECT staff_id, COUNT(*) AS number_of_rentals_processed
FROM rental
GROUP BY staff_id;

/*3.*/

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

/*4.*/

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;









