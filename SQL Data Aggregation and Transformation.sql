-- 1
Select MAX(length) as max_duration , MIN(length) as min_duration from film;

-- 1.2
 Select floor(avg(length) / 60) as hours,
		round(
        (avg(length) % 60
        ),0) as minutes
from film;

-- 2.1
Select datediff(max(return_date),min(return_date) ) as days from rental;

-- 2.2
Select *, month(return_date) as months, 
		weekday(return_date) as days from rental
        limit 20;
-- 2.3

Select *,
	CASE
		when weekday(return_date) IN (5,6) then 'weekend'
        else 'workday'
	end as day_type from rental;

-- 3
Select title,
 ifnull(rental_duration, 'Not Available') as rental_duration
 from film
 order by title asc;
 
 -- 4
 
 Select Concat(first_name, ' ', last_name) as Full_name,
 left(email, 3) as email_abbr
    from customer
    order by last_name asc;


-- c2
-- 1
select count(*) as total from film;

-- 1.2

select rating, count(*) from film group by rating;

-- 1.3
select rating, count(*) as total from film group by rating order by total desc;


-- 2.1

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

-- 3
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;