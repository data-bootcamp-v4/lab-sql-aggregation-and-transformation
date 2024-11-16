use sakila;

select last_name, count(first_name) as recuento
from actor
group by last_name
having recuento = 1