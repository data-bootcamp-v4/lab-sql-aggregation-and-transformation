USE sakila;

SELECT max(length) as max_duration, min(length) as min_duration
FROM film; 

SELECT 
  FLOOR(AVG(length) / 60) AS avg_hours, #for int typ
  ROUND(AVG(length)) % 60 AS avg_minutes
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

select rental_id, date_format(rental_date, "%M") as month,
date_format(rental_date, "%W") as mwd
from rental;

SELECT title,
    CASE 
        WHEN ISNULL(rental_duration) THEN 'Not Available'
        ELSE "available"
    END AS availability_movie
FROM film;

SELECT count(release_year) as released_movie
FROM film;

SELECT rating, COUNT(film_id) AS rating_film
FROM film
group by rating
order by rating_film;

SELECT rating, COUNT(film_id) AS num_film
FROM film
group by rating
order by num_film desc;

select rating, round(avg(length)) as mean_duration
from film
group by rating
order by mean_duration DESC;

select rating, round(avg(length)) as mean_duration
from film
group by rating
having mean_duration > 120
order by mean_duration DESC;