select max(length) as max_duration, min(length) as min_duration
from film;

select floor(avg(length)/60) as hours, floor(avg(length)%60) as minutes
from film;

select DATEDIFF(max(rental_date),min(rental_date)) as runtime
from rental;

select *, DATE_FORMAT(rental_date, "%W"), date_format(rental_date, "%M")
from rental
limit 20;

select title,ifnull(length, "Not Available")
from film
order by title;

select count(film_id)
from film;

select count(film_id), rating
from film
group by rating
order by count(film_id) desc;

select round(avg(length), 2), rating
from film
group by rating
having avg(length)>120
order by avg(length) desc 
