use sakila;
show tables;

select max(length) as max_duration, min(length) as min_duration
from film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,              
    FLOOR(AVG(length) % 60) AS avg_minutes             
FROM film;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM 
    rental;

select rental_id
from rental;

alter table rental
add column rentalxx
add column yy
limit 20;

SELECT *,
    MONTHNAME(rental_date) AS rental_month,  
    DAYNAME(rental_date) AS rental_weekday   
FROM 
    rental
LIMIT 20;

select title, ifnull(length, 'Not Available') 
from film
order by title;


select count(film_id)
from film;

select count(film_id)
from film
group by rating;

select rating, count(film_id) as film_count
from film
group by rating
order by film_count desc;

select rating, round(avg(length), 2) as mean_length
from film
group by rating
order by mean_length desc;

select rating, avg(length) as avg_duration
from film
group by rating
having avg_duration>120;

