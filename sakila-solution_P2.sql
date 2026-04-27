-- Challenge 2 - sakila_solution_P2.sql

-- Part 1: Total films
SELECT COUNT(*) FROM film;
-- Number of films per rating sorted
SELECT rating, COUNT(*) AS num_films FROM film 
GROUP BY rating 
ORDER BY num_films DESC;

-- Part 2: Mean length by rating
SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

-- Get ratings with mean duration >120 min
SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM film 
GROUP BY rating 
HAVING mean_duration > 120;

-- Bonus: Actors with unique last names (see lab 02)
SELECT last_name FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;