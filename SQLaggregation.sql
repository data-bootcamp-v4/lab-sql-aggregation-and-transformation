USE sakila;
-- Challenge 1
-- 1.1
SELECT min(length) as min_duration, max(length) as max_duration FROM film;
-- 1.2
SELECT FLOOR(avg(length)/60) as Hours, ROUND(avg(length%60)) as Minutes FROM film;
-- 2.1
SELECT DATEDIFF(max(rental_date), min(rental_date))FROM rental;
-- 2.2
SELECT *, MONTHNAME(rental_date) AS rental_month,DAYNAME(rental_date) AS rental_weekday FROM rental
LIMIT 20;
-- 3
SELECT title,IFNULL(rental_duration,'Not available') FROM film
order by title asc;

-- Challenge 2
-- 1.1
SELECT count(film_id) AS total_number_of_films FROM film;
-- 1.2
SELECT rating , count(film_id) AS Number_of_films
FROM film
GROUP BY rating;
-- 1.3
SELECT rating , count(film_id) AS Number_of_films
FROM film
GROUP BY rating
order by Number_of_films desc;
-- 2.1
SELECT rating, ROUND(avg(length),2) AS mean_length FROM film
GROUP BY rating
ORDER BY mean_length desc;
-- 2.2
SELECT rating, (avg(length)/60) AS mean_length FROM film
GROUP BY rating
HAVING mean_length>2;


