USE sakila;
-- 1.1 Total Number of Films Released
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;
-- 1.2 Number of Films for Each Rating
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
-- 1.3 Number of Films for Each Rating in Descending Order
SELECT rating, COUNT(*) AS number_of_films;
-- 2.1 Mean Film Duration for Each Rating
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
-- 2.2 Ratings with Mean Duration over Two Hours
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;
-- Bonus
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;