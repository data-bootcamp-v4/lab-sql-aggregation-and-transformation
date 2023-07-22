# --CHALENGE 1--
# 1.1

USE sakila;
SELECT title, length 
FROM film 
WHERE length = (select MIN(length) from film);

SELECT title, length 
FROM film 
WHERE length = (select MAX(length) from film);

# 1.2

SELECT floor(AVG(length)/60) AS hours, ROUND(AVG(length)) % 60 as mins 
FROM film;

# 2.1

SELECT DATEDIFF(MAX(rental_date),  MIN(rental_date)) 
FROM rental;

# 2.2
SELECT *, MONTH(rental_date), WEEKDAY(rental_date)
FROM rental
LIMIT 20;

# 2.3
SELECT *,
    CASE
        WHEN WEEKDAY(rental_date) < 5 THEN "workday"
        WHEN WEEKDAY(rental_date) >= 5 THEN "weekend"
    END
FROM rental;

# 3
SELECT title, COALESCE(rental_duration, "NOT AVAILABLE") # Interessant
FROM film;

# 4
SELECT CONCAT(first_name,last_name,LEFT(email,3))
FROM customer;

# --CHALENGE 2--

