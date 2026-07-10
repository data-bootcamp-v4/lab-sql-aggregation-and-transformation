USE sakila;

### challenge 1 ###
# 1 #
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;
SELECT CONCAT(FLOOR(AVG(length)/60),'h ',MOD(FLOOR(AVG(length)),60),'m') AS avg_duration FROM film;

# 2 #
# Number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS number_of_days_operating FROM rental;

SELECT *, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_day
FROM rental
LIMIT 20;

# 3 #
SELECT title, IFNULL(rental_duration, 'Not available')
FROM film
ORDER BY title ASC;

### challenge 2 ###

# 1 #
SELECT COUNT(film_id)
FROM film;

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

# 2 #
SELECT rating, ROUND(AVG(length),2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

SELECT rating, ROUND(AVG(length),2) AS average_duration
FROM film
GROUP BY rating
HAVING average_duration > 120
ORDER BY average_duration DESC;






