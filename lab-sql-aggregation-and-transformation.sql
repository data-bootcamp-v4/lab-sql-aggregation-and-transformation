use sakila;
-- 1. how many distinct actors last name are there?
select count(actor_id) from actor;

-- 2. how many different language where films orginally produced
select count(language_id) from language;

-- 3 how many movies were released with pg-13

select count(*) as movies_pG13 from film where rating = "PG-13";
-- 4 get the longest movies from 2006
SELECT title, length FROM film WHERE release_year = 2006 ORDER BY length DESC LIMIT 10;

-- 5 how many days has the company been operating?
-- option 1 ( my thought)

select count(distinct rental_date) as days_operating from rental; 
-- result i got around 15815 days 

-- option 2 ( what i discover from other source, but since we have not study curdate(), i am hesitant to use it,

SELECT DATEDIFF(CURDATE(), MIN(rental_date)) AS operating_days FROM rental;

-- answer i got 6948 days

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%M') AS month, 
    DATE_FORMAT(rental_date, '%W') AS weekday,
    IF(WEEKDAY(rental_date) IN (5, 6), 'weekend', 'workday') AS day_type
FROM 
    rental 
LIMIT 20;

-- 8 How many rentals were in the last month of activity?

SELECT COUNT(*) AS rentals_last_month 
FROM rental 
WHERE rental_date >= (SELECT MAX(rental_date) - INTERVAL 1 MONTH FROM rental);

