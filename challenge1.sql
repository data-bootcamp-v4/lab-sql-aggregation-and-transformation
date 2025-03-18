select * from film;

CREATE VIEW max_duration AS
SELECT *
FROM film
ORDER BY length DESC
LIMIT 10;

SELECT * FROM max_duration;

create view min_duration as
select *
from film
order by length asc
limit 10;

select * from min_duration;

select floor(avg(length)) 
from film 
as avg_length_film;

select * from rental;

select datediff(
(select max(rental_date) from rental),
(select min(rental_date) from rental) 
) as operating_days;

select *,
month(rental_date) as rental_month,
dayname(rental_date) as rental_weekday
from rental
limit 20;

select *,
case
	when dayofweek(rental_date) in (1,7) then 'weekend'
    else 'workday'
end as day_type
from rental;

select 
title,
if(rental_duration is NULL, 'Not Available', rental_duration) as rental_duration
from film
order by rental_duration asc;

select * from customer;

select
	concat(first_name,' ', last_name) as full_name,
	email
from 
customer;
