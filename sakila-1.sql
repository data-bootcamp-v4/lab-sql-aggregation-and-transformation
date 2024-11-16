use sakila;

select title, `length` as max_duration
from film
order by `length` desc;

select title, `length` as min_duration
from film
order by `length`;

