SELECT MAX(rental_duration) AS max_duration, MIN(rental_duration) AS min_duration
FROM film;
SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes
FROM film;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS active_days
FROM rental;
SELECT *, DATE_FORMAT(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY
FROM rental
LIMIT 20;SELECT *, CASE WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday')
THEN 'weekend'
ELSE 'workday' END AS day_type
FROM rental;
SELECT title, IFNULL(rental_duration, 'Not Available') as rental_duration
FROM film
ORDER BY title ASC;
SELECT CONCAT(first_name, ' ', last_name) as full_name, SUBSTRING(email, 1, 3) as email_prefix
FROM customer
ORDER BY last_name ASC;
SELECT COUNT(*) AS 'num_films' FROM film;
SELECT rating, COUNT(*) AS 'num_films' FROM film
GROUP BY rating;
SELECT rating, ROUND(AVG(length),2) AS 'avg_length' FROM film
GROUP BY rating
ORDER BY avg_length DESC;
SELECT rating, ROUND(AVG(length),2) AS avg_duration FROM film
GROUP BY rating
HAVING avg_duration > 120
ORDER BY avg_duration DESC;
SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;