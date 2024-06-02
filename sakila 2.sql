SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;
SELECT floor (avg(length)/60) AS hours , floor (avg(length)) AS minutes FROM film;

SELECT datediff(max(rental_date) ,
min(rental_date)) as days FROM rental;

SELECT rental_id, rental_date, 
extract(month from rental_date) as rental_month,
dayname(rental_date) as rental_day
FROM rental 
limit 20;

SELECT title, ifnull(rental_duration,"not available") AS rental_duration
FROM film
order by title asc;

SELECT count(*) FROM film;
SELECT count(*), rating FROM film 
group by rating;

SELECT count(*),rating FROM film
group by rating
order by count(*) desc;

SELECT rating,round(avg(length)) AS duration FROM film
group by rating 
order by duration desc;

SELECT rating,round(avg(length)) AS duration FROM film
group by rating
having duration >120;
