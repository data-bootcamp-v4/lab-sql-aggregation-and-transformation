USE sakila;

-- #1.1.1
Select length from film as max_duration 
where 
length = (SELECT MAX(length) FROM film)
LIMIT 1;

Select length from film as min_duration 
where
length = (SELECT MIN(length) FROM film)
LIMIT 1;

-- #1.1.2

SELECT
CONCAT(FLOOR(avg_len / 60), 'h ', FLOOR(avg_len) % 60, 'm') AS Hours_Minutes
FROM (
  SELECT AVG(length) AS avg_len
  FROM sakila.film
)t;

-- #1.2.1
SELECT
  MAX(rental_date) AS latest_date,
  MIN(rental_date) AS earliest_date,
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operation_period
FROM sakila.rental;

-- #1.2.2
SELECT *, DAYNAME(rental_date) AS WeekDay_RENTAL,
MONTHNAME(rental_date) AS Month_RENTAL FROM sakila.rental;

-- #1.3

SELECT title,
       IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

-- #2.1.1
SELECT COUNT(film_id) AS movieCNTrelease
FROM sakila.film;

-- #2.1.2
SELECT rating, COUNT(film_id) AS movieCNTbyrating
FROM sakila.film
GROUP BY rating;

-- #2.1.3
SELECT rating, COUNT(film_id) AS movieCNTbyrating
FROM sakila.film
GROUP BY rating
order by  movieCNTbyrating desc;

-- #2.2.1

SELECT rating, COUNT(film_id) AS movieCNTbyrating, round(avg(length),2) as movieavgtime
FROM sakila.film
GROUP BY rating
order by  movieavgtime desc;

-- #2.2.2

SELECT rating, COUNT(film_id) AS movieCNTbyrating, round(avg(length),2) as movieavgtime
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;