#lab3 - challenge 2

USE sakila;
#1.1
SELECT 
 COUNT(*)
From film;

#1.2
SELECT rating, COUNT(*)
FROM film
GROUP BY rating;
 
 #1.3
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

#2.1
SELECT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

#2.2
SELECT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film
GROUP BY rating
HAVING avg_duration > 120
ORDER BY avg_duration DESC;

#3
SELECT last_name 
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

