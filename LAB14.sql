-- Active: 1721291050538@@127.0.0.1@3306@sakila
USE sakila;
--1)
SELECT MAX(rental_duration) AS max_duration, MIN(rental_duration) AS min_duration
FROM film;
SELECT ROUND((AVG(length)), 0) AS 'AVG Duration in minutes' FROM film;
SELECT TIME_FORMAT(SEC_TO_TIME(AVG(length)*60), '%H:%i') AS 'AVG duration in hours and minutes' FROM film;
SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes
FROM film;
--2)
SELECT MIN(rental_date) FROM rental;
SELECT MAX(rental_date) FROM rental;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM rental;
SELECT *, CONVERT(rental_date,date) as 'Month' FROM rental;
SELECT *, DATE_FORMAT(rental_date,'%M') AS 'MONTH',DATE_FORMAT(rental_date,'%W') AS 'DAY' FROM rental LIMIT 20;
SELECT *, DATE_FORMAT(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY
FROM rental
LIMIT 20;
SELECT *, CASE WHEN DATE_FORMAT(rental_date,'%W') IN ('Monday','Tuesday','Wednesday','Thursday','Friday') THEN 'Workday' ELSE 'Weekend' END AS 'DAY TYPE' FROM rental LIMIT 20;
--3) 
SELECT title, rental_duration, IFNULL(rental_duration, 'Not Available') AS 'ERROR' FROM film ORDER BY title ASC;
SELECT email FROM customer;
SELECT CONCAT(first_name,' ', last_name) AS 'Customer Full NAME', SUBSTRING(email,1,3) AS 'EMAIL' FROM customer ORDER BY last_name ASC;
--1.1)
SELECT COUNT(title), COUNT(release_year) AS 'Total fims released' FROM film;
SELECT COUNT(*) AS 'num_films' FROM film;
SELECT COUNT(title), rating FROM film GROUP BY rating;
SELECT COUNT(title), rating FROM film GROUP BY rating ORDER BY COUNT(title) DESC;
SELECT ROUND(AVG(length),2), rating FROM film GROUP BY rating ORDER BY ROUND(AVG(length),2) DESC;
SELECT ROUND(AVG(length),2), rating FROM film GROUP BY rating HAVING ROUND(AVG(length),2) > 120 ORDER BY ROUND(AVG(length),2) DESC;
SELECT last_name FROM actor GROUP BY last_name HAVING last_name = last_name;



