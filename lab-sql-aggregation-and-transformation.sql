#challenge 1.
USE sakila;

#1.1
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

#1.2
SELECT 
	ROUND(AVG(length)/60) AS hours,
	ROUND(AVG(length) % 60) AS minutes
FROM film;

#2.1
SELECT DATEDIFF('2006-02-14 15:16:03 ', '2005-05-24 22:53:30') AS operating_days
FROM rental LIMIT 1;

#2.2
SELECT *,
	MONTHNAME(rental_date) AS month,
    DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;

#3
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM FILM;

#challenge 2
#1.1
SELECT COUNT(*) FROM film;

#1.2 + 1.3
SELECT rating , COUNT(rating) AS number_of_film
FROM film
GROUP BY rating
ORDER BY rating DESC;

#2.1
SELECT rating , COUNT(rating) AS number_of_film, ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

#2.2
SELECT 
	rating, 
    COUNT(rating) AS number_of_films, 
    ROUND(AVG(length)/60) AS mean_duration_hour
FROM film
GROUP BY rating
HAVING (AVG(length)/60) >= 2;
