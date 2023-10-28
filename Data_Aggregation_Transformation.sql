/* SQL Data Aggregation and Transformation */

/* Challenge 1 */
/* 1.1 */

SELECT MAX(length) AS max_duration
FROM sakila.film;

SELECT MIN(length) AS min_duration
FROM sakila.film;

SELECT AVG(length)
FROM sakila.film;

/* 1.2 */

SELECT DATEDIFF('2006/02/14', '2005/05/24') AS days_operating
FROM sakila.rental;

SELECT rental_id, rental_date
FROM sakila.rental;

SELECT *, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

SELECT *, 
       CASE 
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS day_type
FROM sakila.rental;

/* 1.3 */

SELECT title, COALESCE(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

/* 1.4 */

SELECT CONCAT(first_name, ' ', last_name) AS full_name, 
       SUBSTRING(email, 1, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name ASC;

/* Challenge 2 */
/* 2.1 */

SELECT COUNT(film_id)
FROM sakila.film;

SELECT rating, COUNT(rating)
FROM sakila.film
GROUP BY rating;

SELECT rating, COUNT(rating)
FROM sakila.film
GROUP BY rating
ORDER BY rating DESC;

/* 2.2 */

SELECT staff_id, COUNT(staff_id)
FROM sakila.rental
GROUP BY staff_id;

/* 2.3 */

SELECT rating, ROUND(AVG(length), 2) AS average_duration
FROM sakila.film
GROUP BY rating
ORDER BY average_duration DESC;

SELECT rating
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;

/* 2.4 */

SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;