-- Challenge 1
-- Question 1
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM sakila.film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,		-- avg in hours is 1
    ROUND(MOD(AVG(length), 60)) AS avg_minutes		-- avg in minuts is 55
FROM sakila.film;

-- Question 2
SELECT MIN(rental_date) AS first_day, MAX(rental_date) AS last_day, DATEDIFF(MAX(rental_date), MIN(rental_date)) AS DateDiff
FROM sakila.rental;

SELECT *, DAYNAME(rental_date), DATE_FORMAT(rental_date, '%m') AS month
FROM sakila.rental
LIMIT 20;

-- Bonus
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *, weekday(rental_date) AS weekday, IF(weekday(rental_date) <= 5, "workday", "weekend") AS DAY_TYPE
FROM sakila.rental
LIMIT 20;

-- Question 3
SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration
FROM sakila.film;

-- Bonus
SELECT CONCAT(first_name, " " ,last_name) AS full_name,
	   SUBSTRING(email, 1,3) as email
FROM sakila.customer
ORDER BY last_name ASC;


-- Challenge 2
-- Question 1
SELECT COUNT(DISTINCT(title))
FROM sakila.film;		-- 1000 films have been released

SELECT rating, COUNT(rating) AS rating_count
FROM sakila.film
GROUP BY rating;

SELECT rating, COUNT(rating) AS rating_count
FROM sakila.film
GROUP BY rating
ORDER BY rating_count DESC;

-- Question 2
SELECT rating, COUNT(rating) AS rating_count, ROUND(AVG(length),2) AS avg_length
FROM sakila.film
GROUP BY rating
ORDER BY avg_length DESC;

SELECT rating, COUNT(rating) AS rating_count, ROUND(AVG(length),2) AS avg_length
FROM sakila.film
GROUP BY rating
HAVING avg_length > 120
ORDER BY avg_length DESC;

-- Bonus
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;


