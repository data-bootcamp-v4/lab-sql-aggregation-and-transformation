USE sakila;
show tables;
-- challenge 1
-- 1.1
(SELECT length as max_duration, title FROM film order by length DESC limit 1)
UNION
(SELECT length as min_duration, title FROM film ORDER BY length asc LIMIT 1);
-- 1.2
SELECT CONCAT(
FLOOR(AVG(length)/60), 'h',
ROUND(AVG(LENGTH)) % 60, 'm'
) AS average_duration
FROM film;
-- 2.1
SELECT DATEDIFF(
(SELECT MAX(rental_date) FROM rental),
(SELECT MIN(rental_date) FROM rental)
) as OperatingTime;
-- 2.2
SELECT *,
monthname(rental_date) as rental_month,
dayname(rental_date) as rental_day
from rental limit 20;
-- 2.3
SELECT *,
monthname(rental_date) as rental_month,
dayname(rental_date) as rental_day,
CASE
WHEN dayname(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
ELSE 'workday' END AS day_type
from rental;

SELECT *,
monthname(rental_date) as rMonth,
dayname(rental_date) as rDay,
IF(dayname(rental_date) IN ('Saturday', 'Sunday'), 'weekend', 'workday') as day_type
from rental;
-- 3
SElect rental_duration from film;
SELECT title,
IFNULL(rental_duration, 'Not available') AS rental_duration
from film;
-- challenge 2
-- 1.1
SELECT COUNT(*) from film WHERE release_year> YEAR(CURDATE());
-- 1.2
SELECT rating, COUNT(*) as n_films from film
GROUP BY rating;
-- 1.3
SELECT rating, COUNT(*) as n_films from film
GROUP BY rating ORDER BY n_films DESC;
-- 2.1
SELECT rating, ROUND(AVG(length), 2) as avg_film_duration from film
GROUP BY rating ORDER BY avg_film_duration DESC;
-- 2.2
SELECT rating, ROUND(AVG(length), 2) as avg_film_duration from film
GROUP BY rating having avg_film_duration > 120;