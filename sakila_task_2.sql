USE sakila;

SELECT MIN(length) as min_duration, MAX(length) as max_duration
FROM film;

SELECT ROUND(AVG(length),2) as avg_length -- CHECK THIS AGAIN FOR HOURS AND MINUTES
FROM film;

SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS total_days
FROM rental;

SELECT *, DATE_FORMAT(rental_date, "%M") as month, DATE_FORMAT(rental_date, "%D") as day
FROM rental
LIMIT 20;

SELECT title, IFNULL(length,"Not available")
FROM film;

SELECT COUNT(DISTINCT film_id) as amount_movies
FROM film;

SELECT rating, COUNT(DISTINCT film_id) as amount_movies
FROM film
GROUP BY rating;

SELECT rating, COUNT(DISTINCT film_id) as amount_movies
FROM film
GROUP BY rating
ORDER BY amount_movies DESC;

SELECT rating, ROUND(AVG(length),2) as length_movies,
CASE
	WHEN ROUND(AVG(length),2) >= 120 THEN "Over 2h"
    ELSE "Under 2h"
END AS duration_recommendation
FROM film
GROUP BY rating
ORDER BY length_movies DESC;