select * from film;

select
count(distinct film_id)
from
film;

select
rating,
count(*) as rating_count
from 
film
group by rating
order by rating desc;

select
rating,
round(avg(length),2) as mean_length
from film
group by rating
order by mean_length desc;

select * from film;

select
rating,
(avg(length) > 120) as avg_length_film
from film
group by rating;

select * from actor;

select
last_name,
count(*) as last_name_count
from actor
group by last_name
having count(*) = 1
order by last_name

