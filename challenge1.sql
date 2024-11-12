USE sakila;

SHOW FULL TABLES;

SELECT min(length) as min_duration, max(length) as max_duration FROM sakila.film;

SELECT FLOOR(AVG(length)) FROM sakila.film;

SELECT datediff(max(rental_date), min(rental_date)) FROM sakila.rental;

SELECT *, MONTH(rental_date) as month, YEAR(rental_date) as year FROM sakila.rental LIMIT 20;

SELECT *, IF(weekday(rental_date) in (5,6), 'weekend', 'workday') as day_type FROM sakila.rental;

SELECT title, IFNULL(rental_duration, 'Not Available') as rental_duration FROM sakila.film ORDER BY title;

SELECT CONCAT(first_name, ' ', last_name) as full_name, substr(email, 1, 3) as first_3_mail FROM sakila.customer ORDER BY last_name;