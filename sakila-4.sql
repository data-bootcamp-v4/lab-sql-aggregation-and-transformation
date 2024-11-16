use sakila;

select distinct count(title) as number_of_films
from film;

select count(distinct title) as number_of_films, special_features
from film
group by special_features;

select count(distinct title) as number_of_films, special_features
from film
group by special_features
order by number_of_films desc;



