
USE sakila ;

-- #1

SELECT max(length) as max_duration , min(length) as min_duration FROM sakila.film;



SELECT ROUND(AVG(length),0) as average_duration FROM sakila.film;

-- #2 
SELECT max(rental_date) from sakila.rental;
SELECT min(rental_date) from sakila.rental;

SELECT DATEDIFF(max(rental_date),min(rental_date)) FROM sakila.rental;

SELECT DATE_FORMAT(CONVERT(rental_date, DATE), '%W') as 'week_rental', date_format(CONVERT(rental_date, DATE), '%M') as 'month_rental'
FROM sakila.rental
LIMIT 20;

-- #3
SELECT title, IFNULL(rental_duration, 'Not available') as rental_duration FROM sakila.film
ORDER BY title ASC;

-- #4

SELECT CONCAT(first_name,' ', last_name) AS 'full_name' ,LEFT(email,3) as email_3 FROM sakila.customer
ORDER BY last_name ASC; 


-- Challenge 2
-- #1

SELECT * from sakila.film;

SELECT COUNT(title) from sakila.film;

SELECT COUNT(title),rating from sakila.film
GROUP BY rating;

SELECT COUNT(title),rating from sakila.film
GROUP BY rating
ORDER BY COUNT(title),rating;

-- #2
SELECT * from sakila.film;

SELECT  rating, round(avg(length),2) from sakila.film
GROUP BY rating
ORDER BY avg(length) DESC;


-- The rating that have long movies are the PG-13. Where the mean of length is over then 120 minutes. 
SELECT rating, ROUND(avg(length)) as avg_duration FROM sakila.film
GROUP BY rating
having avg(length) > 120;

-- #3

SELECT DISTINCT(last_name) from sakila.actor
GROUP BY last_name;
