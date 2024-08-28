use sakila;
SELECT title, FLOOR(length) as "min_duration" FROM film
ORDER BY length ASC
limit 1;

SELECT title, FLOOR(length) as "max_duration" FROM film
ORDER BY length DESC
limit 1;

SELECT 
    ROUND(AVG(length)) AS rounded_avg_length_in_minutes,
    FLOOR(ROUND(AVG(length)) / 60) AS avg_hours,
    FLOOR(ROUND(AVG(length)) MOD 60) AS avg_minutes
from film;

SELECT 
DATEDIFF(MAX(rental_date), MIN(rental_date)) as "operating_time"
from rental;

SELECT *, MONTH(rental_date) as "month", DAYNAME(rental_date) as "weekday"
FROM rental
limit 20;

SELECT *, MONTH(rental_date) as "month", DAYNAME(rental_date) as "weekday", IF(weekday(rental_date) > 5, "workday", "week end") AS "day type"
FROM rental;

SELECT title, IFNULL((rental_duration), 'Not available') as 'rental_duration'
FROM film
ORDER by title ASC;

SELECT *, CONCAT(first_name, "-", last_name, "-", SUBSTRING(email, 1, 3)) as "marketing_campaign"
FROM customer
ORDER BY last_name ASC;

SELECT rating, COUNT(title) as "number_of_movies"
FROM film
GROUP BY rating
ORDER BY "number_of_movies" DESC;

SELECT rating, ROUND(AVG(length), 2) AS "Rounded Avg."
FROM film
GROUP BY rating
ORDER BY "Rounded Avg." DESC;

SELECT rating, ROUND(AVG(length), 2) AS "Rounded Avg."
FROM film
GROUP BY rating
HAVING "Rounded Avg." > 120
ORDER BY "Rounded Avg." DESC;

SELECT last_name
from actor
group by last_name
having count(*) = 1




