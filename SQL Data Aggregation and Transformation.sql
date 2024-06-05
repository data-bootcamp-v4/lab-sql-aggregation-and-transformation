select max(length) as max_duration, min(length) as min_duration
from film;

select floor(avg(length))
from film;

-- select datediff(day, max(rental_date), min(rental_date))
-- from rental;

SELECT *, DATE_FORMAT(rental_date, '%M') AS rental_month, DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

select ifnull(rental_duration,"Not Available")
from film;

select count(release_year)
from film;

select rating, count(*)
from film
group by rating;

select rating, count(*) as rating_count
from film
group by rating
order by rating_count desc;

select rating, round(avg(length),2) as mean_length
from film
group by rating;	

SELECT rating, mean_length
FROM (
    SELECT rating, ROUND(AVG(length), 2) AS mean_length
    FROM film
    GROUP BY rating
) AS avg_lengths
WHERE mean_length > 120;
