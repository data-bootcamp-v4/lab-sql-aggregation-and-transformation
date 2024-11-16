use sakila;

select title, ifnull(rental_duration, 'Not Available') as rental_duration
from film;