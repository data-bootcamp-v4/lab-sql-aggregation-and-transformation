SHOW DATABASES;
USE sakila;
SHOW TABLES;
-- 2. Retrieve all data from actor, film and customer
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;
-- 3.1 Titles of all films
SELECT title FROM film;

-- 3.2 Languages used in films
SELECT name AS language FROM language;

-- 3.3 First names of all employees
SELECT first_name FROM staff;
SELECT DISTINCT release_year
FROM film;
SELECT COUNT(*) AS number_of_stores
FROM store;
SELECT COUNT(*) AS number_of_employees
FROM staff;
SELECT COUNT(*) AS films_available_for_rent
FROM inventory;
SELECT COUNT(*) AS films_rented
FROM rental;
SELECT COUNT(DISTINCT last_name) AS distinct_actor_last_names
FROM actor;
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;
SELECT *
FROM actor
WHERE first_name = 'SCARLETT';
SELECT title, length
FROM film
WHERE title LIKE '%ARMAGEDDON%'
  AND length > 100;
  SELECT COUNT(*) AS behind_the_scenes_films
FROM film
WHERE special_features LIKE '%Behind the Scenes%';