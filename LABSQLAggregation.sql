use sakila;

SELECT DISTINCT length FROM film;
SELECT MAX(length) as max_duration FROM film;

SELECT MIN(length) as min_duration FROM film; 
SELECT ROUND(avg(length)) as AVG_Duration FROM film;


SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days FROM rental;
SELECT MONTHNAME(rental_date) as rental_month FROM rental;
SELECT DAYNAME(rental_date) as rental_weekday FROM rental;

SELECT *, 
       MONTHNAME(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 30;

SELECT *, 
       CASE 
           WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental
LIMIT 80;


SELECT title, IFNULL(rental_duration, "not_available") as Available_film FROM film
ORDER BY title ASC 
;
	
SELECT CONCAT(last_name, ' ', first_name), LEFT(email, 3) FROM customer
Order BY last_name ASC;

SELECT COUNT(DISTINCT film_id) From film;

SELECT rating, COUNT(film_id) as total_films FROM film
group by rating
order by total_films desc;

SELECT rating, ROUND(AVG(length), 2) as avg_films_duration FROM film
group by rating
order by avg_films_duration desc;

SELECT rating, ROUND(AVG(length), 2) as avg_films_duration FROM film
group by rating
having avg(length) > 120
order by avg_films_duration desc;

SELECT COUNT(last_name) FROM actor
	GROUP BY last_name
    HAVING COUNT(last_name) = 1;

SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;