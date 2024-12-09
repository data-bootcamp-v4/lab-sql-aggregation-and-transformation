SELECT min(length) AS min_duration, max(length) AS max_duration
FROM sakila.film;

SELECT title, length AS max_duration 
FROM film
ORDER BY length DESC 
LIMIT 1;

SELECT title, length AS min_duration 
FROM film
ORDER BY length ASC 
LIMIT 1;


SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

SELECT DATEDIFF(MAX(r.return_date), MIN(r.rental_date)) AS days_operating
FROM sakila.rental r;

SELECT *,
	month(rental_date) as month_rental,
    weekday(rental_date) as weekday_rental
FROM sakila.rental r
LIMIT 20;

SELECT *,
	weekday(rental_date) as weekday_rental,
    case when weekday(rental_date)>4 then 'weekend'
    else 'workday' 
    end as day_type
FROM sakila.rental r;

SELECT f.title, IFNULL(f.rental_duration, 'Not Available') AS rental_duration
FROM sakila.film f;

SELECT COUNT(film_id) as films_released
FROM sakila.film
WHERE release_year IS NOT NULL;

SELECT rating, count(film_id) as number_of_films
FROM sakila.film
GROUP BY rating;

SELECT rating, count(film_id) as number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;

SELECT rating, ROUND(AVG(length), 2) as duration
FROM sakila.film
GROUP BY rating
ORDER BY duration DESC;

SELECT rating, ROUND(AVG(length), 2) as duration
FROM sakila.film
GROUP BY rating
HAVING duration > 120;

SELECT DISTINCT(last_name)
FROM sakila.actor;