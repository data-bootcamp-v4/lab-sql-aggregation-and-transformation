USE sakila;

#1.1
SELECT MAX(rental_duration) AS max_duration, MIN(rental_duration) AS min_duration
FROM film;

#1.2
SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes
FROM film;

#2.1
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date))
FROM rental;

#2.2
SELECT *, DATE_FORMAT(MONTH(rental_date), "%M") AS month, DATE_FORMAT(WEEKDAY(rental_date), "%W") AS weekday
FROM rental
LIMIT 20;

#2.3 
SELECT *,
CASE
	WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
	ELSE 'workday'
END AS DAY_TYPE
FROM rental;

#3
SELECT title, IFNULL(rental_duration,"Not Available")
FROM film
ORDER BY title ASC;

#4
SELECT CONCAT(first_name, ' ', last_name) AS full_name, SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

#1.1
SELECT COUNT(*) AS num_films
FROM film;

#1.2
SELECT rating, COUNT(DISTINCT film_id)
FROM film
GROUP BY rating;

#1.3
SELECT rating, COUNT(DISTINCT film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(DISTINCT film_id) DESC;

#2.1
SELECT rating, ROUND(AVG(length),2)
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

#2.2
SELECT rating, ROUND(AVG(length),2) as mean_length
FROM film
GROUP BY rating
HAVING mean_length > 120
ORDER BY AVG(length) DESC;

#3
SELECT last_name, COUNT(last_name) AS ln_count
FROM actor
GROUP BY last_name
HAVING ln_count = 1;