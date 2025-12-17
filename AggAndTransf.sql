SELECT MIN(length) AS min_duration, MAX(length) AS max_duration 
FROM film;
SELECT FLOOR(AVG(length) / 60) AS avghours, ROUND(AVG(length) % 60) AS avgmins 
FROM film;

SELECT datediff(MAX(rental_date), MIN(rental_date)) AS operatingdays 
FROM rental;
SELECT rental_id, rental_date, customer_id, inventory_id, monthname(rental_date) AS rental_month, dayname(rental_date) AS rental_days 
FROM rental
ORDER BY rental_date;

SELECT title, IFNULL(CAST(rental_duration AS CHAR), 'not available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS films_per_rating
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS films_per_rating
FROM film
GROUP BY rating
ORDER BY films_per_rating DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_durationmins
FROM film
GROUP BY rating
ORDER BY mean_durationmins DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_durationmins
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_durationmins