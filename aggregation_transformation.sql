USE sakila;
-- Challenge 1
-- Challenge 1.1
SELECT 
MAX(length) AS max_duration,
MIN(length) AS min_duration 
FROM film;

-- Challenge 1.2
SELECT
AVG(length)
FROM film;
SELECT
    FLOOR(AVG(length)/60) AS hours,
    ROUND(MOD(AVG(length),60)) AS minutes
FROM film;

-- Challenge 1 - Question 2.1: Number of days the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- Challenge 1 - Question 2.2: Retrieve rental information with month and weekday
SELECT
rental_id
rental_date,
DATE_FORMAT(rental_date,'%M') AS month,
DATE_FORMAT(rental_date,'%w') AS weekday
FROM rental
LIMIT 20;

-- Challenge 1 - Question 2.3 (Bonus)

SELECT
    rental_date,
    DATE_FORMAT(rental_date, '%W') AS weekday,
    CASE
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday')
        THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

SELECT
    title,
    IFNULL(rental_duration, 'Not Available')
FROM film
ORDER BY title;


-- Challenge 2

-- Challenge 2 - Question 1: Number of films by rating
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Challenge 2 - Question 2: Number of films by rating (highest to lowest)

SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

-- Challenge 2 - Question 1.3: Number of films for each rating sorted descending
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Challenge 2 - Question 2.1: Mean film duration for each rating
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- Challenge 2 - Question 2.2: Ratings with a mean duration over two hours
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Challenge 2 - Question 3 (Bonus): Last names that are not repeated
SELECT
    last_name,
    COUNT(*) AS occurrences
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

