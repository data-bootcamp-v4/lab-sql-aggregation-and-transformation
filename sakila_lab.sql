use sakila;

select max(length) as max_duration from film;
select min(length) as min_duration from film;
select round(avg(length),0) as avg_duration from film;

select datediff(max(rental_date), min((rental_date))) as operating_days from rental;
select rental_id, rental_date, date_format(rental_date, '%m') as month, date_format(rental_date, '%a') as weekday from rental limit 20;
select rental_id, rental_date, date_format(rental_date, '%a') as weekday from rental limit 20;

select *,
	case
		when dayofweek(rental_date) in (1,7) then 'weekday'
        else 'weekend'
	end as day_or_end
from rental;

select title,
	case
		when isnull(rental_duration) then 'not available'
        else rental_duration
        end as rental_state
from film;

select count(title)
from film
where not isnull(release_year)
group by release_year;

select rating, count(*) as num_films
from film
group by rating
order by num_films desc;

select rating, avg(length) avg_len
from film
group by rating
having avg_len > 120