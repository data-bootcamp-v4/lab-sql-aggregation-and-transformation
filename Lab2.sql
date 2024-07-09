use sakila;

select title, length as min_duration
from film
order by length 
limit 10;


select title, length as max_duration
from film
order by length desc
limit 10;


select FLOOR(avg(length) / 60) as avg_hours, mod(ROUND(avg(length)), 60) as avg_minutes
from film;


select datediff(max(rental_date), min(rental_date)) as days_operating
from rental;

select rental_id, rental_date, customer_id, return_date, inventory_id, staff_id, monthname(rental_date) as rental_month, dayname(rental_date) as rental_weekday
from  rental
limit 20;

select  title,ifnull(rental_duration, 'Not Available') as rental_duration
from film
order by title asc;


select count(*) as total_films
from film;

select rating, count(*) as num_films
from film
group by rating
order by num_films desc;


select rating, round(avg(length), 2) as avg_duration
from film
group by rating
order by avg_duration;

select rating, round(avg(length),2) as long_duration
from film
group by rating
having long_duration > 120;





