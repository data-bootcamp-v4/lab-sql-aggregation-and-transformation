#Challenge 1
/*1*/
USE sakila;
SELECT max(length) as max_length, min(length)
FROM sakila.film;

/*1.2*/
SELECT CONCAT(floor(AVG(length)/ 60) ,"H", round((AVG(length)%60),2)  ,"min") as avg_length
FROM sakila.film;

/*2.1*/
SELECT CONCAT(DATEDIFF(max(return_date),min(rental_date))) as "Days open"
FROM sakila.rental;

/*2.2*/
SELECT *, monthname(rental_date) as 'month', dayname(rental_date) as 'day_of_the_week'
FROM sakila.rental
LIMIT 20;

/*2.3*/
SELECT *, IF(dayname(rental_date) = 'Sunday' OR 'Saturday','Weekend','Workday') as 'DAY_TYPE'
FROM sakila.rental;

/*3*/
SELECT title, IFNULL(rental_duration,"Not Avaliable") as rental_duration
FROM sakila.film;

/*4*/
SELECT CONCAT(first_name, " ",last_name) as Full_name, LEFT(email,3)
FROM sakila.customer
ORDER BY last_name ASC;



#Challenge 2
/*1.1*/
SELECT COUNT(film_id) AS 'Number of films'
FROM sakila.film;

/*1.2*/
SELECT rating, COUNT(film.rating)
FROM sakila.film
GROUP BY film.rating;

/*1.3*/
SELECT rating, COUNT(film.film_id) AS "Films_per_Rating"
FROM sakila.film
GROUP BY film.rating
ORDER BY rating DESC;
/*2*/
SELECT staff_id, COUNT(staff_id)
FROM sakila.rental
GROUP BY staff_id;

/*3.1*/
SELECT rating, COUNT(film.rating) AS "Films_per_Rating",ROUND(AVG(length),0) AS "Average_length"
FROM sakila.film
GROUP BY film.rating
ORDER BY AVG(length) DESC;

/*3.2*/
SELECT AVG(length) >=120 AS "AVG_over_2Hours", rating
FROM sakila.film
GROUP BY film.rating
ORDER BY AVG(length) DESC;

/*4*/
SELECT last_name, COUNT(last_name)
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name)=1;