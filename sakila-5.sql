use sakila;

select title, special_features, round(avg(`length`), 2) as avg_length
from film
group by special_features, title
order by avg_length desc;

select title, special_features, round(avg(`length`), 2) as avg_length
from film
group by special_features, title, avg_length
having avg_length > 120
order by avg_length desc