USE sakila;

# CHALLENGE 1

select 
	max(length) as max_duration, 
	min(length) as min_duration 
from film;

select floor(avg(length)) as average_movie_length from film;

select 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    MOD(FLOOR(AVG(length)), 60) AS avg_minutes
FROM film;

select datediff(max(rental_date), min(rental_date)) as number_of_days from rental;

select *, date_format(rental_date, "%M") as rental_month, date_format(rental_date, "%W") as rental_weekday from rental limit 20;

SELECT 
    *, 
    date_format(rental_date, "%M") as rental_month, 
    date_format(rental_date, "%W") as rental_weekday,
    CASE
        WHEN DATE_FORMAT(rental_date, '%W') THEN "weekend"
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

select CONCAT(first_name, last_name) as customer_name, SUBSTRING(email, 1, 3) AS email_chars from customer order by last_name asc;

# CHALLENGE 2

select count(distinct film_id) as number_of_films from film;

select rating, count(distinct film_id) as number_of_films from film group by rating;

select rating, count(distinct film_id) as number_of_films from film group by rating order by number_of_films desc;

select rating, count(distinct film_id) as number_of_films, round(avg(length),2) as avg_length from film group by rating order by number_of_films desc;

select rating, count(distinct film_id) as number_of_films, round(avg(length),2) as avg_length from film group by rating having avg_length > 120  order by number_of_films desc ;

select last_name, count(last_name) as last_name_count from actor group by last_name having last_name_count = 1;





