USE sakila;

SELECT min(length) as min_duration, max(length) as max_duration from film;

select floor(avg(length)/60) as hours, round(avg(length)%60) as minutes, concat(floor(avg(length)/60),':',round(avg(length)%60)) as avg_length from film;

select datediff(max(rental_date),min(rental_date)) from rental;

SELECT *, DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%M') as month,
DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%W') as weekday  from rental limit 20;

SELECT *, DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%M') as month,
DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%W') as weekday, 
CASE 
WHEN DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%W') in ('Saturday','Sunday') then 'weekend'
else 'workday'
end as 'day_type'
 from rental;
 
 select title, 
 case
 when isnull(rental_duration) then 'Not Available'
 else rental_duration
 end as rental_duration
 from film;
 
 select concat(first_name,' ',last_name) as full_name, left(email,3) as email_id from customer order by last_name;
 
 select count(*) from film;
 select rating,count(film_id) as number_films from film group by rating;
 select rating,count(film_id) as number_films from film group by rating order by number_films desc;
 select rating, round(avg(length),2) as avg_length from film group by rating order by avg_length desc;
 select rating, round(avg(length),2) as avg_length from film group by rating having avg_length >120 order by avg_length desc ;
 select last_name from actor group by last_name having count(last_name)=1;
 