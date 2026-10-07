use sakila;

-- Challenge 1
-- task 1
select * from film;
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;
SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes FROM film;

-- task 2
select * from rental;
Select DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating from rental;
Select *, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_day from rental LIMIT 20;
SELECT *, CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' ELSE 'workday' END AS DAY_TYPE FROM rental;

-- task 3
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration FROM film ORDER BY(title) ASC;

-- Challenge 2
-- task 1

SELECT * from film;
SELECT COUNT(title) AS total_film_number FROM film;
SELECT rating, COUNT(title) AS film_count FROM film GROUP BY rating;
SELECT rating, COUNT(title) AS film_count FROM film GROUP BY rating ORDER BY film_count DESC;

-- task 2
SELECT rating, ROUND(AVG(length), 2) as duration_by_rating FROM film GROUP BY rating ORDER BY AVG(length) DESC;
SELECT rating, ROUND(AVG(length), 2) AS avg_duration FROM film GROUP BY rating HAVING AVG(length) > 120;