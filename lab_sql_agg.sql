USE sakila;

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

SELECT ROUND(AVG(length)/60)
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental;

SELECT rental_date
FROM rental
LIMIT 10;

SELECT MONTHNAME(rental_date) AS month, DAYNAME(rental_date)
FROM rental
LIMIT 20;

SELECT rental_date,
	CASE
		WHEN WEEKDAY(rental_date) < 5 THEN 'weekday'
		ELSE 'weekend'
	END AS day_type
FROM rental;

SELECT title,
    CASE
        WHEN rental_duration IS NULL THEN 'Not available'
        ELSE rental_duration
    END AS rental_duration
FROM film
ORDER BY title;

SELECT CONCAT(last_name, ",", " ", first_name) AS customer_name,
SUBSTRING(email, 1, 3) AS email_3
FROM customer
ORDER BY customer_name;

#Challenge 2

SELECT COUNT(release_year)
FROM film;

SELECT rating, COUNT(film_id) AS count
FROM film
GROUP BY rating
ORDER BY rating DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120
ORDER BY avg_duration DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(actor_id) = 1; 
#I can use any other column to count or even an * (all rows)

SELECT * FROM actor
WHERE actor_id IS NULL; 
#using the * I'd include also the columns with null values
#in the COUNT above
