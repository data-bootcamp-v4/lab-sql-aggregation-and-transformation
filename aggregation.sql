use sakila;
#1.1
select min(length) as min_duration,max(length) as max_duration from film;
#1.2
select floor(avg(length)) from film;
#2.1
SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
#2.2
select*,month(rental_date) as month,weekday(rental_date) as weekday from rental
limit 20;
#2.3
select*,weekday(rental_date) as weekday ,
case
when weekday(rental_date) in (1,2,3,4,5) then "workday"
else "weekend"
end as day_type
from rental;
#3
select rental_duration from film;
select sum(isnull(rental_duration)) from film;
select title,coalesce(rental_duration,'not avaliable') as rental_duration from film
order by title asc;
select concat(first_name," ",last_name) as concated,left(email,3) as exrated from staff
order by last_name;

#challenge 2
#1.1
select count(*) from film;
#1.2
select rating,count(title) as number_of_films from film
group by rating;
#1.3
select rating,count(title) as number_of_films from film
group by rating
order by number_of_films desc;
#2.1
select rating,round(avg(length),2) as avg_duration from film
group by rating
order by avg_duration desc;
#2.2
select rating,round(avg(length),2) as avg_duration from film
group by rating
having avg_duration>120;

#bonus
select distinct last_name from actor;
