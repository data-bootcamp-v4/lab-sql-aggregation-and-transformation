USE sakila; 

SELECT MIN(rental_date) AS fecha_mas_antigua, MAX(rental_date) AS fecha_mas_reciente 
FROM rental; 

SELECT DATEDIFF( 
(SELECT MAX(rental_date) FROM rental), 
(SELECT MIN(rental_date) FROM rental) 
) AS diferencia_dias;


select inventory_id, month(rental_date) as 'month', weekday(rental_date) as 'day'
from rental
limit 20;

select customer_id, weekday(rental_date) as 'day',
case
-- when day_type <> 6 or day_type <> 7 then 'working_day'
when weekday(rental_date) = 6 or weekday(rental_date) = 7 then 'weekend'
else 'working_day'
end as day_type
from rental;