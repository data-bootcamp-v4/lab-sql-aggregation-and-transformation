use sakila;


## CHALLENGE 1
-- 1
-- 1.1 Determinar la pelicula mas corta y mas larga y nombrar a los valores con min_duration y max_duration
select 
min(length) as min_duration,
max(length) as max_duration
from film;

-- 1.2 Expresar la duración media de las películas en horas y minutos.
select
	round(avg(length) / 60) as horas,
	round(avg(length) % 60 )as minutos
from film;

-- 2
-- 2.1 Calcular el número de días que la empresa lleva operando.
select
	datediff(max(rental_date), min(rental_date)) as dias_operando
from rental;

-- 2.2 Recuperar información de alquiler y añadir columnas de mes y día de la semana. y devolver 20 filas de resultados
select
	rental_id,
    rental_date,
    monthname(rental_date) as rental_mes,
    dayname(rental_date) as rental_dia
from rental
limit 20;

-- 2.3 BONUS: Añadir una columna llamada DAY_TYPE con valores 'weekend' o 'workday'.
select
	rental_id,
    rental_date,
    case
		when dayofweek(rental_date) in(1,7) then 'weekend'
        else 'workday'
        end as day_type
from rental;


-- 3. Recuperar títulos de películas y su duración de alquiler.
-- Si el valor es NULL, reemplazarlo con 'Not Available'. Ordenar por título.

SELECT
	title,
    ifnull(rental_duration, 'Not Available') as rental_duracion
from film
order by title;
    
-- 4. Campaña de venta

select
	concat(first_name,' ', last_name) as nombre_compleot,
     substring(email,1,3) as prefijo_email
from customer
order by 
last_name asc;

## CHALLENGE 2

-- 1
-- 1.1 Total de peliculas realizadas
select
count(*) as peliculas_realizadas
from film;

-- 1.2 Número de películas por rating.
select
rating,
count(*) as cantidad_peliculas
from film
group by rating;

-- 1.3 Número de películas por clasificación, ordenado de mayor a menor.
select
rating,
count(*) as numero_peliculas
from film
group by rating
order by numero_peliculas desc;

-- 2 
-- 2.1 duracion media por cada rating, rankeados en descendente y ordenados por media de duracion, redodear la media a 2 decimales
select
	rating,
    round(avg(length), 2) as duracion_media
from film
group by rating
order by duracion_media;
    
-- 2.2 identifica que ratings tienen una duracion media de 2 horas
select
	rating,
    round(avg(length), 2) as duracion_media
from film
group by rating
having duracion_media > 120;

-- 3 Determina que nombres no estan repetidos en la tabla actor

select
last_name
from actor
group by  last_name
having count(*) = 1; 