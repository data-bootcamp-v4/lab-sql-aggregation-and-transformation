SELECT database();
USE sakila;

SELECT MAX(length) AS max_duration FROM film;
SELECT MIN(length) AS min_duration FROM film;
SELECT AVG(length) AS avg_duration FROM film;
SELECT FLOOR(avg_duration / 60) AS hours,
ROUND((avg_duration - (avg_duration / 60) * 60)) AS minutes
FROM
(
    SELECT AVG(length) AS avg_duration
    FROM film
) AS derived;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM rental;

ALTER TABLE rental
ADD COLUMN month DATE
LIMIT 20;

ALTER TABLE rental
ADD COLUMN weekday DATE
LIMIT 20;

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration FROM film
ORDER BY title ASC;

SELECT COUNT(distinct(title)) FROM film;
SELECT 
    rating, 
    COUNT(*) AS film_count 
FROM 
    film 
GROUP BY 
    rating;

SELECT 
    rating, 
    COUNT(*) AS film_count 
FROM 
    film 
GROUP BY 
    rating
ORDER BY film_count DESC;

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration,
    COUNT(*) AS film_count 
FROM 
    film 
GROUP BY 
    rating 
ORDER BY 
    mean_duration DESC;
    
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration,  -- Average length, rounded to 2 decimal places
    COUNT(*) AS film_count  -- Count of films in each group
FROM 
    film 
GROUP BY 
    rating  -- Group by 'rating'
HAVING 
    AVG(length) > 120  -- Filter for ratings where the mean duration is over 120 minutes
ORDER BY 
    mean_duration DESC;  -- Sort by 'mean_duration' in descending order



